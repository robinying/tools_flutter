import 'package:flutter/widgets.dart';
import 'package:tools_flutter/l10n/generated/app_localizations.dart';

import '../../features/media/domain/entities/media_tool.dart';

export 'package:tools_flutter/l10n/generated/app_localizations.dart';

extension AppL10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension MediaToolTypeL10n on MediaToolType {
  String titleL10n(AppLocalizations l) => switch (this) {
        MediaToolType.videoCompress => l.toolVideoCompress,
        MediaToolType.imageCompress => l.toolImageCompress,
        MediaToolType.gif => l.toolGif,
        MediaToolType.extractAudio => l.toolExtractAudio,
        MediaToolType.stripAudio => l.toolStripAudio,
        MediaToolType.transcode => l.toolTranscode,
        MediaToolType.speed => l.toolSpeed,
        MediaToolType.reverse => l.toolReverse,
        MediaToolType.merge => l.toolMerge,
        MediaToolType.crop => l.toolCrop,
        MediaToolType.volumeFade => l.toolVolumeFade,
      };

  String descriptionL10n(AppLocalizations l) => switch (this) {
        MediaToolType.videoCompress => l.toolVideoCompressDesc,
        MediaToolType.imageCompress => l.toolImageCompressDesc,
        MediaToolType.gif => l.toolGifDesc,
        MediaToolType.extractAudio => l.toolExtractAudioDesc,
        MediaToolType.stripAudio => l.toolStripAudioDesc,
        MediaToolType.transcode => l.toolTranscodeDesc,
        MediaToolType.speed => l.toolSpeedDesc,
        MediaToolType.reverse => l.toolReverseDesc,
        MediaToolType.merge => l.toolMergeDesc,
        MediaToolType.crop => l.toolCropDesc,
        MediaToolType.volumeFade => l.toolVolumeFadeDesc,
      };
}

extension QualityLevelL10n on QualityLevel {
  /// Localized option chip label (keeps numeric ratios like 0.5x / 9:16).
  String labelL10n(AppLocalizations l, MediaToolType type) {
    switch (type) {
      case MediaToolType.speed:
        return switch (this) {
          QualityLevel.low => '0.5x',
          QualityLevel.medium => '1.5x',
          QualityLevel.high => '2x',
        };
      case MediaToolType.reverse:
        return switch (this) {
          QualityLevel.low || QualityLevel.high => l.mute,
          QualityLevel.medium => l.keepAudio,
        };
      case MediaToolType.crop:
        return switch (this) {
          QualityLevel.low => '1:1',
          QualityLevel.medium => '9:16',
          QualityLevel.high => '16:9',
        };
      case MediaToolType.volumeFade:
        return switch (this) {
          QualityLevel.low => '50%',
          QualityLevel.medium => '100%',
          QualityLevel.high => '150%',
        };
      default:
        return switch (this) {
          QualityLevel.low => l.qualityLow,
          QualityLevel.medium => l.qualityMedium,
          QualityLevel.high => l.qualityHigh,
        };
    }
  }
}
