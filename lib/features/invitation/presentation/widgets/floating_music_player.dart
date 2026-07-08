import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invitation_party/core/constants/app_colors.dart';
import 'package:invitation_party/features/invitation/presentation/cubit/music_cubit.dart';

class FloatingMusicPlayer extends StatelessWidget {
  const FloatingMusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicCubit, MusicState>(
      builder: (context, state) {
        final isPlaying = state is MusicPlaying;
        return GestureDetector(
          onTap: () => context.read<MusicCubit>().toggle(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isPlaying ? AppColors.textPrimary : Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: (isPlaying ? AppColors.textPrimary : AppColors.primaryRose)
                      .withOpacity(0.25),
                  blurRadius: 16,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: isPlaying ? AppColors.gold : AppColors.border,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated music bars or icon
                if (isPlaying)
                  _MusicBarsAnimation()
                else
                  Icon(
                    Icons.music_note_rounded,
                    color: AppColors.primaryRose,
                    size: 18,
                  ),
                const SizedBox(width: 8),
                Text(
                  isPlaying ? 'Playing' : 'Music',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                    color: isPlaying ? AppColors.gold : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MusicBarsAnimation extends StatefulWidget {
  @override
  State<_MusicBarsAnimation> createState() => _MusicBarsAnimationState();
}

class _MusicBarsAnimationState extends State<_MusicBarsAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      4,
      (i) => AnimationController(
        duration: Duration(milliseconds: 300 + i * 100),
        vsync: this,
      )..repeat(reverse: true),
    );
    _animations = _controllers
        .map((c) => Tween<double>(begin: 4, end: 16).animate(
              CurvedAnimation(parent: c, curve: Curves.easeInOut),
            ))
        .toList();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(4, (i) {
        return AnimatedBuilder(
          animation: _animations[i],
          builder: (_, __) => Container(
            width: 3,
            height: _animations[i].value,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: AppColors.gold,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
