import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n_ext.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/feature_card.dart';

class CameraHomePage extends StatelessWidget {
  const CameraHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l.cameraTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppDimens.lg),
        children: [
          FeatureCard(
            title: l.cameraPhoto,
            description: l.cameraPhotoDesc,
            icon: Icons.photo_camera_outlined,
            onTap: () => context.push('/camera/photo'),
          ),
          const SizedBox(height: AppDimens.md),
          FeatureCard(
            title: l.cameraRecord,
            description: l.cameraRecordDesc,
            icon: Icons.videocam_outlined,
            onTap: () => context.push('/camera/record'),
          ),
          const SizedBox(height: AppDimens.md),
          FeatureCard(
            title: l.cameraText,
            description: l.cameraTextDesc,
            icon: Icons.text_fields,
            onTap: () => context.push('/camera/text'),
          ),
          const SizedBox(height: AppDimens.md),
          FeatureCard(
            title: l.cameraSlideshow,
            description: l.cameraSlideshowDesc,
            icon: Icons.photo_library_outlined,
            onTap: () => context.push('/camera/slideshow'),
          ),
          const SizedBox(height: AppDimens.md),
          FeatureCard(
            title: l.cameraEditHelpers,
            description: l.cameraEditHelpersDesc,
            icon: Icons.edit_outlined,
            onTap: () => context.push('/media'),
          ),
        ],
      ),
    );
  }
}
