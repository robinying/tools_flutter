import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/l10n/l10n_ext.dart';
import '../../../core/theme/app_theme.dart';
import 'providers/gallery_providers.dart';

class PhotoPage extends ConsumerStatefulWidget {
  const PhotoPage({super.key});
  @override
  ConsumerState<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends ConsumerState<PhotoPage> {
  CameraController? _controller;
  String? _error;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final cam = await Permission.camera.request();
    if (!cam.isGranted) {
      if (!mounted) return;
      setState(() => _error = context.l10n.cameraPermissionDenied);
      return;
    }
    try {
      final cams = await availableCameras();
      if (cams.isEmpty) {
        if (!mounted) return;
        setState(() => _error = context.l10n.noCamera);
        return;
      }
      final c = CameraController(cams.first, ResolutionPreset.high, enableAudio: false);
      await c.initialize();
      if (!mounted) return;
      setState(() => _controller = c);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  Future<void> _shoot() async {
    final c = _controller;
    if (c == null || _busy) return;
    setState(() => _busy = true);
    try {
      final file = await c.takePicture();
      final result =
          await ref.read(galleryRepositoryProvider).saveImage(file.path);
      if (!mounted) return;
      final l = context.l10n;
      result.fold(
        onSuccess: (uri) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(uri != null ? l.photoSaved : file.path)),
          );
        },
        onFailure: (f) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(f.displayMessage)),
          );
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
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
      appBar: AppBar(title: Text(l.photoTitle)),
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
                        onPressed: _busy ? null : _shoot,
                        child: Text(_busy ? l.saving : l.capture),
                      ),
                    ),
                  ],
                ),
    );
  }
}
