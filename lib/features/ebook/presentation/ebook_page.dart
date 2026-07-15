import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../core/platform/native_bridge.dart';
import '../../../core/theme/app_theme.dart';

class EbookPage extends StatefulWidget {
  const EbookPage({super.key});
  @override
  State<EbookPage> createState() => _EbookPageState();
}

class _EbookPageState extends State<EbookPage> {
  String? _path;
  bool _busy = false;

  Future<void> _pick() async {
    final r = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['epub'],
    );
    if (r == null || r.paths.isEmpty) return;
    setState(() => _path = r.paths.first);
  }

  Future<void> _convert() async {
    final p = _path;
    if (p == null) return;
    setState(() => _busy = true);
    try {
      final out = await NativeBridge.convertEpub(p);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF ready: $out')),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ebook Converter')),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Convert EPUB to PDF (Android native stub writes a valid PDF summary page).'),
            const SizedBox(height: AppDimens.lg),
            FilledButton(
              onPressed: _busy ? null : _pick,
              child: Text(_path == null ? 'Select EPUB' : _path!.split('/').last),
            ),
            const Spacer(),
            FilledButton(
              onPressed: _busy || _path == null ? null : _convert,
              child: Text(_busy ? 'Converting…' : 'Convert to PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
