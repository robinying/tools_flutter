import 'dart:async';
import 'package:flutter/services.dart';

class NativeBridge {
  static const _ffmpeg = MethodChannel('com.robin.tools/ffmpeg');
  static const _job = MethodChannel('com.robin.tools/media_job');
  static const _jobEvents = EventChannel('com.robin.tools/media_events');
  static const _light = MethodChannel('com.robin.tools/light_sensor');
  static const _lightEvents = EventChannel('com.robin.tools/light_sensor_events');
  static const _ebook = MethodChannel('com.robin.tools/ebook');
  static const _gallery = MethodChannel('com.robin.tools/gallery');

  static Future<Map<String, dynamic>> runFfmpeg(List<String> args) async {
    final r = await _ffmpeg.invokeMethod('run', {'args': args});
    return Map<String, dynamic>.from(r as Map);
  }

  static Future<void> startMediaJob({
    required String type,
    required List<String> paths,
    required String level,
  }) async {
    await _job.invokeMethod('start', {
      'type': type,
      'paths': paths,
      'level': level,
    });
  }

  static Future<void> cancelMediaJob() => _job.invokeMethod('cancel');

  static Stream<Map<String, dynamic>> mediaJobEvents() {
    return _jobEvents.receiveBroadcastStream().map((e) => Map<String, dynamic>.from(e as Map));
  }

  static Future<bool> lightSensorAvailable() async {
    final r = await _light.invokeMethod('available');
    return r == true;
  }

  static Stream<double> lightSensorStream() {
    return _lightEvents.receiveBroadcastStream().map((e) => (e as num).toDouble());
  }

  static Future<String> convertEpub(String path) async {
    final r = await _ebook.invokeMethod('convert', {'path': path});
    return r as String;
  }

  static Future<String?> saveVideo(String path) async {
    final r = await _gallery.invokeMethod('saveVideo', {'path': path});
    return r as String?;
  }

  static Future<String?> saveImage(String path) async {
    final r = await _gallery.invokeMethod('saveImage', {'path': path});
    return r as String?;
  }

  static Future<String?> saveAudio(String path) async {
    final r = await _gallery.invokeMethod('saveAudio', {'path': path});
    return r as String?;
  }
}
