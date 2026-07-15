# Tools Flutter

Flutter 移植版 **Tools** 多功能工具箱（`com.robin.tools` → `com.robin.tools_flutter`）。

在 Android 上提供媒体处理、相机、光照计、人脸几何比对与 EPUB 占位转换等能力；长耗时媒体任务走原生前台服务 + 本地 FFmpeg。

---

## 功能一览

| 模块 | 能力 | 说明 |
|------|------|------|
| **Media Editor** | 压缩视频/图片、GIF、提取/去音轨、转码、变速、倒放、合并、裁切、音量淡入 | 经 `MediaJobService`（FGS `mediaProcessing`）+ FFmpeg |
| **Camera** | 拍照、录像、文字成片、多图幻灯片 | 拍照/录像用 `camera`；文字/幻灯片复用媒体任务管道 |
| **Light Meter** | 环境光 lux、场景标签、时间窗图表、快照历史 | `TYPE_LIGHT` 传感器 + sqflite 本地库 |
| **Face Compare** | 双图比对相似度 | ML Kit 关键 + 几何向量余弦（**非**生物识别核验） |
| **Ebook** | EPUB → PDF | 当前为 **单页 stub**，写入 Downloads/Tools |

迁移阶段 **0–5 / A–D 已完成**（脚手架、媒体、相机、LightLux、Face、Ebook 与 Clean 分层）。

---

## 技术栈

| 层级 | 选型 |
|------|------|
| UI / 框架 | Flutter 3.32 · Dart 3.8 |
| 状态 / DI | **Riverpod** (`flutter_riverpod`) |
| 路由 | **GoRouter** |
| 模型 / 密封状态 | **Freezed**（`*.freezed.dart` **提交进 git**） |
| 架构 | Feature-first、偏 Clean：**厚 Repository + Notifier**（默认不做「一方法一 UseCase」） |
| 媒体原生 | 本地 `android/app/libs/ffmpeg-kit.aar` + `MediaJobService` |
| 其他插件 | camera · file_picker · image_picker · google_mlkit_face_detection · sqflite · permission_handler · path_provider · gal |

### Android 构建约束

- **applicationId**：`com.robin.tools_flutter`
- **minSdk** 28 · **targetSdk / compileSdk** 35
- **Kotlin** 2.1 · **Java** 17
- NDK `27.0.12077973`（与 FFmpeg AAR 对齐）

---

## 架构与目录

```
lib/
  main.dart                      # ProviderScope + MaterialApp.router
  routing/app_router.dart        # GoRouter 路由表
  core/
    error/                       # AppFailure + Result（Freezed）
    theme/                       # 主题与间距
    widgets/                     # 通用 UI
    platform/native_bridge.dart  # Method/EventChannel 封装
  features/
    home/                        # 功能入口
    media/                       # 媒体工具（domain / data / presentation）
    camera/                      # 相机与文字/幻灯片（复用 mediaJobProvider）
    lightlux/                    # 光照计 + 快照
    face/                        # 人脸几何比对
    ebook/                       # EPUB stub
android/app/src/main/kotlin/com/robin/tools_flutter/
  MainActivity.kt                # Channel 注册、传感器、MediaStore、ebook stub
  MediaJobService.kt             # FGS + 单任务队列 + 主线程进度事件
  MediaJobCommands.kt            # 各 job 的 FFmpeg 参数构建
  MediaPathPolicy.kt             # 输入路径白名单
  libs/ffmpeg-kit.aar
test/                            # 单元 / widget 测试
scripts/device_verify.py         # 真机 UI smoke
```

**分层约定（每个 feature）：**

```
features/<name>/
  domain/          # 实体、仓库接口
  data/            # 仓库实现、数据源（NativeBridge、sqflite…）
  presentation/    # 页面 + Riverpod Notifier
```

- 依赖方向：`presentation` → `domain` ← `data`
- 仓库返回 `Result<T>` / Stream；Notifier 映射为 UI 状态
- 共享能力放在 `core/`；Camera 对 Media 任务管道的复用是已知的跨 feature 依赖

---

## 原生通道（NativeBridge）

| Channel | 用途 |
|---------|------|
| `com.robin.tools/media_job` | 启动 / 取消**类型化**媒体任务 |
| `com.robin.tools/media_events` | 任务进度（`running` / `finished` / `failed`） |
| `com.robin.tools/light_sensor` + `_events` | 光感是否可用 + lux 流 |
| `com.robin.tools/ebook` | EPUB stub 转 PDF |
| `com.robin.tools/gallery` | 视频 / 图片 / 音频写入 MediaStore |

> 已移除开放式 `com.robin.tools/ffmpeg`（任意参数数组）。新能力请扩展 `MediaToolType` + `MediaJobCommands`，不要重新暴露裸 FFmpeg 通道。

### 媒体任务类型（`MediaJobService`）

`videoCompress` · `imageCompress` · `gif` · `extractAudio` · `stripAudio` · `transcode` · `speed` · `reverse` · `merge` · `crop` · `volumeFade` · `textCard` · `slideshow`

运行时行为要点：

- **单 flight**：同时只跑一个 job；并发启动会失败（`BUSY` / “Another job is running”）
- **进度**：EventChannel 在 **主线程** 投递
- **路径**：`MediaPathPolicy` 拒绝 `/proc` `/sys` `/dev` 等；允许应用私有目录与常见用户媒体路径
- **缓存**：`cacheDir/media_out` 按数量与 24h 清理
- **Release**：`MediaJobService` **exported=false**；Debug 清单可导出供 adb 验证（勿外发 debug APK）

---

## 构建与安装

```bash
cd tools_flutter
flutter pub get
# 修改 @freezed 后：
dart run build_runner build --delete-conflicting-outputs

flutter analyze
flutter test

flutter build apk --debug
adb install -r build/app/outputs/flutter-apk/app-debug.apk
adb shell am start -n com.robin.tools_flutter/.MainActivity
```

### 真机验证

```bash
# UI smoke（首页 → 各入口）
python3 scripts/device_verify.py <serial>

# Debug-only：adb 注入媒体任务（路径需通过 MediaPathPolicy，建议放在 app cache）
adb shell am start-foreground-service \
  -n com.robin.tools_flutter/.MediaJobService \
  --es type videoCompress --es level medium \
  --esa paths /data/user/0/com.robin.tools_flutter/cache/tftest.mp4
```

---

## Release 签名

1. 复制 `android/key.properties.example` → `android/key.properties`（已 gitignore）
2. 填写 `storeFile` / 密码 / alias，或设置环境变量：  
   `KEYSTORE_PATH` · `KEYSTORE_PASSWORD` · `KEY_ALIAS` · `KEY_PASSWORD`
3. `storeFile` 路径相对 **`android/`** 目录（除非写绝对路径）

未配置 release keystore 时，`release` 构建会回退 **debug 签名**，仅适合本地验证，**不可上架**。

当前默认未开 R8 minify（待 FFmpeg / Flutter keep 规则在真机验证后再开）。

---

## 安全与质量（摘要）

近期加固（详见仓库内变更）：

- MediaStore 写入失败会 **删除 pending 行**，避免幽灵文件
- 相册 / 媒体保存失败时 UI 会区分「编码成功但保存失败」
- 录像页校验相机/麦克风权限与空摄像头列表
- 未知媒体工具路由 id 回退媒体首页，避免 `firstWhere` 崩溃
- 清单去掉无效的 `requestLegacyExternalStorage`（target 35）

更完整的静态审查记录可在本地 `docs/` 维护（若 `.gitignore` 忽略 `docs/*`，则不会进版本库）。

---

## 已知限制 / 注意事项

- Android 15+ debug 可能出现 **16KB 页大小** 兼容提示（FFmpeg / 原生库 ELF 对齐）
- 内置 FFmpeg 可能缺少 `drawtext` → `textCard` 回退为纯色短视频
- 人脸比对仅为 **几何相似度**，文案与产品预期勿当作身份核验
- EPUB 为 stub，非正式排版转换
- 系统多选选择器在自动化下不稳定；FFmpeg 设备测试可直接注入 cache 路径
- Camera 部分页面依赖 `media` feature 的 job 状态（架构上的有意复用）

---

## 开发约定（速查）

- 新增媒体能力：扩展 `MediaToolType` + `MediaJobCommands` +（如需）Service 重试分支
- 光感 / EventChannel 必须在 **UI 线程** 回调
- Light Meter UI 节流约 8–10 Hz；实时数值可排除 Semantics
- 错误：映射 `AppFailure`，仓库返回 `Result.failure(...)`
- Freezed 生成文件改完后重新 `build_runner` 并 **提交**

---

## 许可证

Private — All rights reserved.
