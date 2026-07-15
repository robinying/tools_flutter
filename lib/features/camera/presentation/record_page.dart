import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/l10n/l10n_ext.dart';
import '../../../core/theme/app_theme.dart';
import 'providers/gallery_providers.dart';

class RecordPage extends ConsumerStatefulWidget {
  const RecordPage({super.key});
  @override
  ConsumerState<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends ConsumerState<RecordPage> {
  CameraController? _controller;
  String? _error;
  bool _recording = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final cam = await Permission.camera.request();
    final mic = await Permission.microphone.request();
    if (!mounted) return;
    if (!cam.isGranted) {
      setState(() => _error = context.l10n.cameraPermissionDenied);
      return;
    }
    if (!mic.isGranted) {
      setState(() => _error = context.l10n.micPermissionDenied);
      return;
    }
    try {
      final cams = await availableCameras();
      if (cams.isEmpty) {
        setState(() => _error = context.l10n.noCamera);
        return;
      }
      final c = CameraController(
        cams.first,
        ResolutionPreset.high,
        enableAudio: true,
      );
      await c.initialize();
      if (!mounted) {
        await c.dispose();
        return;
      }
      setState(() => _controller = c);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  Future<void> _toggle() async {
    final c = _controller;
    if (c == null) return;
    if (_recording) {
      final file = await c.stopVideoRecording();
      setState(() => _recording = false);
      final result =
          await ref.read(galleryRepositoryProvider).saveVideo(file.path);
      if (!mounted) return;
      final l = context.l10n;
      result.fold(
        onSuccess: (uri) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(uri != null ? l.videoSaved : file.path)),
          );
        },
        onFailure: (f) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(f.displayMessage)),
          );
        },
      );
    } else {
      await c.startVideoRecording();
      setState(() => _recording = true);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l.recordTitle)),
      body: _error != null
          ? Center(child: Text(_error!))
          : _controller == null || !_controller!.value.isInitialized
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(child: CameraPreview(_controller!)),
                    Padding(
                      padding: const EdgeInsets.all(AppDimens.lg),
                      child: FilledButton(
                        onPressed: _toggle,
                        child: Text(_recording ? l.stop : l.record),
                      ),
                    ),
                  ],
                ),
    );
  }
}
