import 'package:equatable/equatable.dart';
import 'package:invitation_party/features/invitation/domain/entities/wedding_info.dart';

abstract class InvitationState extends Equatable {
  const InvitationState();

  @override
  List<Object?> get props => [];
}

class InvitationInitial extends InvitationState {
  const InvitationInitial();
}

class InvitationLoading extends InvitationState {
  const InvitationLoading();
}

class InvitationLoaded extends InvitationState {
  final WeddingInfo weddingInfo;
  final bool envelopeOpened;
  final int currentGalleryIndex;

  const InvitationLoaded({
    required this.weddingInfo,
    this.envelopeOpened = false,
    this.currentGalleryIndex = 0,
  });

  InvitationLoaded copyWith({
    WeddingInfo? weddingInfo,
    bool? envelopeOpened,
    int? currentGalleryIndex,
  }) {
    return InvitationLoaded(
      weddingInfo: weddingInfo ?? this.weddingInfo,
      envelopeOpened: envelopeOpened ?? this.envelopeOpened,
      currentGalleryIndex: currentGalleryIndex ?? this.currentGalleryIndex,
    );
  }

  @override
  List<Object?> get props => [weddingInfo, envelopeOpened, currentGalleryIndex];
}

class InvitationError extends InvitationState {
  final String message;
  const InvitationError(this.message);

  @override
  List<Object?> get props => [message];
}
