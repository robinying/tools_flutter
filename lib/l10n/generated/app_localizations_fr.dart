// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Tools Flutter';

  @override
  String get appName => 'Tools';

  @override
  String get appTagline => 'Média · Caméra · Ebook · Luxmètre · Visage';

  @override
  String get sectionCreateEdit => 'Créer et modifier';

  @override
  String get sectionUtilities => 'Utilitaires';

  @override
  String get language => 'Langue';

  @override
  String get languageSystem => 'Système';

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
  String get featureCamera => 'Caméra';

  @override
  String get featureCameraDesc => 'Photo, vidéo, texte en vidéo, diaporama';

  @override
  String get featureMedia => 'Éditeur média';

  @override
  String get featureMediaDesc =>
      'Compression, audio, vitesse, fusion, recadrage…';

  @override
  String get featureEbook => 'Convertisseur ebook';

  @override
  String get featureEbookDesc => 'EPUB vers PDF';

  @override
  String get featureLight => 'Luxmètre';

  @override
  String get featureLightDesc => 'Lux ambiant, scènes, captures';

  @override
  String get featureFace => 'Comparaison de visages';

  @override
  String get featureFaceDesc => 'Similarité géométrique des visages';

  @override
  String get cameraTitle => 'Caméra';

  @override
  String get cameraPhoto => 'Prendre une photo';

  @override
  String get cameraPhotoDesc => 'Capturer une image avec la caméra';

  @override
  String get cameraRecord => 'Enregistrer une vidéo';

  @override
  String get cameraRecordDesc => 'Filmer une séquence';

  @override
  String get cameraText => 'Texte en vidéo';

  @override
  String get cameraTextDesc => 'Générer une carte texte en MP4';

  @override
  String get cameraSlideshow => 'Diaporama photo';

  @override
  String get cameraSlideshowDesc => 'Assembler des photos en courte vidéo';

  @override
  String get cameraEditHelpers => 'Outils de montage';

  @override
  String get cameraEditHelpersDesc =>
      'Vitesse, recadrage, inversion via l’éditeur média…';

  @override
  String get photoTitle => 'Prendre une photo';

  @override
  String get recordTitle => 'Enregistrer une vidéo';

  @override
  String get textVideoTitle => 'Texte en vidéo';

  @override
  String get slideshowTitle => 'Diaporama photo';

  @override
  String get capture => 'Capturer';

  @override
  String get saving => 'Enregistrement…';

  @override
  String get record => 'Enregistrer';

  @override
  String get stop => 'Arrêter';

  @override
  String get photoSaved => 'Photo enregistrée';

  @override
  String get videoSaved => 'Vidéo enregistrée';

  @override
  String get cameraPermissionDenied => 'Permission caméra refusée';

  @override
  String get micPermissionDenied => 'Permission micro refusée';

  @override
  String get noCamera => 'Aucune caméra';

  @override
  String durationSeconds(int seconds) {
    return 'Durée : $seconds s';
  }

  @override
  String get textLabel => 'Texte';

  @override
  String get generateVideo => 'Générer la vidéo';

  @override
  String get generating => 'Génération…';

  @override
  String get textVideoSaved => 'Vidéo texte enregistrée';

  @override
  String get gallerySaveFailed => 'Encodage OK, échec d’enregistrement galerie';

  @override
  String get selectPhotos => 'Sélectionner des photos';

  @override
  String photosSelected(int count) {
    return '$count sélectionnée(s)';
  }

  @override
  String get secondsPerPhoto => 'Secondes par photo';

  @override
  String get generateSlideshow => 'Générer le diaporama';

  @override
  String get slideshowSaved => 'Diaporama enregistré';

  @override
  String get selectAtLeast2Photos => 'Sélectionnez au moins 2 photos';

  @override
  String get mediaEditorTitle => 'Éditeur média';

  @override
  String get selectFile => 'Sélectionner un fichier';

  @override
  String reselect(int count) {
    return 'Resélectionner ($count)';
  }

  @override
  String get options => 'Options';

  @override
  String get start => 'Démarrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get selectAtLeast2Videos => 'Sélectionnez au moins 2 vidéos';

  @override
  String savedUri(String uri) {
    return 'Enregistré : $uri';
  }

  @override
  String encodedGalleryFailed(String path) {
    return 'Encodage OK, échec galerie : $path';
  }

  @override
  String get qualityLow => 'Bas';

  @override
  String get qualityMedium => 'Moyen';

  @override
  String get qualityHigh => 'Élevé';

  @override
  String get mute => 'Muet';

  @override
  String get keepAudio => 'Conserver l’audio';

  @override
  String get toolVideoCompress => 'Compresser la vidéo';

  @override
  String get toolVideoCompressDesc => 'Compresser la vidéo avec FFmpeg';

  @override
  String get toolImageCompress => 'Compresser l’image';

  @override
  String get toolImageCompressDesc => 'Compresser les images';

  @override
  String get toolGif => 'Vidéo vers GIF';

  @override
  String get toolGifDesc => 'Convertir en GIF animé';

  @override
  String get toolExtractAudio => 'Extraire l’audio';

  @override
  String get toolExtractAudioDesc => 'Exporter la piste AAC/M4A';

  @override
  String get toolStripAudio => 'Supprimer l’audio';

  @override
  String get toolStripAudioDesc => 'Exporter la vidéo sans son';

  @override
  String get toolTranscode => 'Transcoder en MP4';

  @override
  String get toolTranscodeDesc => 'Convertir en MP4';

  @override
  String get toolSpeed => 'Changer la vitesse';

  @override
  String get toolSpeedDesc => '0.5x / 1.5x / 2x';

  @override
  String get toolReverse => 'Inverser la vidéo';

  @override
  String get toolReverseDesc => 'Lire à l’envers';

  @override
  String get toolMerge => 'Fusionner des vidéos';

  @override
  String get toolMergeDesc => 'Joindre les clips dans l’ordre';

  @override
  String get toolCrop => 'Recadrer';

  @override
  String get toolCropDesc => '1:1 / 9:16 / 16:9';

  @override
  String get toolVolumeFade => 'Volume et fondu';

  @override
  String get toolVolumeFadeDesc => 'Volume + fondu entrée/sortie';

  @override
  String get lightTitle => 'Luxmètre';

  @override
  String get lightHistory => 'Captures';

  @override
  String get lightNoSensor => 'Pas de capteur de lumière';

  @override
  String get lightNoSensorBody =>
      'Cet appareil ne fournit pas la lumière ambiante (TYPE_LIGHT).';

  @override
  String lightSaved(String lux) {
    return 'Enregistré : $lux lux';
  }

  @override
  String lightSavedWithNote(String lux, String note) {
    return 'Enregistré : $lux lux — $note';
  }

  @override
  String lightSaveFailed(String error) {
    return 'Échec de l’enregistrement : $error';
  }

  @override
  String get noteHint => 'Note (optionnel)';

  @override
  String get saveSnapshot => 'Enregistrer la capture';

  @override
  String get historyEmpty => 'Aucune capture';

  @override
  String get faceTitle => 'Comparaison de visages';

  @override
  String get facePickA => 'Photo A';

  @override
  String get facePickB => 'Photo B';

  @override
  String get faceCompare => 'Comparer';

  @override
  String get faceBusy => 'Comparaison…';

  @override
  String get faceNoFace => 'Aucun visage détecté';

  @override
  String faceSimilarity(String percent) {
    return 'Similarité : $percent %';
  }

  @override
  String get faceDisclaimer =>
      'Similarité géométrique uniquement — pas d’identification biométrique.';

  @override
  String get ebookTitle => 'Convertisseur ebook';

  @override
  String get ebookPick => 'Sélectionner un EPUB';

  @override
  String get ebookConvert => 'Convertir en PDF';

  @override
  String get ebookBusy => 'Conversion…';

  @override
  String get ebookStubNote =>
      'Conversion provisoire : une page PDF d’info (pas de mise en page EPUB complète).';

  @override
  String get jobStarting => 'Démarrage…';

  @override
  String get commonError => 'Erreur';

  @override
  String get commonOk => 'OK';
}
