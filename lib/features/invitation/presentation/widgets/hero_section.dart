import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invitation_party/core/constants/app_colors.dart';
import 'package:invitation_party/features/invitation/domain/entities/wedding_info.dart';
import 'package:intl/intl.dart';

class HeroSection extends StatelessWidget {
  final WeddingInfo info;

  const HeroSection({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMMM d, yyyy').format(info.weddingDate);

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 100),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFDF0E8), Color(0xFFFFF8F4), Color(0xFFFAF5EE)],
        ),
      ),
      child: Stack(
        children: [
          // Decorative floral elements
          Positioned(
            top: -20,
            left: -30,
            child: _FloralDecoration(rotation: 0),
          ),
          Positioned(
            top: -20,
            right: -30,
            child: _FloralDecoration(rotation: 3.14159),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: _FloralDecoration(rotation: 1.5, size: 140),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: _FloralDecoration(rotation: -1.5, size: 140),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
            child: Column(
              children: [
                // Wedding Logo
                Image.asset(
                  'assets/images/wedding_logo.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                )
                .animate()
                .fadeIn(delay: 100.ms, duration: 800.ms)
                .scale(begin: const Offset(0.9, 0.9)),
                const SizedBox(height: 24),

                // "The Wedding of" label
                Text(
                      'T H E   W E D D I N G   O F',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 12,
                        letterSpacing: 5,
                        color: AppColors.gold,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 800.ms)
                    .slideY(begin: 0.2),
                const SizedBox(height: 24),

                // Bride & Groom Names
                RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: info.groomName,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: _nameFontSize(context),
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 800.ms)
                    .slideY(begin: 0.2),

                // Ampersand
                Text(
                      '&',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: _ampFontSize(context),
                        fontStyle: FontStyle.italic,
                        color: AppColors.primaryRose,
                        height: 0.9,
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 800.ms)
                    .scale(begin: const Offset(0.8, 0.8)),

                RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: info.brideName,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: _nameFontSize(context),
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 800.ms, duration: 800.ms)
                    .slideY(begin: 0.2),

                const SizedBox(height: 32),

                // Divider with rings
                _RingsDivider().animate().fadeIn(
                  delay: 1000.ms,
                  duration: 600.ms,
                ),

                const SizedBox(height: 32),

                // Date
                Text(
                  formattedDate,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 22,
                    color: AppColors.textSecondary,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fadeIn(delay: 1100.ms, duration: 700.ms),

                const SizedBox(height: 8),

                // Time
                Text(
                  DateFormat('h:mm a').format(info.weddingDate),
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 16,
                    color: AppColors.gold,
                    letterSpacing: 3,
                  ),
                ).animate().fadeIn(delay: 1200.ms, duration: 700.ms),

                const SizedBox(height: 16),

                // Venue
                Text(
                  info.venueName,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 1300.ms, duration: 700.ms),

                const SizedBox(height: 40),

                // Welcome message
                Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        info.welcomeMessage,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 18,
                          color: AppColors.textSecondary,
                          fontStyle: FontStyle.italic,
                          height: 1.8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 1400.ms, duration: 800.ms)
                    .slideY(begin: 0.1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _nameFontSize(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w > 900) return 72;
    if (w > 600) return 56;
    return 40;
  }

  double _ampFontSize(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w > 900) return 96;
    if (w > 600) return 72;
    return 56;
  }
}

class _RingsDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 60, height: 1, color: AppColors.gold),
        const SizedBox(width: 12),
        // Two rings
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.gold, width: 2),
                color: Colors.transparent,
              ),
            ),
            Positioned(
              left: 16,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryRose, width: 2),
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 24),
        Container(width: 60, height: 1, color: AppColors.gold),
      ],
    );
  }
}

class _FloralDecoration extends StatelessWidget {
  final double rotation;
  final double size;

  const _FloralDecoration({this.rotation = 0, this.size = 200});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Text(
        '🌿',
        style: TextStyle(
          fontSize: size * 0.5,
          color: Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }
}
