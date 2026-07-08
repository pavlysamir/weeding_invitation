import 'package:get_it/get_it.dart';
import 'package:invitation_party/features/invitation/data/repositories/wedding_repository_impl.dart';
import 'package:invitation_party/features/invitation/domain/repositories/wedding_repository.dart';
import 'package:invitation_party/features/invitation/domain/usecases/get_wedding_info.dart';
import 'package:invitation_party/features/invitation/presentation/cubit/invitation_cubit.dart';
import 'package:invitation_party/features/invitation/presentation/cubit/music_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(() => InvitationCubit(getWeddingInfo: sl()));
  sl.registerFactory(() => MusicCubit());

  // Use cases
  sl.registerLazySingleton(() => GetWeddingInfo(sl()));

  // Repositories
  sl.registerLazySingleton<WeddingRepository>(
    () => WeddingRepositoryImpl(),
  );
}
