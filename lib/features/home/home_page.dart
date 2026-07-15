import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/feature_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppDimens.lg),
          children: [
            const SizedBox(height: AppDimens.xl),
            Text('Tools', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppDimens.sm),
            Text(
              'Media · Camera · Ebook · Light Meter · Face',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: AppDimens.xl),
            Text('Create & Edit', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppDimens.sm),
            FeatureCard(
              title: 'Camera',
              description: 'Record, edit, photo, text-to-video, slideshow',
              icon: Icons.videocam_outlined,
              onTap: () => context.push('/camera'),
            ),
            const SizedBox(height: AppDimens.md),
            FeatureCard(
              title: 'Media Editor',
              description: 'Compress, audio tools, speed, merge, crop…',
              icon: Icons.movie_filter_outlined,
              onTap: () => context.push('/media'),
            ),
            const SizedBox(height: AppDimens.xl),
            Text('Utilities', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppDimens.sm),
            FeatureCard(
              title: 'Ebook Converter',
              description: 'EPUB to PDF',
              icon: Icons.menu_book_outlined,
              onTap: () => context.push('/ebook'),
            ),
            const SizedBox(height: AppDimens.md),
            FeatureCard(
              title: 'Light Meter',
              description: 'Ambient lux, scene, snapshots',
              icon: Icons.light_mode_outlined,
              onTap: () => context.push('/light'),
            ),
            const SizedBox(height: AppDimens.md),
            FeatureCard(
              title: 'Face Compare',
              description: 'Compare face similarity',
              icon: Icons.face_outlined,
              onTap: () => context.push('/face'),
            ),
          ],
        ),
      ),
    );
  }
}
