import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/platform/native_bridge.dart';
import '../../../core/theme/app_theme.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});
  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  CameraController? _controller;
  String? _error;
  bool _recording = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Permission.camera.request();
    await Permission.microphone.request();
    try {
      final cams = await availableCameras();
      final c = CameraController(cams.first, ResolutionPreset.high, enableAudio: true);
      await c.initialize();
      if (mounted) setState(() => _controller = c);
    } catch (e) {
      setState(() => _error = '$e');
    }
  }

  Future<void> _toggle() async {
    final c = _controller;
    if (c == null) return;
    if (_recording) {
      final file = await c.stopVideoRecording();
      setState(() => _recording = false);
      final uri = await NativeBridge.saveVideo(file.path);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(uri != null ? 'Video saved' : file.path)),
        );
      }
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
    return Scaffold(
      appBar: AppBar(title: const Text('Record Video')),
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
                        child: Text(_recording ? 'Stop' : 'Record'),
                      ),
                    ),
                  ],
                ),
    );
  }
}
