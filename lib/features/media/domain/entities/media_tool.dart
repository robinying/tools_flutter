/// Catalog of media tools and quality/option levels (domain).
enum MediaToolType {
  videoCompress('videoCompress', 'Video Compress', 'Compress video with FFmpeg', false),
  imageCompress('imageCompress', 'Image Compress', 'Compress images', true),
  gif('gif', 'Video to GIF', 'Convert video to animated GIF', false),
  extractAudio('extractAudio', 'Extract Audio', 'Export AAC/M4A track', false),
  stripAudio('stripAudio', 'Remove Audio', 'Export video without sound', false),
  transcode('transcode', 'Transcode to MP4', 'Convert to MP4', false),
  speed('speed', 'Speed Change', '0.5x / 1.5x / 2x', false),
  reverse('reverse', 'Reverse Video', 'Play backwards', false),
  merge('merge', 'Merge Videos', 'Join clips in order', false, multi: true),
  crop('crop', 'Crop Aspect', '1:1 / 9:16 / 16:9', false),
  volumeFade('volumeFade', 'Volume and Fade', 'Volume + fade in/out', false);

  final String id;
  final String title;
  final String description;
  final bool isImage;
  final bool multi;
  const MediaToolType(
    this.id,
    this.title,
    this.description,
    this.isImage, {
    this.multi = false,
  });

  /// Returns null when [id] is not a known tool (safe for deep links / typos).
  static MediaToolType? tryParse(String? id) {
    if (id == null || id.isEmpty) return null;
    for (final e in MediaToolType.values) {
      if (e.id == id) return e;
    }
    return null;
  }

  /// Throws [ArgumentError] if unknown — prefer [tryParse] at route boundaries.
  static MediaToolType fromId(String id) {
    final parsed = tryParse(id);
    if (parsed == null) {
      throw ArgumentError.value(id, 'id', 'Unknown MediaToolType');
    }
    return parsed;
  }
}

enum QualityLevel {
  low('low'),
  medium('medium'),
  high('high');

  final String id;
  const QualityLevel(this.id);

  String labelFor(MediaToolType type) {
    switch (type) {
      case MediaToolType.speed:
        return switch (this) {
          QualityLevel.low => '0.5x',
          QualityLevel.medium => '1.5x',
          QualityLevel.high => '2x',
        };
      case MediaToolType.reverse:
        return switch (this) {
          QualityLevel.low || QualityLevel.high => 'Mute',
          QualityLevel.medium => 'Keep audio',
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
          QualityLevel.low => 'Low',
          QualityLevel.medium => 'Medium',
          QualityLevel.high => 'High',
        };
    }
  }
}
