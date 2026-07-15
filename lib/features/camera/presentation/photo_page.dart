import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/platform/native_bridge.dart';
import '../../../core/theme/app_theme.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({super.key});
  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
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
      setState(() => _error = 'Camera permission denied');
      return;
    }
    try {
      final cams = await availableCameras();
      if (cams.isEmpty) {
        setState(() => _error = 'No camera');
        return;
      }
      final c = CameraController(cams.first, ResolutionPreset.high, enableAudio: false);
      await c.initialize();
      if (!mounted) return;
      setState(() => _controller = c);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  Future<void> _shoot() async {
    final c = _controller;
    if (c == null || _busy) return;
    setState(() => _busy = true);
    try {
      final file = await c.takePicture();
      final uri = await NativeBridge.saveImage(file.path);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(uri != null ? 'Photo saved' : 'Saved ${file.path}')),
        );
      }
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
    return Scaffold(
      appBar: AppBar(title: const Text('Take Photo')),
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
                        child: Text(_busy ? 'Saving…' : 'Capture'),
                      ),
                    ),
                  ],
                ),
    );
  }
}
