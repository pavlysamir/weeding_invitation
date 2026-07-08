import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invitation_party/core/constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String subtitle;
  final String title;
  final Color? subtitleColor;
  final Color? titleColor;

  const SectionTitle({
    super.key,
    required this.subtitle,
    required this.title,
    this.subtitleColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          subtitle.toUpperCase(),
          style: GoogleFonts.cormorantGaramond(
            fontSize: 12,
            letterSpacing: 4,
            color: subtitleColor ?? AppColors.gold,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: GoogleFonts.playfairDisplay(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: titleColor ?? AppColors.textPrimary,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 1,
              color: subtitleColor ?? AppColors.gold,
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.spa_outlined,
              size: 16,
              color: subtitleColor ?? AppColors.gold,
            ),
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 1,
              color: subtitleColor ?? AppColors.gold,
            ),
          ],
        ),
      ],
    );
  }
}
