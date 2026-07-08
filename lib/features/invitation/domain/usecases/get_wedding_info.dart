import 'package:dartz/dartz.dart';
import 'package:invitation_party/core/error/failures.dart';
import 'package:invitation_party/features/invitation/domain/entities/wedding_info.dart';
import 'package:invitation_party/features/invitation/domain/repositories/wedding_repository.dart';

class GetWeddingInfo {
  final WeddingRepository repository;

  GetWeddingInfo(this.repository);

  Future<Either<Failure, WeddingInfo>> call() async {
    return await repository.getWeddingInfo();
  }
}
