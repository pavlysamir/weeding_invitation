import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invitation_party/features/invitation/domain/usecases/get_wedding_info.dart';
import 'invitation_state.dart';

class InvitationCubit extends Cubit<InvitationState> {
  final GetWeddingInfo getWeddingInfo;

  InvitationCubit({required this.getWeddingInfo})
      : super(const InvitationInitial());

  Future<void> loadWeddingInfo() async {
    emit(const InvitationLoading());
    final result = await getWeddingInfo();
    result.fold(
      (failure) => emit(InvitationError(failure.message)),
      (info) => emit(InvitationLoaded(weddingInfo: info)),
    );
  }

  void openEnvelope() {
    final current = state;
    if (current is InvitationLoaded) {
      emit(current.copyWith(envelopeOpened: true));
    }
  }

  void nextGalleryImage() {
    final current = state;
    if (current is InvitationLoaded) {
      final total = current.weddingInfo.galleryItems.length;
      final next = (current.currentGalleryIndex + 1) % total;
      emit(current.copyWith(currentGalleryIndex: next));
    }
  }

  void previousGalleryImage() {
    final current = state;
    if (current is InvitationLoaded) {
      final total = current.weddingInfo.galleryItems.length;
      final prev = (current.currentGalleryIndex - 1 + total) % total;
      emit(current.copyWith(currentGalleryIndex: prev));
    }
  }

  void goToGalleryImage(int index) {
    final current = state;
    if (current is InvitationLoaded) {
      emit(current.copyWith(currentGalleryIndex: index));
    }
  }
}
