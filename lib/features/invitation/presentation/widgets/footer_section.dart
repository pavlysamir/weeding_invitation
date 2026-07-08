import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invitation_party/core/constants/app_colors.dart';

class FooterSection extends StatelessWidget {
  final String brideName;
  final String groomName;

  const FooterSection({
    super.key,
    required this.brideName,
    required this.groomName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.textPrimary,
      ),
      child: Column(
        children: [
          Text(
            '$brideName & $groomName',
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'August 6, 2026',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 14,
              letterSpacing: 3,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 60, height: 1, color: AppColors.gold.withOpacity(0.4)),
              const SizedBox(width: 16),
              Icon(Icons.favorite, color: AppColors.primaryRose, size: 16),
              const SizedBox(width: 16),
              Container(width: 60, height: 1, color: AppColors.gold.withOpacity(0.4)),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'We can\'t wait to celebrate with you.',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 16,
              color: Colors.white.withOpacity(0.6),
              fontStyle: FontStyle.italic,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            '✦ Made with love ✦',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 12,
              letterSpacing: 3,
              color: AppColors.gold.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
