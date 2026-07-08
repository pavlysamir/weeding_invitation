import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invitation_party/core/constants/app_colors.dart';
import 'package:invitation_party/core/widgets/animated_fade_in.dart';
import 'package:invitation_party/core/widgets/section_title.dart';
import 'package:invitation_party/features/invitation/domain/entities/schedule_item.dart';

class ScheduleSection extends StatelessWidget {
  final List<ScheduleItem> items;

  const ScheduleSection({super.key, required this.items});

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
              subtitle: 'the day\'s itinerary',
              title: 'Wedding Schedule',
            ),
          ),
          const SizedBox(height: 56),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              children: List.generate(items.length, (index) {
                return AnimatedFadeIn(
                  delay: Duration(milliseconds: 150 * index),
                  child: _ScheduleTimelineItem(
                    item: items[index],
                    isLast: index == items.length - 1,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleTimelineItem extends StatelessWidget {
  final ScheduleItem item;
  final bool isLast;

  const _ScheduleTimelineItem({required this.item, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time column
          SizedBox(
            width: 90,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                item.time,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 15,
                  color: AppColors.gold,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const SizedBox(width: 20),

          // Timeline line & dot
          Column(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blush,
                  border: Border.all(color: AppColors.primaryRose, width: 1.5),
                ),
                child: Center(
                  child: Text(item.icon, style: const TextStyle(fontSize: 20)),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    color: AppColors.lightRose,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 20),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 36, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                      height: 1.5,
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
}
