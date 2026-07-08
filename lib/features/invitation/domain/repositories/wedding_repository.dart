import 'package:dartz/dartz.dart';
import 'package:invitation_party/core/error/failures.dart';
import '../entities/wedding_info.dart';

abstract class WeddingRepository {
  Future<Either<Failure, WeddingInfo>> getWeddingInfo();
}
