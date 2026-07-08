import 'package:equatable/equatable.dart';

class ScheduleItem extends Equatable {
  final String time;
  final String title;
  final String description;
  final String icon;

  const ScheduleItem({
    required this.time,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  List<Object?> get props => [time, title];
}
