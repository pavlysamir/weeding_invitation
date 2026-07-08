import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invitation_party/core/constants/app_colors.dart';
import 'package:invitation_party/core/widgets/animated_fade_in.dart';
import 'package:invitation_party/core/widgets/section_title.dart';

class CountdownSection extends StatefulWidget {
  final DateTime targetDate;

  const CountdownSection({super.key, required this.targetDate});

  @override
  State<CountdownSection> createState() => _CountdownSectionState();
}

class _CountdownSectionState extends State<CountdownSection> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculate();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _calculate());
  }

  void _calculate() {
    final now = DateTime.now();
    final diff = widget.targetDate.difference(now);
    if (mounted) setState(() => _remaining = diff.isNegative ? Duration.zero : diff);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.countdownBg,
        image: DecorationImage(
          image: AssetImage('assets/images/dark_floral_bg.png'),
          fit: BoxFit.cover,
          opacity: 0.07,
        ),
      ),
      child: Column(
        children: [
          AnimatedFadeIn(
            child: const SectionTitle(
              subtitle: 'marking the moments',
              title: 'Counting Down',
              subtitleColor: AppColors.gold,
              titleColor: AppColors.countdownText,
            ),
          ),
          const SizedBox(height: 48),
          AnimatedFadeIn(
            delay: const Duration(milliseconds: 200),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _CountdownBox(value: days, label: 'Days'),
                _CountdownSeparator(),
                _CountdownBox(value: hours, label: 'Hours'),
                _CountdownSeparator(),
                _CountdownBox(value: minutes, label: 'Minutes'),
                _CountdownSeparator(),
                _CountdownBox(value: seconds, label: 'Seconds'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          AnimatedFadeIn(
            delay: const Duration(milliseconds: 400),
            child: Text(
              'August 6, 2026 · 7:30 PM',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 16,
                color: AppColors.gold,
                letterSpacing: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownBox extends StatelessWidget {
  final int value;
  final String label;

  const _CountdownBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gold.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(4),
        color: Colors.white.withOpacity(0.05),
      ),
      child: Column(
        children: [
          Text(
            value.toString().padLeft(2, '0'),
            style: GoogleFonts.playfairDisplay(
              fontSize: 42,
              fontWeight: FontWeight.w700,
              color: AppColors.countdownText,
              height: 1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label.toUpperCase(),
            style: GoogleFonts.cormorantGaramond(
              fontSize: 10,
              letterSpacing: 3,
              color: AppColors.gold,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        ':',
        style: GoogleFonts.playfairDisplay(
          fontSize: 42,
          fontWeight: FontWeight.w700,
          color: AppColors.gold.withOpacity(0.6),
        ),
      ),
    );
  }
}
