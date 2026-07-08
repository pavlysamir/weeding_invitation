import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invitation_party/features/invitation/presentation/cubit/invitation_cubit.dart';
import 'package:invitation_party/features/invitation/presentation/cubit/invitation_state.dart';
import 'package:invitation_party/features/invitation/presentation/widgets/boarding_pass_section.dart';
import 'package:invitation_party/features/invitation/presentation/widgets/countdown_section.dart';
import 'package:invitation_party/features/invitation/presentation/widgets/dress_code_section.dart';
import 'package:invitation_party/features/invitation/presentation/widgets/envelope_cover.dart';
import 'package:invitation_party/features/invitation/presentation/widgets/faq_section.dart';
import 'package:invitation_party/features/invitation/presentation/widgets/floating_music_player.dart';
import 'package:invitation_party/features/invitation/presentation/widgets/footer_section.dart';
import 'package:invitation_party/features/invitation/presentation/widgets/gallery_section.dart';
import 'package:invitation_party/features/invitation/presentation/widgets/hero_section.dart';
import 'package:invitation_party/features/invitation/presentation/widgets/schedule_section.dart';
import 'package:invitation_party/features/invitation/presentation/widgets/venue_section.dart';

class InvitationPage extends StatelessWidget {
  const InvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvitationCubit, InvitationState>(
      builder: (context, state) {
        if (state is InvitationLoading || state is InvitationInitial) {
          return const _LoadingScreen();
        }

        if (state is InvitationError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        if (state is InvitationLoaded) {
          if (!state.envelopeOpened) {
            return Scaffold(
              body: EnvelopeCover(
                onOpen: () => context.read<InvitationCubit>().openEnvelope(),
              ),
            );
          }

          // Main invitation page
          return Scaffold(
            body: Stack(
              children: [
                // Scrollable content
                SingleChildScrollView(
                  child: Column(
                    children: [
                      HeroSection(info: state.weddingInfo),
                      CountdownSection(
                        targetDate: state.weddingInfo.weddingDate,
                      ),
                      VenueSection(info: state.weddingInfo),
                      ScheduleSection(items: state.weddingInfo.scheduleItems),
                      GallerySection(
                        items: state.weddingInfo.galleryItems,
                        currentIndex: state.currentGalleryIndex,
                      ),
                      DressCodeSection(info: state.weddingInfo),
                      FaqSection(items: state.weddingInfo.faqItems),
                      BoardingPassSection(info: state.weddingInfo),
                      FooterSection(
                        brideName: state.weddingInfo.brideName,
                        groomName: state.weddingInfo.groomName,
                      ),
                    ],
                  ),
                ),

                // Floating music player
                Positioned(
                  bottom: 24,
                  right: 24,
                  child: const FloatingMusicPlayer(),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF0E8),
      body: const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFC9A96E),
          strokeWidth: 1.5,
        ),
      ),
    );
  }
}
