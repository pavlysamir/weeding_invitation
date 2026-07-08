import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invitation_party/core/constants/app_colors.dart';
import 'package:invitation_party/core/widgets/animated_fade_in.dart';
import 'package:invitation_party/core/widgets/section_title.dart';
import 'package:invitation_party/features/invitation/domain/entities/wedding_info.dart';

class DressCodeSection extends StatelessWidget {
  final WeddingInfo info;

  const DressCodeSection({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.background, AppColors.blush],
        ),
      ),
      child: Column(
        children: [
          AnimatedFadeIn(
            child: const SectionTitle(
              subtitle: 'dress to impress',
              title: 'Dress Code',
            ),
          ),
          const SizedBox(height: 48),

          AnimatedFadeIn(
            delay: const Duration(milliseconds: 200),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Row(
                children: [
                  Expanded(
                    child: _AttireCard(
                      icon: '🤵',
                      label: 'Gentlemen',
                      description: info.dressCodMen,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _AttireCard(
                      icon: '👗',
                      label: 'Ladies',
                      description: info.dressCodWomen,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 48),

          // Color palette
          AnimatedFadeIn(
            delay: const Duration(milliseconds: 400),
            child: Column(
              children: [
                Text(
                  'S U G G E S T E D   C O L O R S',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 12,
                    letterSpacing: 4,
                    color: AppColors.gold,
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: info.dressCodeColors.map((colorValue) {
                    return _ColorSwatch(color: Color(colorValue));
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AttireCard extends StatelessWidget {
  final String icon;
  final String label;
  final String description;

  const _AttireCard({
    required this.icon,
    required this.label,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryRose.withOpacity(0.08),
            blurRadius: 24,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 12),
          Text(
            label,
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 1,
            color: AppColors.gold,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ColorSwatch extends StatefulWidget {
  final Color color;

  const _ColorSwatch({required this.color});

  @override
  State<_ColorSwatch> createState() => _ColorSwatchState();
}

class _ColorSwatchState extends State<_ColorSwatch> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _hovered ? 56 : 48,
        height: _hovered ? 56 : 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.color.withOpacity(0.5),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : [],
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
        ),
      ),
    );
  }
}
