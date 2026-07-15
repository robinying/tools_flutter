import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TextOptionChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool enabled;

  const TextOptionChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: enabled ? (_) => onTap() : null,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.md, vertical: AppDimens.sm),
    );
  }
}
