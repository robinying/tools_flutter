import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Tools Flutter'**
  String get appTitle;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Media · Camera · Ebook · Light Meter · Face'**
  String get appTagline;

  /// No description provided for @sectionCreateEdit.
  ///
  /// In en, this message translates to:
  /// **'Create & Edit'**
  String get sectionCreateEdit;

  /// No description provided for @sectionUtilities.
  ///
  /// In en, this message translates to:
  /// **'Utilities'**
  String get sectionUtilities;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get languageSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageChinese.
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get languageChinese;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get languageFrench;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get languageGerman;

  /// No description provided for @languageItalian.
  ///
  /// In en, this message translates to:
  /// **'Italiano'**
  String get languageItalian;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get languageSpanish;

  /// No description provided for @languagePortuguese.
  ///
  /// In en, this message translates to:
  /// **'Português'**
  String get languagePortuguese;

  /// No description provided for @featureCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get featureCamera;

  /// No description provided for @featureCameraDesc.
  ///
  /// In en, this message translates to:
  /// **'Record, edit, photo, text-to-video, slideshow'**
  String get featureCameraDesc;

  /// No description provided for @featureMedia.
  ///
  /// In en, this message translates to:
  /// **'Media Editor'**
  String get featureMedia;

  /// No description provided for @featureMediaDesc.
  ///
  /// In en, this message translates to:
  /// **'Compress, audio tools, speed, merge, crop…'**
  String get featureMediaDesc;

  /// No description provided for @featureEbook.
  ///
  /// In en, this message translates to:
  /// **'Ebook Converter'**
  String get featureEbook;

  /// No description provided for @featureEbookDesc.
  ///
  /// In en, this message translates to:
  /// **'EPUB to PDF'**
  String get featureEbookDesc;

  /// No description provided for @featureLight.
  ///
  /// In en, this message translates to:
  /// **'Light Meter'**
  String get featureLight;

  /// No description provided for @featureLightDesc.
  ///
  /// In en, this message translates to:
  /// **'Ambient lux, scene, snapshots'**
  String get featureLightDesc;

  /// No description provided for @featureFace.
  ///
  /// In en, this message translates to:
  /// **'Face Compare'**
  String get featureFace;

  /// No description provided for @featureFaceDesc.
  ///
  /// In en, this message translates to:
  /// **'Compare face similarity (geometric)'**
  String get featureFaceDesc;

  /// No description provided for @cameraTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get cameraTitle;

  /// No description provided for @cameraPhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get cameraPhoto;

  /// No description provided for @cameraPhotoDesc.
  ///
  /// In en, this message translates to:
  /// **'Capture a still with camera'**
  String get cameraPhotoDesc;

  /// No description provided for @cameraRecord.
  ///
  /// In en, this message translates to:
  /// **'Record Video'**
  String get cameraRecord;

  /// No description provided for @cameraRecordDesc.
  ///
  /// In en, this message translates to:
  /// **'Record a video clip'**
  String get cameraRecordDesc;

  /// No description provided for @cameraText.
  ///
  /// In en, this message translates to:
  /// **'Text to Video'**
  String get cameraText;

  /// No description provided for @cameraTextDesc.
  ///
  /// In en, this message translates to:
  /// **'Generate a text card MP4'**
  String get cameraTextDesc;

  /// No description provided for @cameraSlideshow.
  ///
  /// In en, this message translates to:
  /// **'Photo Slideshow'**
  String get cameraSlideshow;

  /// No description provided for @cameraSlideshowDesc.
  ///
  /// In en, this message translates to:
  /// **'Combine photos into a short video'**
  String get cameraSlideshowDesc;

  /// No description provided for @cameraEditHelpers.
  ///
  /// In en, this message translates to:
  /// **'Edit / Trim helpers'**
  String get cameraEditHelpers;

  /// No description provided for @cameraEditHelpersDesc.
  ///
  /// In en, this message translates to:
  /// **'Use Media tools for speed, crop, reverse…'**
  String get cameraEditHelpersDesc;

  /// No description provided for @photoTitle.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get photoTitle;

  /// No description provided for @recordTitle.
  ///
  /// In en, this message translates to:
  /// **'Record Video'**
  String get recordTitle;

  /// No description provided for @textVideoTitle.
  ///
  /// In en, this message translates to:
  /// **'Text to Video'**
  String get textVideoTitle;

  /// No description provided for @slideshowTitle.
  ///
  /// In en, this message translates to:
  /// **'Photo Slideshow'**
  String get slideshowTitle;

  /// No description provided for @capture.
  ///
  /// In en, this message translates to:
  /// **'Capture'**
  String get capture;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get saving;

  /// No description provided for @record.
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get record;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @photoSaved.
  ///
  /// In en, this message translates to:
  /// **'Photo saved'**
  String get photoSaved;

  /// No description provided for @videoSaved.
  ///
  /// In en, this message translates to:
  /// **'Video saved'**
  String get videoSaved;

  /// No description provided for @cameraPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Camera permission denied'**
  String get cameraPermissionDenied;

  /// No description provided for @micPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Microphone permission denied'**
  String get micPermissionDenied;

  /// No description provided for @noCamera.
  ///
  /// In en, this message translates to:
  /// **'No camera'**
  String get noCamera;

  /// No description provided for @durationSeconds.
  ///
  /// In en, this message translates to:
  /// **'Duration: {seconds} s'**
  String durationSeconds(int seconds);

  /// No description provided for @textLabel.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get textLabel;

  /// No description provided for @generateVideo.
  ///
  /// In en, this message translates to:
  /// **'Generate video'**
  String get generateVideo;

  /// No description provided for @generating.
  ///
  /// In en, this message translates to:
  /// **'Generating…'**
  String get generating;

  /// No description provided for @textVideoSaved.
  ///
  /// In en, this message translates to:
  /// **'Text video saved'**
  String get textVideoSaved;

  /// No description provided for @gallerySaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Encoded but gallery save failed'**
  String get gallerySaveFailed;

  /// No description provided for @selectPhotos.
  ///
  /// In en, this message translates to:
  /// **'Select photos'**
  String get selectPhotos;

  /// No description provided for @photosSelected.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String photosSelected(int count);

  /// No description provided for @secondsPerPhoto.
  ///
  /// In en, this message translates to:
  /// **'Seconds per photo'**
  String get secondsPerPhoto;

  /// No description provided for @generateSlideshow.
  ///
  /// In en, this message translates to:
  /// **'Generate slideshow'**
  String get generateSlideshow;

  /// No description provided for @slideshowSaved.
  ///
  /// In en, this message translates to:
  /// **'Slideshow saved'**
  String get slideshowSaved;

  /// No description provided for @selectAtLeast2Photos.
  ///
  /// In en, this message translates to:
  /// **'Select at least 2 photos'**
  String get selectAtLeast2Photos;

  /// No description provided for @mediaEditorTitle.
  ///
  /// In en, this message translates to:
  /// **'Media Editor'**
  String get mediaEditorTitle;

  /// No description provided for @selectFile.
  ///
  /// In en, this message translates to:
  /// **'Select file'**
  String get selectFile;

  /// No description provided for @reselect.
  ///
  /// In en, this message translates to:
  /// **'Reselect ({count})'**
  String reselect(int count);

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @selectAtLeast2Videos.
  ///
  /// In en, this message translates to:
  /// **'Select at least 2 videos'**
  String get selectAtLeast2Videos;

  /// No description provided for @savedUri.
  ///
  /// In en, this message translates to:
  /// **'Saved: {uri}'**
  String savedUri(String uri);

  /// No description provided for @encodedGalleryFailed.
  ///
  /// In en, this message translates to:
  /// **'Encoded but gallery save failed: {path}'**
  String encodedGalleryFailed(String path);

  /// No description provided for @qualityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get qualityLow;

  /// No description provided for @qualityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get qualityMedium;

  /// No description provided for @qualityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get qualityHigh;

  /// No description provided for @mute.
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get mute;

  /// No description provided for @keepAudio.
  ///
  /// In en, this message translates to:
  /// **'Keep audio'**
  String get keepAudio;

  /// No description provided for @toolVideoCompress.
  ///
  /// In en, this message translates to:
  /// **'Video Compress'**
  String get toolVideoCompress;

  /// No description provided for @toolVideoCompressDesc.
  ///
  /// In en, this message translates to:
  /// **'Compress video with FFmpeg'**
  String get toolVideoCompressDesc;

  /// No description provided for @toolImageCompress.
  ///
  /// In en, this message translates to:
  /// **'Image Compress'**
  String get toolImageCompress;

  /// No description provided for @toolImageCompressDesc.
  ///
  /// In en, this message translates to:
  /// **'Compress images'**
  String get toolImageCompressDesc;

  /// No description provided for @toolGif.
  ///
  /// In en, this message translates to:
  /// **'Video to GIF'**
  String get toolGif;

  /// No description provided for @toolGifDesc.
  ///
  /// In en, this message translates to:
  /// **'Convert video to animated GIF'**
  String get toolGifDesc;

  /// No description provided for @toolExtractAudio.
  ///
  /// In en, this message translates to:
  /// **'Extract Audio'**
  String get toolExtractAudio;

  /// No description provided for @toolExtractAudioDesc.
  ///
  /// In en, this message translates to:
  /// **'Export AAC/M4A track'**
  String get toolExtractAudioDesc;

  /// No description provided for @toolStripAudio.
  ///
  /// In en, this message translates to:
  /// **'Remove Audio'**
  String get toolStripAudio;

  /// No description provided for @toolStripAudioDesc.
  ///
  /// In en, this message translates to:
  /// **'Export video without sound'**
  String get toolStripAudioDesc;

  /// No description provided for @toolTranscode.
  ///
  /// In en, this message translates to:
  /// **'Transcode to MP4'**
  String get toolTranscode;

  /// No description provided for @toolTranscodeDesc.
  ///
  /// In en, this message translates to:
  /// **'Convert to MP4'**
  String get toolTranscodeDesc;

  /// No description provided for @toolSpeed.
  ///
  /// In en, this message translates to:
  /// **'Speed Change'**
  String get toolSpeed;

  /// No description provided for @toolSpeedDesc.
  ///
  /// In en, this message translates to:
  /// **'0.5x / 1.5x / 2x'**
  String get toolSpeedDesc;

  /// No description provided for @toolReverse.
  ///
  /// In en, this message translates to:
  /// **'Reverse Video'**
  String get toolReverse;

  /// No description provided for @toolReverseDesc.
  ///
  /// In en, this message translates to:
  /// **'Play backwards'**
  String get toolReverseDesc;

  /// No description provided for @toolMerge.
  ///
  /// In en, this message translates to:
  /// **'Merge Videos'**
  String get toolMerge;

  /// No description provided for @toolMergeDesc.
  ///
  /// In en, this message translates to:
  /// **'Join clips in order'**
  String get toolMergeDesc;

  /// No description provided for @toolCrop.
  ///
  /// In en, this message translates to:
  /// **'Crop Aspect'**
  String get toolCrop;

  /// No description provided for @toolCropDesc.
  ///
  /// In en, this message translates to:
  /// **'1:1 / 9:16 / 16:9'**
  String get toolCropDesc;

  /// No description provided for @toolVolumeFade.
  ///
  /// In en, this message translates to:
  /// **'Volume and Fade'**
  String get toolVolumeFade;

  /// No description provided for @toolVolumeFadeDesc.
  ///
  /// In en, this message translates to:
  /// **'Volume + fade in/out'**
  String get toolVolumeFadeDesc;

  /// No description provided for @lightTitle.
  ///
  /// In en, this message translates to:
  /// **'Light Meter'**
  String get lightTitle;

  /// No description provided for @lightHistory.
  ///
  /// In en, this message translates to:
  /// **'Snapshots'**
  String get lightHistory;

  /// No description provided for @lightNoSensor.
  ///
  /// In en, this message translates to:
  /// **'No light sensor'**
  String get lightNoSensor;

  /// No description provided for @lightNoSensorBody.
  ///
  /// In en, this message translates to:
  /// **'This device does not report ambient light (TYPE_LIGHT).'**
  String get lightNoSensorBody;

  /// No description provided for @lightSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved: {lux} lux'**
  String lightSaved(String lux);

  /// No description provided for @lightSavedWithNote.
  ///
  /// In en, this message translates to:
  /// **'Saved: {lux} lux — {note}'**
  String lightSavedWithNote(String lux, String note);

  /// No description provided for @lightSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {error}'**
  String lightSaveFailed(String error);

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteHint;

  /// No description provided for @saveSnapshot.
  ///
  /// In en, this message translates to:
  /// **'Save snapshot'**
  String get saveSnapshot;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No snapshots yet'**
  String get historyEmpty;

  /// No description provided for @faceTitle.
  ///
  /// In en, this message translates to:
  /// **'Face Compare'**
  String get faceTitle;

  /// No description provided for @facePickA.
  ///
  /// In en, this message translates to:
  /// **'Photo A'**
  String get facePickA;

  /// No description provided for @facePickB.
  ///
  /// In en, this message translates to:
  /// **'Photo B'**
  String get facePickB;

  /// No description provided for @faceCompare.
  ///
  /// In en, this message translates to:
  /// **'Compare'**
  String get faceCompare;

  /// No description provided for @faceBusy.
  ///
  /// In en, this message translates to:
  /// **'Comparing…'**
  String get faceBusy;

  /// No description provided for @faceNoFace.
  ///
  /// In en, this message translates to:
  /// **'No face detected'**
  String get faceNoFace;

  /// No description provided for @faceSimilarity.
  ///
  /// In en, this message translates to:
  /// **'Similarity: {percent}%'**
  String faceSimilarity(String percent);

  /// No description provided for @faceDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Geometric similarity only — not biometric ID verification.'**
  String get faceDisclaimer;

  /// No description provided for @ebookTitle.
  ///
  /// In en, this message translates to:
  /// **'Ebook Converter'**
  String get ebookTitle;

  /// No description provided for @ebookPick.
  ///
  /// In en, this message translates to:
  /// **'Select EPUB'**
  String get ebookPick;

  /// No description provided for @ebookConvert.
  ///
  /// In en, this message translates to:
  /// **'Convert to PDF'**
  String get ebookConvert;

  /// No description provided for @ebookBusy.
  ///
  /// In en, this message translates to:
  /// **'Converting…'**
  String get ebookBusy;

  /// No description provided for @ebookStubNote.
  ///
  /// In en, this message translates to:
  /// **'Stub conversion: single info page PDF (not full EPUB layout).'**
  String get ebookStubNote;

  /// No description provided for @jobStarting.
  ///
  /// In en, this message translates to:
  /// **'Starting…'**
  String get jobStarting;

  /// No description provided for @commonError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get commonError;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'pt',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
