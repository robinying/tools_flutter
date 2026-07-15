import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/feature_card.dart';

class CameraHomePage extends StatelessWidget {
  const CameraHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: ListView(
        padding: const EdgeInsets.all(AppDimens.lg),
        children: [
          FeatureCard(
            title: 'Take Photo',
            description: 'Capture a still with camera',
            icon: Icons.photo_camera_outlined,
            onTap: () => context.push('/camera/photo'),
          ),
          const SizedBox(height: AppDimens.md),
          FeatureCard(
            title: 'Record Video',
            description: 'Record a video clip',
            icon: Icons.videocam_outlined,
            onTap: () => context.push('/camera/record'),
          ),
          const SizedBox(height: AppDimens.md),
          FeatureCard(
            title: 'Text to Video',
            description: 'Generate a text card MP4',
            icon: Icons.text_fields,
            onTap: () => context.push('/camera/text'),
          ),
          const SizedBox(height: AppDimens.md),
          FeatureCard(
            title: 'Photo Slideshow',
            description: 'Combine photos into a short video',
            icon: Icons.photo_library_outlined,
            onTap: () => context.push('/camera/slideshow'),
          ),
          const SizedBox(height: AppDimens.md),
          FeatureCard(
            title: 'Edit / Trim helpers',
            description: 'Use Media tools for speed, crop, reverse…',
            icon: Icons.edit_outlined,
            onTap: () => context.push('/media'),
          ),
        ],
      ),
    );
  }
}
