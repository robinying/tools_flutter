import 'package:go_router/go_router.dart';
import '../features/camera/presentation/camera_home_page.dart';
import '../features/camera/presentation/photo_page.dart';
import '../features/camera/presentation/record_page.dart';
import '../features/camera/presentation/slideshow_page.dart';
import '../features/camera/presentation/text_video_page.dart';
import '../features/ebook/presentation/ebook_page.dart';
import '../features/face/presentation/face_compare_page.dart';
import '../features/home/home_page.dart';
import '../features/lightlux/presentation/light_meter_page.dart';
import '../features/lightlux/presentation/snapshot_list_page.dart';
import '../features/media/domain/entities/media_tool.dart';
import '../features/media/presentation/media_home_page.dart';
import '../features/media/presentation/media_tool_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomePage()),
    GoRoute(path: '/media', builder: (_, __) => const MediaHomePage()),
    GoRoute(
      path: '/media/tool/:type',
      builder: (_, state) {
        final type = MediaToolType.tryParse(state.pathParameters['type']);
        if (type == null) {
          return const MediaHomePage();
        }
        return MediaToolPage(type: type);
      },
    ),
    GoRoute(path: '/camera', builder: (_, __) => const CameraHomePage()),
    GoRoute(path: '/camera/photo', builder: (_, __) => const PhotoPage()),
    GoRoute(path: '/camera/record', builder: (_, __) => const RecordPage()),
    GoRoute(path: '/camera/text', builder: (_, __) => const TextVideoPage()),
    GoRoute(path: '/camera/slideshow', builder: (_, __) => const SlideshowPage()),
    GoRoute(path: '/light', builder: (_, __) => const LightMeterPage()),
    GoRoute(path: '/light/history', builder: (_, __) => const SnapshotListPage()),
    GoRoute(path: '/face', builder: (_, __) => const FaceComparePage()),
    GoRoute(path: '/ebook', builder: (_, __) => const EbookPage()),
  ],
);
