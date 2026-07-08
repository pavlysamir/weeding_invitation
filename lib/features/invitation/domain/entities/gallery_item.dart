import 'package:equatable/equatable.dart';

class GalleryItem extends Equatable {
  final String imagePath;
  final String caption;

  const GalleryItem({
    required this.imagePath,
    required this.caption,
  });

  @override
  List<Object?> get props => [imagePath];
}
