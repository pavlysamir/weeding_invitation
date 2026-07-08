import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:audioplayers/audioplayers.dart';

abstract class MusicState extends Equatable {
  const MusicState();
  @override
  List<Object?> get props => [];
}

class MusicStopped extends MusicState {
  const MusicStopped();
}

class MusicPlaying extends MusicState {
  const MusicPlaying();
}

class MusicCubit extends Cubit<MusicState> {
  final AudioPlayer _player = AudioPlayer();

  MusicCubit() : super(const MusicStopped());

  Future<void> toggle() async {
    if (state is MusicPlaying) {
      await _player.pause();
      emit(const MusicStopped());
    } else {
      try {
        await _player.setReleaseMode(ReleaseMode.loop);
        await _player.play(AssetSource('audio/wedding_music.mp3'));
        emit(const MusicPlaying());
      } catch (_) {
        // Audio file not yet available — silent fail
        emit(const MusicStopped());
      }
    }
  }

  @override
  Future<void> close() {
    _player.dispose();
    return super.close();
  }
}
