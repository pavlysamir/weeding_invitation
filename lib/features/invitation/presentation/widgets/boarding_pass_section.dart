import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invitation_party/core/constants/app_colors.dart';
import 'package:invitation_party/core/widgets/animated_fade_in.dart';
import 'package:invitation_party/core/widgets/section_title.dart';
import 'package:invitation_party/features/invitation/domain/entities/wedding_info.dart';
import 'package:intl/intl.dart';

class BoardingPassSection extends StatelessWidget {
  final WeddingInfo info;

  const BoardingPassSection({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: AppColors.background,
      child: Column(
        children: [
          AnimatedFadeIn(
            child: const SectionTitle(
              subtitle: 'your invitation',
              title: 'Boarding Pass',
            ),
          ),
          const SizedBox(height: 48),
          AnimatedFadeIn(
            delay: const Duration(milliseconds: 200),
            child: _BoardingPassCard(info: info),
          ),
        ],
      ),
    );
  }
}

class _BoardingPassCard extends StatelessWidget {
  final WeddingInfo info;

  const _BoardingPassCard({required this.info});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final cardW = screenW > 700 ? 680.0 : screenW - 48;

    return Container(
      width: cardW,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.12),
            blurRadius: 40,
            spreadRadius: 4,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Left section
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.textPrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Airline-like name
                    Text(
                      'LOVE AIR ✈',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 13,
                        letterSpacing: 4,
                        color: AppColors.gold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // From → To
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'FROM',
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 10,
                                  letterSpacing: 3,
                                  color: AppColors.gold.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                info.boardingFrom,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Icon(
                                Icons.flight,
                                color: AppColors.gold,
                                size: 24,
                              ),
                              Container(
                                width: 40,
                                height: 1,
                                color: AppColors.gold.withOpacity(0.4),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'TO',
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 10,
                                  letterSpacing: 3,
                                  color: AppColors.gold.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                info.boardingTo,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    Container(height: 1, color: Colors.white.withOpacity(0.1)),
                    const SizedBox(height: 24),

                    // Passenger
                    _BoardingField(
                      label: 'PASSENGER',
                      value:
                          '${info.brideName} & ${info.groomName}',
                      dark: true,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _BoardingField(
                            label: 'DATE',
                            value: DateFormat('dd MMM yyyy')
                                .format(info.weddingDate),
                            dark: true,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _BoardingField(
                            label: 'TIME',
                            value: DateFormat('h:mm a')
                                .format(info.weddingDate),
                            dark: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Tear-off notch
            SizedBox(
              width: 0,
              child: OverflowBox(
                maxWidth: 24,
                child: _TearOff(),
              ),
            ),

            // Right section (stub)
            Container(
              width: 120,
              decoration: const BoxDecoration(
                color: AppColors.champagne,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _BoardingField(
                    label: 'FLIGHT',
                    value: info.boardingFlight,
                    dark: false,
                  ),
                  _BoardingField(
                    label: 'GATE',
                    value: info.boardingGate,
                    dark: false,
                  ),
                  _BoardingField(
                    label: 'SEAT',
                    value: info.boardingSeat,
                    dark: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BoardingField extends StatelessWidget {
  final String label;
  final String value;
  final bool dark;

  const _BoardingField({
    required this.label,
    required this.value,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 9,
            letterSpacing: 3,
            color: dark
                ? AppColors.gold.withOpacity(0.7)
                : AppColors.textLight,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: GoogleFonts.playfairDisplay(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: dark ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _TearOff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: 24, height: 12, decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        )),
        Expanded(
          child: Container(
            width: 1,
            color: AppColors.border,
          ),
        ),
        Container(width: 24, height: 12, decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        )),
      ],
    );
  }
}
