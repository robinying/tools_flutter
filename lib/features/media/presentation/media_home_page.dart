import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/feature_card.dart';
import '../domain/entities/media_tool.dart';

class MediaHomePage extends StatelessWidget {
  const MediaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Media Editor')),
      body: ListView(
        padding: const EdgeInsets.all(AppDimens.lg),
        children: [
          for (final t in MediaToolType.values) ...[
            FeatureCard(
              title: t.title,
              description: t.description,
              icon: Icons.video_library_outlined,
              onTap: () => context.push('/media/tool/${t.id}'),
            ),
            const SizedBox(height: AppDimens.md),
          ],
        ],
      ),
    );
  }
}
