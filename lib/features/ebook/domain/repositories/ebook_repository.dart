import '../../../../core/error/error.dart';

abstract class EbookRepository {
  Future<Result<String>> convertEpub(String path);
}
