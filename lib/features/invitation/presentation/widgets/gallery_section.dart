import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invitation_party/core/constants/app_colors.dart';
import 'package:invitation_party/core/widgets/animated_fade_in.dart';
import 'package:invitation_party/core/widgets/section_title.dart';
import 'package:invitation_party/features/invitation/domain/entities/gallery_item.dart';
import 'package:invitation_party/features/invitation/presentation/cubit/invitation_cubit.dart';

class GallerySection extends StatelessWidget {
  final List<GalleryItem> items;
  final int currentIndex;

  const GallerySection({
    super.key,
    required this.items,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: AppColors.surface,
      child: Column(
        children: [
          AnimatedFadeIn(
            child: const SectionTitle(
              subtitle: 'our journey',
              title: 'Gallery',
            ),
          ),
          const SizedBox(height: 48),

          AnimatedFadeIn(
            delay: const Duration(milliseconds: 200),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  // Main image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Stack(
                        children: [
                          // Image
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: _GalleryImage(
                              key: ValueKey(currentIndex),
                              item: items[currentIndex],
                            ),
                          ),

                          // Navigation arrows
                          Positioned(
                            left: 12,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: _NavButton(
                                icon: Icons.arrow_back_ios_rounded,
                                onTap: () => context
                                    .read<InvitationCubit>()
                                    .previousGalleryImage(),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 12,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: _NavButton(
                                icon: Icons.arrow_forward_ios_rounded,
                                onTap: () => context
                                    .read<InvitationCubit>()
                                    .nextGalleryImage(),
                              ),
                            ),
                          ),

                          // Caption
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.5),
                                  ],
                                ),
                              ),
                              child: Text(
                                items[currentIndex].caption,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Dots indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(items.length, (index) {
                      final isSelected = index == currentIndex;
                      return GestureDetector(
                        onTap: () => context
                            .read<InvitationCubit>()
                            .goToGalleryImage(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isSelected ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryRose
                                : AppColors.lightRose,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GalleryImage extends StatelessWidget {
  final GalleryItem item;

  const _GalleryImage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        item.imagePath,
        fit: BoxFit.fitHeight,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.champagne,
            child: Center(
              child: Icon(
                Icons.photo_camera_outlined,
                size: 64,
                color: AppColors.gold.withValues(alpha: 0.5),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.85),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
          ],
        ),
        child: Icon(icon, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}
