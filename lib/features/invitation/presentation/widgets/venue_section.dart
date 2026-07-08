import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invitation_party/core/constants/app_colors.dart';
import 'package:invitation_party/core/widgets/animated_fade_in.dart';
import 'package:invitation_party/core/widgets/section_title.dart';
import 'package:invitation_party/features/invitation/domain/entities/wedding_info.dart';
import 'package:url_launcher/url_launcher.dart';

class VenueSection extends StatelessWidget {
  final WeddingInfo info;

  const VenueSection({super.key, required this.info});

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
              subtitle: 'where love blooms',
              title: 'The Venue',
            ),
          ),
          const SizedBox(height: 48),

          AnimatedFadeIn(
            delay: const Duration(milliseconds: 200),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 700),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryRose.withOpacity(0.08),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Map placeholder with pin
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                    child: Container(
                      height: 240,
                      color: const Color(0xFFF0E8E0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Simple decorative map look
                          CustomPaint(
                            size: const Size(double.infinity, 240),
                            painter: _MapDecorPainter(),
                          ),
                          // Map pin
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryRose,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryRose.withOpacity(0.4),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              Container(
                                width: 2,
                                height: 20,
                                color: AppColors.primaryRose,
                              ),
                              Container(
                                width: 8,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryRose.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Venue details
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Text(
                          info.venueName,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: AppColors.gold,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                info.venueAddress,
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 16,
                                  color: AppColors.textSecondary,
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        ElevatedButton.icon(
                          onPressed: () => _openMaps(info.googleMapsUrl),
                          icon: const Icon(Icons.map_outlined, size: 18),
                          label: Text(
                            'Get Directions',
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.textPrimary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openMaps(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _MapDecorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFFE0D0C0)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    // Simple road-like lines
    canvas.drawLine(
      Offset(0, size.height * 0.3),
      Offset(size.width, size.height * 0.5),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.4, 0),
      Offset(size.width * 0.3, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.5, size.height * 0.6),
      Paint()
        ..color = const Color(0xFFE0D0C0)
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
