import 'package:equatable/equatable.dart';

class FaqItem extends Equatable {
  final String question;
  final String answer;

  const FaqItem({
    required this.question,
    required this.answer,
  });

  @override
  List<Object?> get props => [question];
}
