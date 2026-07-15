// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Tools Flutter';

  @override
  String get appName => 'Tools';

  @override
  String get appTagline => 'Mídia · Câmera · Ebook · Luxímetro · Rosto';

  @override
  String get sectionCreateEdit => 'Criar e editar';

  @override
  String get sectionUtilities => 'Utilitários';

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
  String get featureCamera => 'Câmera';

  @override
  String get featureCameraDesc => 'Foto, vídeo, texto em vídeo, apresentação';

  @override
  String get featureMedia => 'Editor de mídia';

  @override
  String get featureMediaDesc => 'Comprimir, áudio, velocidade, unir, cortar…';

  @override
  String get featureEbook => 'Conversor de ebook';

  @override
  String get featureEbookDesc => 'EPUB para PDF';

  @override
  String get featureLight => 'Luxímetro';

  @override
  String get featureLightDesc => 'Lux ambiente, cenas, capturas';

  @override
  String get featureFace => 'Comparar rostos';

  @override
  String get featureFaceDesc => 'Similaridade geométrica de rostos';

  @override
  String get cameraTitle => 'Câmera';

  @override
  String get cameraPhoto => 'Tirar foto';

  @override
  String get cameraPhotoDesc => 'Capturar uma imagem com a câmera';

  @override
  String get cameraRecord => 'Gravar vídeo';

  @override
  String get cameraRecordDesc => 'Gravar um clipe de vídeo';

  @override
  String get cameraText => 'Texto em vídeo';

  @override
  String get cameraTextDesc => 'Gerar um cartão de texto em MP4';

  @override
  String get cameraSlideshow => 'Apresentação de fotos';

  @override
  String get cameraSlideshowDesc => 'Combinar fotos em um vídeo curto';

  @override
  String get cameraEditHelpers => 'Ajudas de edição';

  @override
  String get cameraEditHelpersDesc =>
      'Velocidade, corte, reverso com ferramentas de mídia…';

  @override
  String get photoTitle => 'Tirar foto';

  @override
  String get recordTitle => 'Gravar vídeo';

  @override
  String get textVideoTitle => 'Texto em vídeo';

  @override
  String get slideshowTitle => 'Apresentação de fotos';

  @override
  String get capture => 'Capturar';

  @override
  String get saving => 'Salvando…';

  @override
  String get record => 'Gravar';

  @override
  String get stop => 'Parar';

  @override
  String get photoSaved => 'Foto salva';

  @override
  String get videoSaved => 'Vídeo salvo';

  @override
  String get cameraPermissionDenied => 'Permissão da câmera negada';

  @override
  String get micPermissionDenied => 'Permissão do microfone negada';

  @override
  String get noCamera => 'Sem câmera';

  @override
  String durationSeconds(int seconds) {
    return 'Duração: $seconds s';
  }

  @override
  String get textLabel => 'Texto';

  @override
  String get generateVideo => 'Gerar vídeo';

  @override
  String get generating => 'Gerando…';

  @override
  String get textVideoSaved => 'Vídeo de texto salvo';

  @override
  String get gallerySaveFailed => 'Codificação OK, falha ao salvar na galeria';

  @override
  String get selectPhotos => 'Selecionar fotos';

  @override
  String photosSelected(int count) {
    return '$count selecionadas';
  }

  @override
  String get secondsPerPhoto => 'Segundos por foto';

  @override
  String get generateSlideshow => 'Gerar apresentação';

  @override
  String get slideshowSaved => 'Apresentação salva';

  @override
  String get selectAtLeast2Photos => 'Selecione pelo menos 2 fotos';

  @override
  String get mediaEditorTitle => 'Editor de mídia';

  @override
  String get selectFile => 'Selecionar arquivo';

  @override
  String reselect(int count) {
    return 'Resselecionar ($count)';
  }

  @override
  String get options => 'Opções';

  @override
  String get start => 'Iniciar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get selectAtLeast2Videos => 'Selecione pelo menos 2 vídeos';

  @override
  String savedUri(String uri) {
    return 'Salvo: $uri';
  }

  @override
  String encodedGalleryFailed(String path) {
    return 'Codificação OK, falha na galeria: $path';
  }

  @override
  String get qualityLow => 'Baixo';

  @override
  String get qualityMedium => 'Médio';

  @override
  String get qualityHigh => 'Alto';

  @override
  String get mute => 'Mudo';

  @override
  String get keepAudio => 'Manter áudio';

  @override
  String get toolVideoCompress => 'Comprimir vídeo';

  @override
  String get toolVideoCompressDesc => 'Comprimir vídeo com FFmpeg';

  @override
  String get toolImageCompress => 'Comprimir imagem';

  @override
  String get toolImageCompressDesc => 'Comprimir imagens';

  @override
  String get toolGif => 'Vídeo para GIF';

  @override
  String get toolGifDesc => 'Converter em GIF animado';

  @override
  String get toolExtractAudio => 'Extrair áudio';

  @override
  String get toolExtractAudioDesc => 'Exportar faixa AAC/M4A';

  @override
  String get toolStripAudio => 'Remover áudio';

  @override
  String get toolStripAudioDesc => 'Exportar vídeo sem som';

  @override
  String get toolTranscode => 'Transcodificar para MP4';

  @override
  String get toolTranscodeDesc => 'Converter para MP4';

  @override
  String get toolSpeed => 'Alterar velocidade';

  @override
  String get toolSpeedDesc => '0.5x / 1.5x / 2x';

  @override
  String get toolReverse => 'Inverter vídeo';

  @override
  String get toolReverseDesc => 'Reproduzir ao contrário';

  @override
  String get toolMerge => 'Unir vídeos';

  @override
  String get toolMergeDesc => 'Juntar clipes em ordem';

  @override
  String get toolCrop => 'Recortar';

  @override
  String get toolCropDesc => '1:1 / 9:16 / 16:9';

  @override
  String get toolVolumeFade => 'Volume e fade';

  @override
  String get toolVolumeFadeDesc => 'Volume + fade de entrada/saída';

  @override
  String get lightTitle => 'Luxímetro';

  @override
  String get lightHistory => 'Capturas';

  @override
  String get lightNoSensor => 'Sem sensor de luz';

  @override
  String get lightNoSensorBody =>
      'Este dispositivo não informa luz ambiente (TYPE_LIGHT).';

  @override
  String lightSaved(String lux) {
    return 'Salvo: $lux lux';
  }

  @override
  String lightSavedWithNote(String lux, String note) {
    return 'Salvo: $lux lux — $note';
  }

  @override
  String lightSaveFailed(String error) {
    return 'Falha ao salvar: $error';
  }

  @override
  String get noteHint => 'Nota (opcional)';

  @override
  String get saveSnapshot => 'Salvar captura';

  @override
  String get historyEmpty => 'Ainda não há capturas';

  @override
  String get faceTitle => 'Comparar rostos';

  @override
  String get facePickA => 'Foto A';

  @override
  String get facePickB => 'Foto B';

  @override
  String get faceCompare => 'Comparar';

  @override
  String get faceBusy => 'Comparando…';

  @override
  String get faceNoFace => 'Nenhum rosto detectado';

  @override
  String faceSimilarity(String percent) {
    return 'Similaridade: $percent%';
  }

  @override
  String get faceDisclaimer =>
      'Apenas similaridade geométrica — não é verificação biométrica.';

  @override
  String get ebookTitle => 'Conversor de ebook';

  @override
  String get ebookPick => 'Selecionar EPUB';

  @override
  String get ebookConvert => 'Converter para PDF';

  @override
  String get ebookBusy => 'Convertendo…';

  @override
  String get ebookStubNote =>
      'Conversão provisória: PDF de uma página informativa (não layout EPUB completo).';

  @override
  String get jobStarting => 'Iniciando…';

  @override
  String get commonError => 'Erro';

  @override
  String get commonOk => 'OK';
}
