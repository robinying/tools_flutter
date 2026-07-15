// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Tools Flutter';

  @override
  String get appName => 'Tools';

  @override
  String get appTagline => 'Medien · Kamera · Ebook · Lichtmesser · Gesicht';

  @override
  String get sectionCreateEdit => 'Erstellen & Bearbeiten';

  @override
  String get sectionUtilities => 'Werkzeuge';

  @override
  String get language => 'Sprache';

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
  String get featureCamera => 'Kamera';

  @override
  String get featureCameraDesc => 'Foto, Video, Text-zu-Video, Diashow';

  @override
  String get featureMedia => 'Medieneditor';

  @override
  String get featureMediaDesc =>
      'Komprimieren, Audio, Tempo, Zusammenführen, Zuschneiden…';

  @override
  String get featureEbook => 'Ebook-Konverter';

  @override
  String get featureEbookDesc => 'EPUB zu PDF';

  @override
  String get featureLight => 'Lichtmesser';

  @override
  String get featureLightDesc => 'Umgebungs-Lux, Szenen, Snapshots';

  @override
  String get featureFace => 'Gesichtsvergleich';

  @override
  String get featureFaceDesc => 'Geometrische Gesichtsähnlichkeit';

  @override
  String get cameraTitle => 'Kamera';

  @override
  String get cameraPhoto => 'Foto aufnehmen';

  @override
  String get cameraPhotoDesc => 'Standbild mit der Kamera aufnehmen';

  @override
  String get cameraRecord => 'Video aufnehmen';

  @override
  String get cameraRecordDesc => 'Videoclip aufnehmen';

  @override
  String get cameraText => 'Text zu Video';

  @override
  String get cameraTextDesc => 'Textkarte als MP4 erzeugen';

  @override
  String get cameraSlideshow => 'Foto-Diashow';

  @override
  String get cameraSlideshowDesc => 'Fotos zu einem Kurzvideo kombinieren';

  @override
  String get cameraEditHelpers => 'Schnitt-Helfer';

  @override
  String get cameraEditHelpersDesc =>
      'Tempo, Zuschnitt, Rückwärts über Medienwerkzeuge…';

  @override
  String get photoTitle => 'Foto aufnehmen';

  @override
  String get recordTitle => 'Video aufnehmen';

  @override
  String get textVideoTitle => 'Text zu Video';

  @override
  String get slideshowTitle => 'Foto-Diashow';

  @override
  String get capture => 'Aufnehmen';

  @override
  String get saving => 'Speichern…';

  @override
  String get record => 'Aufnehmen';

  @override
  String get stop => 'Stopp';

  @override
  String get photoSaved => 'Foto gespeichert';

  @override
  String get videoSaved => 'Video gespeichert';

  @override
  String get cameraPermissionDenied => 'Kameraberechtigung verweigert';

  @override
  String get micPermissionDenied => 'Mikrofonberechtigung verweigert';

  @override
  String get noCamera => 'Keine Kamera';

  @override
  String durationSeconds(int seconds) {
    return 'Dauer: $seconds s';
  }

  @override
  String get textLabel => 'Text';

  @override
  String get generateVideo => 'Video erzeugen';

  @override
  String get generating => 'Wird erzeugt…';

  @override
  String get textVideoSaved => 'Textvideo gespeichert';

  @override
  String get gallerySaveFailed =>
      'Kodierung OK, Galerie-Speichern fehlgeschlagen';

  @override
  String get selectPhotos => 'Fotos auswählen';

  @override
  String photosSelected(int count) {
    return '$count ausgewählt';
  }

  @override
  String get secondsPerPhoto => 'Sekunden pro Foto';

  @override
  String get generateSlideshow => 'Diashow erzeugen';

  @override
  String get slideshowSaved => 'Diashow gespeichert';

  @override
  String get selectAtLeast2Photos => 'Mindestens 2 Fotos auswählen';

  @override
  String get mediaEditorTitle => 'Medieneditor';

  @override
  String get selectFile => 'Datei auswählen';

  @override
  String reselect(int count) {
    return 'Neu auswählen ($count)';
  }

  @override
  String get options => 'Optionen';

  @override
  String get start => 'Start';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get selectAtLeast2Videos => 'Mindestens 2 Videos auswählen';

  @override
  String savedUri(String uri) {
    return 'Gespeichert: $uri';
  }

  @override
  String encodedGalleryFailed(String path) {
    return 'Kodierung OK, Galerie fehlgeschlagen: $path';
  }

  @override
  String get qualityLow => 'Niedrig';

  @override
  String get qualityMedium => 'Mittel';

  @override
  String get qualityHigh => 'Hoch';

  @override
  String get mute => 'Stumm';

  @override
  String get keepAudio => 'Audio behalten';

  @override
  String get toolVideoCompress => 'Video komprimieren';

  @override
  String get toolVideoCompressDesc => 'Video mit FFmpeg komprimieren';

  @override
  String get toolImageCompress => 'Bild komprimieren';

  @override
  String get toolImageCompressDesc => 'Bilder komprimieren';

  @override
  String get toolGif => 'Video zu GIF';

  @override
  String get toolGifDesc => 'In animiertes GIF umwandeln';

  @override
  String get toolExtractAudio => 'Audio extrahieren';

  @override
  String get toolExtractAudioDesc => 'AAC/M4A-Spur exportieren';

  @override
  String get toolStripAudio => 'Audio entfernen';

  @override
  String get toolStripAudioDesc => 'Video ohne Ton exportieren';

  @override
  String get toolTranscode => 'Nach MP4 transkodieren';

  @override
  String get toolTranscodeDesc => 'In MP4 umwandeln';

  @override
  String get toolSpeed => 'Geschwindigkeit';

  @override
  String get toolSpeedDesc => '0.5x / 1.5x / 2x';

  @override
  String get toolReverse => 'Video umkehren';

  @override
  String get toolReverseDesc => 'Rückwärts abspielen';

  @override
  String get toolMerge => 'Videos zusammenführen';

  @override
  String get toolMergeDesc => 'Clips der Reihe nach verbinden';

  @override
  String get toolCrop => 'Seitenverhältnis';

  @override
  String get toolCropDesc => '1:1 / 9:16 / 16:9';

  @override
  String get toolVolumeFade => 'Lautstärke und Fade';

  @override
  String get toolVolumeFadeDesc => 'Lautstärke + Ein-/Ausblenden';

  @override
  String get lightTitle => 'Lichtmesser';

  @override
  String get lightHistory => 'Snapshots';

  @override
  String get lightNoSensor => 'Kein Lichtsensor';

  @override
  String get lightNoSensorBody =>
      'Dieses Gerät meldet kein Umgebungslicht (TYPE_LIGHT).';

  @override
  String lightSaved(String lux) {
    return 'Gespeichert: $lux lux';
  }

  @override
  String lightSavedWithNote(String lux, String note) {
    return 'Gespeichert: $lux lux — $note';
  }

  @override
  String lightSaveFailed(String error) {
    return 'Speichern fehlgeschlagen: $error';
  }

  @override
  String get noteHint => 'Notiz (optional)';

  @override
  String get saveSnapshot => 'Snapshot speichern';

  @override
  String get historyEmpty => 'Noch keine Snapshots';

  @override
  String get faceTitle => 'Gesichtsvergleich';

  @override
  String get facePickA => 'Foto A';

  @override
  String get facePickB => 'Foto B';

  @override
  String get faceCompare => 'Vergleichen';

  @override
  String get faceBusy => 'Vergleich…';

  @override
  String get faceNoFace => 'Kein Gesicht erkannt';

  @override
  String faceSimilarity(String percent) {
    return 'Ähnlichkeit: $percent %';
  }

  @override
  String get faceDisclaimer =>
      'Nur geometrische Ähnlichkeit — keine biometrische Identifikation.';

  @override
  String get ebookTitle => 'Ebook-Konverter';

  @override
  String get ebookPick => 'EPUB auswählen';

  @override
  String get ebookConvert => 'In PDF umwandeln';

  @override
  String get ebookBusy => 'Konvertierung…';

  @override
  String get ebookStubNote =>
      'Platzhalter: einseitige PDF-Info (kein volles EPUB-Layout).';

  @override
  String get jobStarting => 'Start…';

  @override
  String get commonError => 'Fehler';

  @override
  String get commonOk => 'OK';
}
