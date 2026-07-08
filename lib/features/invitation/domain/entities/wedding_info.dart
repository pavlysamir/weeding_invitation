import 'package:equatable/equatable.dart';
import 'schedule_item.dart';
import 'gallery_item.dart';
import 'faq_item.dart';

class WeddingInfo extends Equatable {
  final String brideName;
  final String groomName;
  final DateTime weddingDate;
  final String venueName;
  final String venueAddress;
  final String googleMapsUrl;
  final String welcomeMessage;
  final List<ScheduleItem> scheduleItems;
  final List<GalleryItem> galleryItems;
  final List<FaqItem> faqItems;
  final String dressCodMen;
  final String dressCodWomen;
  final List<int> dressCodeColors;
  final String boardingFrom;
  final String boardingTo;
  final String boardingFlight;
  final String boardingGate;
  final String boardingSeat;

  const WeddingInfo({
    required this.brideName,
    required this.groomName,
    required this.weddingDate,
    required this.venueName,
    required this.venueAddress,
    required this.googleMapsUrl,
    required this.welcomeMessage,
    required this.scheduleItems,
    required this.galleryItems,
    required this.faqItems,
    required this.dressCodMen,
    required this.dressCodWomen,
    required this.dressCodeColors,
    required this.boardingFrom,
    required this.boardingTo,
    required this.boardingFlight,
    required this.boardingGate,
    required this.boardingSeat,
  });

  @override
  List<Object?> get props => [
        brideName,
        groomName,
        weddingDate,
        venueName,
        venueAddress,
      ];
}
