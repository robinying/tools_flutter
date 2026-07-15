// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Tools Flutter';

  @override
  String get appName => 'Tools 工具箱';

  @override
  String get appTagline => '媒体 · 相机 · 电子书 · 光照计 · 人脸';

  @override
  String get sectionCreateEdit => '创作与编辑';

  @override
  String get sectionUtilities => '实用工具';

  @override
  String get language => '语言';

  @override
  String get languageSystem => '跟随系统';

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
  String get featureCamera => '相机';

  @override
  String get featureCameraDesc => '拍照、录像、文字成片、幻灯片';

  @override
  String get featureMedia => '媒体编辑';

  @override
  String get featureMediaDesc => '压缩、音轨、变速、合并、裁切…';

  @override
  String get featureEbook => '电子书转换';

  @override
  String get featureEbookDesc => 'EPUB 转 PDF';

  @override
  String get featureLight => '光照计';

  @override
  String get featureLightDesc => '环境光 lux、场景、快照';

  @override
  String get featureFace => '人脸比对';

  @override
  String get featureFaceDesc => '比对人脸相似度（几何特征）';

  @override
  String get cameraTitle => '相机';

  @override
  String get cameraPhoto => '拍照';

  @override
  String get cameraPhotoDesc => '使用相机拍摄静图';

  @override
  String get cameraRecord => '录像';

  @override
  String get cameraRecordDesc => '录制视频片段';

  @override
  String get cameraText => '文字成片';

  @override
  String get cameraTextDesc => '生成文字卡片 MP4';

  @override
  String get cameraSlideshow => '照片幻灯片';

  @override
  String get cameraSlideshowDesc => '多张照片合成短视频';

  @override
  String get cameraEditHelpers => '剪辑辅助';

  @override
  String get cameraEditHelpersDesc => '使用媒体工具进行变速、裁切、倒放…';

  @override
  String get photoTitle => '拍照';

  @override
  String get recordTitle => '录像';

  @override
  String get textVideoTitle => '文字成片';

  @override
  String get slideshowTitle => '照片幻灯片';

  @override
  String get capture => '拍摄';

  @override
  String get saving => '保存中…';

  @override
  String get record => '开始录制';

  @override
  String get stop => '停止';

  @override
  String get photoSaved => '照片已保存';

  @override
  String get videoSaved => '视频已保存';

  @override
  String get cameraPermissionDenied => '未授予相机权限';

  @override
  String get micPermissionDenied => '未授予麦克风权限';

  @override
  String get noCamera => '无可用相机';

  @override
  String durationSeconds(int seconds) {
    return '时长：$seconds 秒';
  }

  @override
  String get textLabel => '文字';

  @override
  String get generateVideo => '生成视频';

  @override
  String get generating => '生成中…';

  @override
  String get textVideoSaved => '文字视频已保存';

  @override
  String get gallerySaveFailed => '编码成功但相册保存失败';

  @override
  String get selectPhotos => '选择照片';

  @override
  String photosSelected(int count) {
    return '已选 $count 张';
  }

  @override
  String get secondsPerPhoto => '每张显示秒数';

  @override
  String get generateSlideshow => '生成幻灯片';

  @override
  String get slideshowSaved => '幻灯片已保存';

  @override
  String get selectAtLeast2Photos => '请至少选择 2 张照片';

  @override
  String get mediaEditorTitle => '媒体编辑';

  @override
  String get selectFile => '选择文件';

  @override
  String reselect(int count) {
    return '重新选择（$count）';
  }

  @override
  String get options => '选项';

  @override
  String get start => '开始';

  @override
  String get cancel => '取消';

  @override
  String get selectAtLeast2Videos => '请至少选择 2 个视频';

  @override
  String savedUri(String uri) {
    return '已保存：$uri';
  }

  @override
  String encodedGalleryFailed(String path) {
    return '编码成功但相册保存失败：$path';
  }

  @override
  String get qualityLow => '低';

  @override
  String get qualityMedium => '中';

  @override
  String get qualityHigh => '高';

  @override
  String get mute => '静音';

  @override
  String get keepAudio => '保留音频';

  @override
  String get toolVideoCompress => '视频压缩';

  @override
  String get toolVideoCompressDesc => '使用 FFmpeg 压缩视频';

  @override
  String get toolImageCompress => '图片压缩';

  @override
  String get toolImageCompressDesc => '压缩图片';

  @override
  String get toolGif => '视频转 GIF';

  @override
  String get toolGifDesc => '转换为动图 GIF';

  @override
  String get toolExtractAudio => '提取音轨';

  @override
  String get toolExtractAudioDesc => '导出 AAC/M4A 音轨';

  @override
  String get toolStripAudio => '去除音轨';

  @override
  String get toolStripAudioDesc => '导出无声视频';

  @override
  String get toolTranscode => '转码为 MP4';

  @override
  String get toolTranscodeDesc => '转换为 MP4';

  @override
  String get toolSpeed => '变速';

  @override
  String get toolSpeedDesc => '0.5x / 1.5x / 2x';

  @override
  String get toolReverse => '倒放';

  @override
  String get toolReverseDesc => '倒序播放';

  @override
  String get toolMerge => '合并视频';

  @override
  String get toolMergeDesc => '按顺序拼接片段';

  @override
  String get toolCrop => '画面裁切';

  @override
  String get toolCropDesc => '1:1 / 9:16 / 16:9';

  @override
  String get toolVolumeFade => '音量与淡入';

  @override
  String get toolVolumeFadeDesc => '音量调节 + 淡入淡出';

  @override
  String get lightTitle => '光照计';

  @override
  String get lightHistory => '快照记录';

  @override
  String get lightNoSensor => '无光感传感器';

  @override
  String get lightNoSensorBody => '此设备不提供环境光（TYPE_LIGHT）数据。';

  @override
  String lightSaved(String lux) {
    return '已保存：$lux lux';
  }

  @override
  String lightSavedWithNote(String lux, String note) {
    return '已保存：$lux lux — $note';
  }

  @override
  String lightSaveFailed(String error) {
    return '保存失败：$error';
  }

  @override
  String get noteHint => '备注（可选）';

  @override
  String get saveSnapshot => '保存快照';

  @override
  String get historyEmpty => '暂无快照';

  @override
  String get faceTitle => '人脸比对';

  @override
  String get facePickA => '照片 A';

  @override
  String get facePickB => '照片 B';

  @override
  String get faceCompare => '开始比对';

  @override
  String get faceBusy => '比对中…';

  @override
  String get faceNoFace => '未检测到人脸';

  @override
  String faceSimilarity(String percent) {
    return '相似度：$percent%';
  }

  @override
  String get faceDisclaimer => '仅为几何特征相似度，不可用于身份核验。';

  @override
  String get ebookTitle => '电子书转换';

  @override
  String get ebookPick => '选择 EPUB';

  @override
  String get ebookConvert => '转换为 PDF';

  @override
  String get ebookBusy => '转换中…';

  @override
  String get ebookStubNote => '当前为占位转换：单页说明 PDF（非完整 EPUB 排版）。';

  @override
  String get jobStarting => '启动中…';

  @override
  String get commonError => '错误';

  @override
  String get commonOk => '确定';
}
