import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invitation_party/core/constants/app_colors.dart';
import 'package:invitation_party/core/widgets/animated_fade_in.dart';
import 'package:invitation_party/core/widgets/section_title.dart';
import 'package:invitation_party/features/invitation/domain/entities/faq_item.dart';

class FaqSection extends StatelessWidget {
  final List<FaqItem> items;

  const FaqSection({super.key, required this.items});

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
              subtitle: 'you may wonder',
              title: 'FAQ',
            ),
          ),
          const SizedBox(height: 48),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              children: List.generate(items.length, (index) {
                return AnimatedFadeIn(
                  delay: Duration(milliseconds: 100 * index),
                  child: _FaqAccordion(item: items[index]),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqAccordion extends StatefulWidget {
  final FaqItem item;

  const _FaqAccordion({required this.item});

  @override
  State<_FaqAccordion> createState() => _FaqAccordionState();
}

class _FaqAccordionState extends State<_FaqAccordion>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: _isExpanded ? AppColors.primaryRose : AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Column(
          children: [
            // Header
            InkWell(
              onTap: _toggle,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.item.question,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    AnimatedRotation(
                      turns: _isExpanded ? 0.25 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.add,
                        color: _isExpanded
                            ? AppColors.primaryRose
                            : AppColors.gold,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Expandable answer
            SizeTransition(
              sizeFactor: _expandAnimation,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 1,
                      color: AppColors.divider,
                      margin: const EdgeInsets.only(bottom: 16),
                    ),
                    Text(
                      widget.item.answer,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        height: 1.7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
