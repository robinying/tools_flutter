import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/l10n_ext.dart';
import '../../core/l10n/locale_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/feature_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final localeOverride = ref.watch(localeControllerProvider);
    final localeCode = localeOverride?.languageCode ?? 'system';

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppDimens.lg),
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: PopupMenuButton<String>(
                tooltip: l.language,
                initialValue: localeCode,
                onSelected: (code) {
                  ref.read(localeControllerProvider.notifier).setLocaleCode(code);
                },
                itemBuilder: (ctx) => [
                  PopupMenuItem(value: 'system', child: Text(l.languageSystem)),
                  PopupMenuItem(value: 'en', child: Text(l.languageEnglish)),
                  PopupMenuItem(value: 'zh', child: Text(l.languageChinese)),
                  PopupMenuItem(value: 'fr', child: Text(l.languageFrench)),
                  PopupMenuItem(value: 'de', child: Text(l.languageGerman)),
                  PopupMenuItem(value: 'it', child: Text(l.languageItalian)),
                  PopupMenuItem(value: 'es', child: Text(l.languageSpanish)),
                  PopupMenuItem(value: 'pt', child: Text(l.languagePortuguese)),
                ],
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.sm),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.language, size: 20),
                      const SizedBox(width: 4),
                      Text(l.language, style: Theme.of(context).textTheme.labelLarge),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimens.md),
            Text(
              l.appName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppDimens.sm),
            Text(
              l.appTagline,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: AppDimens.xl),
            Text(l.sectionCreateEdit, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppDimens.sm),
            FeatureCard(
              title: l.featureCamera,
              description: l.featureCameraDesc,
              icon: Icons.videocam_outlined,
              onTap: () => context.push('/camera'),
            ),
            const SizedBox(height: AppDimens.md),
            FeatureCard(
              title: l.featureMedia,
              description: l.featureMediaDesc,
              icon: Icons.movie_filter_outlined,
              onTap: () => context.push('/media'),
            ),
            const SizedBox(height: AppDimens.xl),
            Text(l.sectionUtilities, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppDimens.sm),
            FeatureCard(
              title: l.featureEbook,
              description: l.featureEbookDesc,
              icon: Icons.menu_book_outlined,
              onTap: () => context.push('/ebook'),
            ),
            const SizedBox(height: AppDimens.md),
            FeatureCard(
              title: l.featureLight,
              description: l.featureLightDesc,
              icon: Icons.light_mode_outlined,
              onTap: () => context.push('/light'),
            ),
            const SizedBox(height: AppDimens.md),
            FeatureCard(
              title: l.featureFace,
              description: l.featureFaceDesc,
              icon: Icons.face_outlined,
              onTap: () => context.push('/face'),
            ),
          ],
        ),
      ),
    );
  }
}
