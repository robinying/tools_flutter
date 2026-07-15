import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n_ext.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/feature_card.dart';
import '../domain/entities/media_tool.dart';

class MediaHomePage extends StatelessWidget {
  const MediaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l.mediaEditorTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppDimens.lg),
        children: [
          for (final t in MediaToolType.values) ...[
            FeatureCard(
              title: t.titleL10n(l),
              description: t.descriptionL10n(l),
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
