import 'package:invitation_party/features/invitation/domain/entities/faq_item.dart';
import 'package:invitation_party/features/invitation/domain/entities/gallery_item.dart';
import 'package:invitation_party/features/invitation/domain/entities/schedule_item.dart';
import 'package:invitation_party/features/invitation/domain/entities/wedding_info.dart';

class WeddingData {
  static WeddingInfo get info => WeddingInfo(
    brideName: 'Elaria',
    groomName: 'Anton',
    weddingDate: DateTime(2026, 8, 6, 19, 30),
    venueName: 'Dar Sanabel Events\nLayali Hall',
    venueAddress: 'Sanabel Events House,\nZakat Foundation Street',
    googleMapsUrl: 'https://maps.app.goo.gl/yGpgh2WBFKHCTySN7',
    welcomeMessage:
        'Together with our families, we joyfully invite you to celebrate the beginning of our forever.',
    scheduleItems: _schedule,
    galleryItems: _gallery,
    faqItems: _faq,
    dressCodMen: 'Formal Suit & Tie',
    dressCodWomen: 'Elegant Evening Dress',
    dressCodeColors: const [
      0xFFD4788A, // dusty rose
      0xFFBFA98B, // champagne
      0xFF8FA68A, // sage
      0xFF6B7FA8, // dusty blue
      0xFF8B6B8B, // mauve
      0xFFD4C4A8, // ivory
    ],
    boardingFrom: 'Your Home',
    boardingTo: 'Layali Hall',
    boardingFlight: 'EA-0806',
    boardingGate: 'LOVE',
    boardingSeat: 'VIP',
  );

  static List<ScheduleItem> get _schedule => [
    const ScheduleItem(
      time: '7:30 PM',
      title: 'Guest Arrival',
      description: 'Welcome drinks & reception',
      icon: '🌸',
    ),
    const ScheduleItem(
      time: '8:00 PM',
      title: 'Wedding Ceremony',
      description: 'The sacred exchange of vows',
      icon: '💍',
    ),
    const ScheduleItem(
      time: '9:00 PM',
      title: 'Dinner',
      description: 'A feast prepared with love',
      icon: '🍽️',
    ),
    const ScheduleItem(
      time: '11:00 PM',
      title: 'Celebration & Dance',
      description: 'Music, dancing & sweet memories',
      icon: '🎶',
    ),
  ];

  static List<GalleryItem> get _gallery => [
    const GalleryItem(
      imagePath: 'assets/images/gallery_1.jpg',
      caption: 'Our Story',
    ),
    const GalleryItem(
      imagePath: 'assets/images/gallery_2.jpg',
      caption: 'The Proposal 💍',
    ),
    const GalleryItem(
      imagePath: 'assets/images/gallery_3.jpg',
      caption: 'Together',
    ),
    const GalleryItem(
      imagePath: 'assets/images/gallery_4.jpg',
      caption: 'Forever Starts Now',
    ),
  ];

  static List<FaqItem> get _faq => [
    const FaqItem(
      question: 'What is the dress code?',
      answer:
          'We kindly ask guests to dress formally. Men are requested to wear suits and ties. Ladies, please wear elegant evening dresses in the suggested color palette.',
    ),
    const FaqItem(
      question: 'Can I bring children?',
      answer:
          'We love your little ones! However, to ensure all guests enjoy a relaxed and romantic evening, we kindly ask that this celebration be for adults only. We appreciate your understanding.',
    ),
    const FaqItem(
      question: 'Is parking available?',
      answer:
          'Yes! Ample parking is available at Sanabel Events House. Valet service will also be provided for your convenience.',
    ),
    const FaqItem(
      question: 'Is there accommodation nearby?',
      answer:
          'Several hotels are located within a short distance of the venue. We recommend booking early as the date approaches.',
    ),
    const FaqItem(
      question: 'Can I take photos during the ceremony?',
      answer:
          'We have a professional photographer capturing every moment. We kindly ask you to keep phones away during the ceremony so you can be fully present. Feel free to take photos during the reception!',
    ),
  ];
}
