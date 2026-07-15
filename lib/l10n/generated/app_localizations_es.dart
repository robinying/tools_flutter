// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Tools Flutter';

  @override
  String get appName => 'Tools';

  @override
  String get appTagline => 'Medios · Cámara · Ebook · Luxómetro · Cara';

  @override
  String get sectionCreateEdit => 'Crear y editar';

  @override
  String get sectionUtilities => 'Utilidades';

  @override
  String get language => 'Idioma';

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
  String get featureCamera => 'Cámara';

  @override
  String get featureCameraDesc => 'Foto, vídeo, texto a vídeo, presentación';

  @override
  String get featureMedia => 'Editor de medios';

  @override
  String get featureMediaDesc =>
      'Comprimir, audio, velocidad, fusionar, recortar…';

  @override
  String get featureEbook => 'Conversor de ebook';

  @override
  String get featureEbookDesc => 'EPUB a PDF';

  @override
  String get featureLight => 'Luxómetro';

  @override
  String get featureLightDesc => 'Lux ambiental, escenas, capturas';

  @override
  String get featureFace => 'Comparar caras';

  @override
  String get featureFaceDesc => 'Similitud geométrica de caras';

  @override
  String get cameraTitle => 'Cámara';

  @override
  String get cameraPhoto => 'Tomar foto';

  @override
  String get cameraPhotoDesc => 'Capturar una imagen con la cámara';

  @override
  String get cameraRecord => 'Grabar vídeo';

  @override
  String get cameraRecordDesc => 'Grabar un clip de vídeo';

  @override
  String get cameraText => 'Texto a vídeo';

  @override
  String get cameraTextDesc => 'Generar una tarjeta de texto en MP4';

  @override
  String get cameraSlideshow => 'Presentación de fotos';

  @override
  String get cameraSlideshowDesc => 'Combinar fotos en un vídeo corto';

  @override
  String get cameraEditHelpers => 'Ayudas de edición';

  @override
  String get cameraEditHelpersDesc =>
      'Velocidad, recorte, inverso con herramientas de medios…';

  @override
  String get photoTitle => 'Tomar foto';

  @override
  String get recordTitle => 'Grabar vídeo';

  @override
  String get textVideoTitle => 'Texto a vídeo';

  @override
  String get slideshowTitle => 'Presentación de fotos';

  @override
  String get capture => 'Capturar';

  @override
  String get saving => 'Guardando…';

  @override
  String get record => 'Grabar';

  @override
  String get stop => 'Detener';

  @override
  String get photoSaved => 'Foto guardada';

  @override
  String get videoSaved => 'Vídeo guardado';

  @override
  String get cameraPermissionDenied => 'Permiso de cámara denegado';

  @override
  String get micPermissionDenied => 'Permiso de micrófono denegado';

  @override
  String get noCamera => 'Sin cámara';

  @override
  String durationSeconds(int seconds) {
    return 'Duración: $seconds s';
  }

  @override
  String get textLabel => 'Texto';

  @override
  String get generateVideo => 'Generar vídeo';

  @override
  String get generating => 'Generando…';

  @override
  String get textVideoSaved => 'Vídeo de texto guardado';

  @override
  String get gallerySaveFailed =>
      'Codificación OK, fallo al guardar en galería';

  @override
  String get selectPhotos => 'Seleccionar fotos';

  @override
  String photosSelected(int count) {
    return '$count seleccionadas';
  }

  @override
  String get secondsPerPhoto => 'Segundos por foto';

  @override
  String get generateSlideshow => 'Generar presentación';

  @override
  String get slideshowSaved => 'Presentación guardada';

  @override
  String get selectAtLeast2Photos => 'Selecciona al menos 2 fotos';

  @override
  String get mediaEditorTitle => 'Editor de medios';

  @override
  String get selectFile => 'Seleccionar archivo';

  @override
  String reselect(int count) {
    return 'Reseleccionar ($count)';
  }

  @override
  String get options => 'Opciones';

  @override
  String get start => 'Iniciar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get selectAtLeast2Videos => 'Selecciona al menos 2 vídeos';

  @override
  String savedUri(String uri) {
    return 'Guardado: $uri';
  }

  @override
  String encodedGalleryFailed(String path) {
    return 'Codificación OK, fallo de galería: $path';
  }

  @override
  String get qualityLow => 'Bajo';

  @override
  String get qualityMedium => 'Medio';

  @override
  String get qualityHigh => 'Alto';

  @override
  String get mute => 'Silencio';

  @override
  String get keepAudio => 'Mantener audio';

  @override
  String get toolVideoCompress => 'Comprimir vídeo';

  @override
  String get toolVideoCompressDesc => 'Comprimir vídeo con FFmpeg';

  @override
  String get toolImageCompress => 'Comprimir imagen';

  @override
  String get toolImageCompressDesc => 'Comprimir imágenes';

  @override
  String get toolGif => 'Vídeo a GIF';

  @override
  String get toolGifDesc => 'Convertir a GIF animado';

  @override
  String get toolExtractAudio => 'Extraer audio';

  @override
  String get toolExtractAudioDesc => 'Exportar pista AAC/M4A';

  @override
  String get toolStripAudio => 'Quitar audio';

  @override
  String get toolStripAudioDesc => 'Exportar vídeo sin sonido';

  @override
  String get toolTranscode => 'Transcodificar a MP4';

  @override
  String get toolTranscodeDesc => 'Convertir a MP4';

  @override
  String get toolSpeed => 'Cambiar velocidad';

  @override
  String get toolSpeedDesc => '0.5x / 1.5x / 2x';

  @override
  String get toolReverse => 'Invertir vídeo';

  @override
  String get toolReverseDesc => 'Reproducir al revés';

  @override
  String get toolMerge => 'Fusionar vídeos';

  @override
  String get toolMergeDesc => 'Unir clips en orden';

  @override
  String get toolCrop => 'Recortar';

  @override
  String get toolCropDesc => '1:1 / 9:16 / 16:9';

  @override
  String get toolVolumeFade => 'Volumen y fundido';

  @override
  String get toolVolumeFadeDesc => 'Volumen + fundido de entrada/salida';

  @override
  String get lightTitle => 'Luxómetro';

  @override
  String get lightHistory => 'Capturas';

  @override
  String get lightNoSensor => 'Sin sensor de luz';

  @override
  String get lightNoSensorBody =>
      'Este dispositivo no reporta luz ambiental (TYPE_LIGHT).';

  @override
  String lightSaved(String lux) {
    return 'Guardado: $lux lux';
  }

  @override
  String lightSavedWithNote(String lux, String note) {
    return 'Guardado: $lux lux — $note';
  }

  @override
  String lightSaveFailed(String error) {
    return 'Error al guardar: $error';
  }

  @override
  String get noteHint => 'Nota (opcional)';

  @override
  String get saveSnapshot => 'Guardar captura';

  @override
  String get historyEmpty => 'Aún no hay capturas';

  @override
  String get faceTitle => 'Comparar caras';

  @override
  String get facePickA => 'Foto A';

  @override
  String get facePickB => 'Foto B';

  @override
  String get faceCompare => 'Comparar';

  @override
  String get faceBusy => 'Comparando…';

  @override
  String get faceNoFace => 'No se detectó rostro';

  @override
  String faceSimilarity(String percent) {
    return 'Similitud: $percent%';
  }

  @override
  String get faceDisclaimer =>
      'Solo similitud geométrica — no es verificación biométrica.';

  @override
  String get ebookTitle => 'Conversor de ebook';

  @override
  String get ebookPick => 'Seleccionar EPUB';

  @override
  String get ebookConvert => 'Convertir a PDF';

  @override
  String get ebookBusy => 'Convirtiendo…';

  @override
  String get ebookStubNote =>
      'Conversión provisional: PDF de una página informativa (no maquetación EPUB completa).';

  @override
  String get jobStarting => 'Iniciando…';

  @override
  String get commonError => 'Error';

  @override
  String get commonOk => 'Aceptar';
}
