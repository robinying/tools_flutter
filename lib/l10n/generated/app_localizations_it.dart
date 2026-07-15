// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Tools Flutter';

  @override
  String get appName => 'Tools';

  @override
  String get appTagline => 'Media · Fotocamera · Ebook · Luxmetro · Volto';

  @override
  String get sectionCreateEdit => 'Crea e modifica';

  @override
  String get sectionUtilities => 'Utilità';

  @override
  String get language => 'Lingua';

  @override
  String get languageSystem => 'Sistema';

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
  String get featureCamera => 'Fotocamera';

  @override
  String get featureCameraDesc => 'Foto, video, testo in video, presentazione';

  @override
  String get featureMedia => 'Editor media';

  @override
  String get featureMediaDesc =>
      'Compressione, audio, velocità, unione, ritaglio…';

  @override
  String get featureEbook => 'Convertitore ebook';

  @override
  String get featureEbookDesc => 'EPUB in PDF';

  @override
  String get featureLight => 'Luxmetro';

  @override
  String get featureLightDesc => 'Lux ambientale, scene, snapshot';

  @override
  String get featureFace => 'Confronto volti';

  @override
  String get featureFaceDesc => 'Somiglianza geometrica dei volti';

  @override
  String get cameraTitle => 'Fotocamera';

  @override
  String get cameraPhoto => 'Scatta foto';

  @override
  String get cameraPhotoDesc => 'Cattura un’immagine con la fotocamera';

  @override
  String get cameraRecord => 'Registra video';

  @override
  String get cameraRecordDesc => 'Registra un clip video';

  @override
  String get cameraText => 'Testo in video';

  @override
  String get cameraTextDesc => 'Genera una card di testo in MP4';

  @override
  String get cameraSlideshow => 'Presentazione foto';

  @override
  String get cameraSlideshowDesc => 'Combina foto in un video breve';

  @override
  String get cameraEditHelpers => 'Aiuti di montaggio';

  @override
  String get cameraEditHelpersDesc =>
      'Velocità, ritaglio, inverso con gli strumenti media…';

  @override
  String get photoTitle => 'Scatta foto';

  @override
  String get recordTitle => 'Registra video';

  @override
  String get textVideoTitle => 'Testo in video';

  @override
  String get slideshowTitle => 'Presentazione foto';

  @override
  String get capture => 'Scatta';

  @override
  String get saving => 'Salvataggio…';

  @override
  String get record => 'Registra';

  @override
  String get stop => 'Stop';

  @override
  String get photoSaved => 'Foto salvata';

  @override
  String get videoSaved => 'Video salvato';

  @override
  String get cameraPermissionDenied => 'Autorizzazione fotocamera negata';

  @override
  String get micPermissionDenied => 'Autorizzazione microfono negata';

  @override
  String get noCamera => 'Nessuna fotocamera';

  @override
  String durationSeconds(int seconds) {
    return 'Durata: $seconds s';
  }

  @override
  String get textLabel => 'Testo';

  @override
  String get generateVideo => 'Genera video';

  @override
  String get generating => 'Generazione…';

  @override
  String get textVideoSaved => 'Video testo salvato';

  @override
  String get gallerySaveFailed =>
      'Codifica OK, salvataggio galleria non riuscito';

  @override
  String get selectPhotos => 'Seleziona foto';

  @override
  String photosSelected(int count) {
    return '$count selezionate';
  }

  @override
  String get secondsPerPhoto => 'Secondi per foto';

  @override
  String get generateSlideshow => 'Genera presentazione';

  @override
  String get slideshowSaved => 'Presentazione salvata';

  @override
  String get selectAtLeast2Photos => 'Seleziona almeno 2 foto';

  @override
  String get mediaEditorTitle => 'Editor media';

  @override
  String get selectFile => 'Seleziona file';

  @override
  String reselect(int count) {
    return 'Riseleziona ($count)';
  }

  @override
  String get options => 'Opzioni';

  @override
  String get start => 'Avvia';

  @override
  String get cancel => 'Annulla';

  @override
  String get selectAtLeast2Videos => 'Seleziona almeno 2 video';

  @override
  String savedUri(String uri) {
    return 'Salvato: $uri';
  }

  @override
  String encodedGalleryFailed(String path) {
    return 'Codifica OK, galleria non riuscita: $path';
  }

  @override
  String get qualityLow => 'Basso';

  @override
  String get qualityMedium => 'Medio';

  @override
  String get qualityHigh => 'Alto';

  @override
  String get mute => 'Muto';

  @override
  String get keepAudio => 'Mantieni audio';

  @override
  String get toolVideoCompress => 'Comprimi video';

  @override
  String get toolVideoCompressDesc => 'Comprimi video con FFmpeg';

  @override
  String get toolImageCompress => 'Comprimi immagine';

  @override
  String get toolImageCompressDesc => 'Comprimi immagini';

  @override
  String get toolGif => 'Video in GIF';

  @override
  String get toolGifDesc => 'Converti in GIF animata';

  @override
  String get toolExtractAudio => 'Estrai audio';

  @override
  String get toolExtractAudioDesc => 'Esporta traccia AAC/M4A';

  @override
  String get toolStripAudio => 'Rimuovi audio';

  @override
  String get toolStripAudioDesc => 'Esporta video senza audio';

  @override
  String get toolTranscode => 'Transcodifica in MP4';

  @override
  String get toolTranscodeDesc => 'Converti in MP4';

  @override
  String get toolSpeed => 'Cambia velocità';

  @override
  String get toolSpeedDesc => '0.5x / 1.5x / 2x';

  @override
  String get toolReverse => 'Inverti video';

  @override
  String get toolReverseDesc => 'Riproduci al contrario';

  @override
  String get toolMerge => 'Unisci video';

  @override
  String get toolMergeDesc => 'Unisci i clip in ordine';

  @override
  String get toolCrop => 'Ritaglio';

  @override
  String get toolCropDesc => '1:1 / 9:16 / 16:9';

  @override
  String get toolVolumeFade => 'Volume e fade';

  @override
  String get toolVolumeFadeDesc => 'Volume + fade in/out';

  @override
  String get lightTitle => 'Luxmetro';

  @override
  String get lightHistory => 'Snapshot';

  @override
  String get lightNoSensor => 'Nessun sensore di luce';

  @override
  String get lightNoSensorBody =>
      'Questo dispositivo non fornisce luce ambientale (TYPE_LIGHT).';

  @override
  String lightSaved(String lux) {
    return 'Salvato: $lux lux';
  }

  @override
  String lightSavedWithNote(String lux, String note) {
    return 'Salvato: $lux lux — $note';
  }

  @override
  String lightSaveFailed(String error) {
    return 'Salvataggio non riuscito: $error';
  }

  @override
  String get noteHint => 'Nota (opzionale)';

  @override
  String get saveSnapshot => 'Salva snapshot';

  @override
  String get historyEmpty => 'Nessuno snapshot';

  @override
  String get faceTitle => 'Confronto volti';

  @override
  String get facePickA => 'Foto A';

  @override
  String get facePickB => 'Foto B';

  @override
  String get faceCompare => 'Confronta';

  @override
  String get faceBusy => 'Confronto…';

  @override
  String get faceNoFace => 'Nessun volto rilevato';

  @override
  String faceSimilarity(String percent) {
    return 'Somiglianza: $percent%';
  }

  @override
  String get faceDisclaimer =>
      'Solo somiglianza geometrica — non verifica biometrica.';

  @override
  String get ebookTitle => 'Convertitore ebook';

  @override
  String get ebookPick => 'Seleziona EPUB';

  @override
  String get ebookConvert => 'Converti in PDF';

  @override
  String get ebookBusy => 'Conversione…';

  @override
  String get ebookStubNote =>
      'Conversione stub: PDF di una pagina informativa (non layout EPUB completo).';

  @override
  String get jobStarting => 'Avvio…';

  @override
  String get commonError => 'Errore';

  @override
  String get commonOk => 'OK';
}
