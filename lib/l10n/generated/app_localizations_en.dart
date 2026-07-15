// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tools Flutter';

  @override
  String get appName => 'Tools';

  @override
  String get appTagline => 'Media · Camera · Ebook · Light Meter · Face';

  @override
  String get sectionCreateEdit => 'Create & Edit';

  @override
  String get sectionUtilities => 'Utilities';

  @override
  String get language => 'Language';

  @override
  String get languageSystem => 'System';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageChinese => '中文';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languagePortuguese => 'Português';

  @override
  String get featureCamera => 'Camera';

  @override
  String get featureCameraDesc =>
      'Record, edit, photo, text-to-video, slideshow';

  @override
  String get featureMedia => 'Media Editor';

  @override
  String get featureMediaDesc => 'Compress, audio tools, speed, merge, crop…';

  @override
  String get featureEbook => 'Ebook Converter';

  @override
  String get featureEbookDesc => 'EPUB to PDF';

  @override
  String get featureLight => 'Light Meter';

  @override
  String get featureLightDesc => 'Ambient lux, scene, snapshots';

  @override
  String get featureFace => 'Face Compare';

  @override
  String get featureFaceDesc => 'Compare face similarity (geometric)';

  @override
  String get cameraTitle => 'Camera';

  @override
  String get cameraPhoto => 'Take Photo';

  @override
  String get cameraPhotoDesc => 'Capture a still with camera';

  @override
  String get cameraRecord => 'Record Video';

  @override
  String get cameraRecordDesc => 'Record a video clip';

  @override
  String get cameraText => 'Text to Video';

  @override
  String get cameraTextDesc => 'Generate a text card MP4';

  @override
  String get cameraSlideshow => 'Photo Slideshow';

  @override
  String get cameraSlideshowDesc => 'Combine photos into a short video';

  @override
  String get cameraEditHelpers => 'Edit / Trim helpers';

  @override
  String get cameraEditHelpersDesc =>
      'Use Media tools for speed, crop, reverse…';

  @override
  String get photoTitle => 'Take Photo';

  @override
  String get recordTitle => 'Record Video';

  @override
  String get textVideoTitle => 'Text to Video';

  @override
  String get slideshowTitle => 'Photo Slideshow';

  @override
  String get capture => 'Capture';

  @override
  String get saving => 'Saving…';

  @override
  String get record => 'Record';

  @override
  String get stop => 'Stop';

  @override
  String get photoSaved => 'Photo saved';

  @override
  String get videoSaved => 'Video saved';

  @override
  String get cameraPermissionDenied => 'Camera permission denied';

  @override
  String get micPermissionDenied => 'Microphone permission denied';

  @override
  String get noCamera => 'No camera';

  @override
  String durationSeconds(int seconds) {
    return 'Duration: $seconds s';
  }

  @override
  String get textLabel => 'Text';

  @override
  String get generateVideo => 'Generate video';

  @override
  String get generating => 'Generating…';

  @override
  String get textVideoSaved => 'Text video saved';

  @override
  String get gallerySaveFailed => 'Encoded but gallery save failed';

  @override
  String get selectPhotos => 'Select photos';

  @override
  String photosSelected(int count) {
    return '$count selected';
  }

  @override
  String get secondsPerPhoto => 'Seconds per photo';

  @override
  String get generateSlideshow => 'Generate slideshow';

  @override
  String get slideshowSaved => 'Slideshow saved';

  @override
  String get selectAtLeast2Photos => 'Select at least 2 photos';

  @override
  String get mediaEditorTitle => 'Media Editor';

  @override
  String get selectFile => 'Select file';

  @override
  String reselect(int count) {
    return 'Reselect ($count)';
  }

  @override
  String get options => 'Options';

  @override
  String get start => 'Start';

  @override
  String get cancel => 'Cancel';

  @override
  String get selectAtLeast2Videos => 'Select at least 2 videos';

  @override
  String savedUri(String uri) {
    return 'Saved: $uri';
  }

  @override
  String encodedGalleryFailed(String path) {
    return 'Encoded but gallery save failed: $path';
  }

  @override
  String get qualityLow => 'Low';

  @override
  String get qualityMedium => 'Medium';

  @override
  String get qualityHigh => 'High';

  @override
  String get mute => 'Mute';

  @override
  String get keepAudio => 'Keep audio';

  @override
  String get toolVideoCompress => 'Video Compress';

  @override
  String get toolVideoCompressDesc => 'Compress video with FFmpeg';

  @override
  String get toolImageCompress => 'Image Compress';

  @override
  String get toolImageCompressDesc => 'Compress images';

  @override
  String get toolGif => 'Video to GIF';

  @override
  String get toolGifDesc => 'Convert video to animated GIF';

  @override
  String get toolExtractAudio => 'Extract Audio';

  @override
  String get toolExtractAudioDesc => 'Export AAC/M4A track';

  @override
  String get toolStripAudio => 'Remove Audio';

  @override
  String get toolStripAudioDesc => 'Export video without sound';

  @override
  String get toolTranscode => 'Transcode to MP4';

  @override
  String get toolTranscodeDesc => 'Convert to MP4';

  @override
  String get toolSpeed => 'Speed Change';

  @override
  String get toolSpeedDesc => '0.5x / 1.5x / 2x';

  @override
  String get toolReverse => 'Reverse Video';

  @override
  String get toolReverseDesc => 'Play backwards';

  @override
  String get toolMerge => 'Merge Videos';

  @override
  String get toolMergeDesc => 'Join clips in order';

  @override
  String get toolCrop => 'Crop Aspect';

  @override
  String get toolCropDesc => '1:1 / 9:16 / 16:9';

  @override
  String get toolVolumeFade => 'Volume and Fade';

  @override
  String get toolVolumeFadeDesc => 'Volume + fade in/out';

  @override
  String get lightTitle => 'Light Meter';

  @override
  String get lightHistory => 'Snapshots';

  @override
  String get lightNoSensor => 'No light sensor';

  @override
  String get lightNoSensorBody =>
      'This device does not report ambient light (TYPE_LIGHT).';

  @override
  String lightSaved(String lux) {
    return 'Saved: $lux lux';
  }

  @override
  String lightSavedWithNote(String lux, String note) {
    return 'Saved: $lux lux — $note';
  }

  @override
  String lightSaveFailed(String error) {
    return 'Save failed: $error';
  }

  @override
  String get noteHint => 'Note (optional)';

  @override
  String get saveSnapshot => 'Save snapshot';

  @override
  String get historyEmpty => 'No snapshots yet';

  @override
  String get faceTitle => 'Face Compare';

  @override
  String get facePickA => 'Photo A';

  @override
  String get facePickB => 'Photo B';

  @override
  String get faceCompare => 'Compare';

  @override
  String get faceBusy => 'Comparing…';

  @override
  String get faceNoFace => 'No face detected';

  @override
  String faceSimilarity(String percent) {
    return 'Similarity: $percent%';
  }

  @override
  String get faceDisclaimer =>
      'Geometric similarity only — not biometric ID verification.';

  @override
  String get ebookTitle => 'Ebook Converter';

  @override
  String get ebookPick => 'Select EPUB';

  @override
  String get ebookConvert => 'Convert to PDF';

  @override
  String get ebookBusy => 'Converting…';

  @override
  String get ebookStubNote =>
      'Stub conversion: single info page PDF (not full EPUB layout).';

  @override
  String get jobStarting => 'Starting…';

  @override
  String get commonError => 'Error';

  @override
  String get commonOk => 'OK';
}
