import 'package:dartz/dartz.dart';
import 'package:invitation_party/core/constants/wedding_data.dart';
import 'package:invitation_party/core/error/failures.dart';
import 'package:invitation_party/features/invitation/domain/entities/wedding_info.dart';
import 'package:invitation_party/features/invitation/domain/repositories/wedding_repository.dart';

class WeddingRepositoryImpl implements WeddingRepository {
  @override
  Future<Either<Failure, WeddingInfo>> getWeddingInfo() async {
    try {
      return Right(WeddingData.info);
    } catch (e) {
      return const Left(CacheFailure('Failed to load wedding data'));
    }
  }
}
