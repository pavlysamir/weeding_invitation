import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class EnvelopeCover extends StatefulWidget {
  final VoidCallback onOpen;

  const EnvelopeCover({super.key, required this.onOpen});

  @override
  State<EnvelopeCover> createState() => _EnvelopeCoverState();
}

class _EnvelopeCoverState extends State<EnvelopeCover>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _openController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeOutAnimation;
  bool _tapped = false;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _openController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _openController, curve: Curves.easeInOut),
    );

    _fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _openController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _openController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onOpen();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _openController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (!_tapped) {
      setState(() => _tapped = true);
      _pulseController.stop();
      _openController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 500;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF8F0E8),
            Color(0xFFF2E4D4),
            Color(0xFFEED8C4),
            Color(0xFFE8CCBA),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Decorative floral corners
          Positioned(
            top: 0,
            left: 0,
            child: _FloralCorner(flipX: false, flipY: false),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: _FloralCorner(flipX: true, flipY: false),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: _FloralCorner(flipX: false, flipY: true),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: _FloralCorner(flipX: true, flipY: true),
          ),

          // Main content
          Center(
            child: GestureDetector(
              onTap: _handleTap,
              child: AnimatedBuilder(
                animation: _openController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeOutAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Envelope card
                    Container(
                      width: isSmall ? size.width * 0.85 : 380,
                      constraints: const BoxConstraints(maxWidth: 400),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF8B6040).withOpacity(0.25),
                            blurRadius: 50,
                            spreadRadius: 10,
                            offset: const Offset(0, 20),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: _EnvelopeCard(),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Tap hint
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: 0.5 + _pulseController.value * 0.5,
                          child: child,
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            '✦  T A P   T O   O P E N  ✦',
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 13,
                              letterSpacing: 4,
                              color: const Color(0xFF8B6040),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: const Color(0xFF8B6040).withOpacity(0.6),
                                size: 24,
                              )
                              .animate(onPlay: (c) => c.repeat(reverse: true))
                              .slideY(
                                begin: -0.3,
                                end: 0.3,
                                duration: 1200.ms,
                                curve: Curves.easeInOut,
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EnvelopeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background — sage green linen texture
        Container(
          width: double.infinity,
          height: 520,
          color: const Color(0xFF9DB5A8),
          child: CustomPaint(painter: _LinenTexturePainter()),
        ),

        // Botanical watermark prints
        Positioned(
          top: 20,
          left: 20,
          child: Opacity(
            opacity: 0.12,
            child: Text('🌿', style: const TextStyle(fontSize: 90)),
          ),
        ),
        Positioned(
          top: 10,
          right: 15,
          child: Opacity(
            opacity: 0.10,
            child: Transform.rotate(
              angle: 0.5,
              child: Text('🌿', style: const TextStyle(fontSize: 70)),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 10,
          child: Opacity(
            opacity: 0.10,
            child: Transform.rotate(
              angle: -0.8,
              child: Text('🌿', style: const TextStyle(fontSize: 80)),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          right: 20,
          child: Opacity(
            opacity: 0.12,
            child: Transform.rotate(
              angle: 2.0,
              child: Text('🌿', style: const TextStyle(fontSize: 60)),
            ),
          ),
        ),

        // Envelope flap lines (decorative)
        Positioned.fill(child: CustomPaint(painter: _EnvelopeFlapPainter())),

        // Content overlay
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // "You are invited" text
              Text(
                'Y O U   A R E   I N V I T E D',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 11,
                  letterSpacing: 3.5,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ).animate().fadeIn(delay: 300.ms, duration: 800.ms),

              const SizedBox(height: 28),

              // Wax seal
              _WaxSeal()
                  .animate()
                  .scale(
                    delay: 200.ms,
                    duration: 600.ms,
                    curve: Curves.elasticOut,
                    begin: const Offset(0.5, 0.5),
                  )
                  .fadeIn(delay: 200.ms, duration: 400.ms),

              const SizedBox(height: 28),

              // "To our special day"
              Text(
                'F O R   O U R   S P E C I A L   D A Y',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 10,
                  letterSpacing: 3,
                  color: Colors.white.withOpacity(0.7),
                ),
              ).animate().fadeIn(delay: 400.ms, duration: 800.ms),
            ],
          ),
        ),
      ],
    );
  }
}

class _WaxSeal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          center: Alignment(-0.3, -0.3),
          radius: 0.8,
          colors: [Color(0xFFCC3333), Color(0xFFAA1111), Color(0xFF880000)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF880000).withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 3,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'E',
              style: GoogleFonts.playfairDisplay(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.92),
                fontStyle: FontStyle.italic,
                height: 1,
              ),
            ),
            Text(
              '&',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
                height: 1,
              ),
            ),
            Text(
              'A',
              style: GoogleFonts.playfairDisplay(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.92),
                fontStyle: FontStyle.italic,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloralCorner extends StatelessWidget {
  final bool flipX;
  final bool flipY;

  const _FloralCorner({required this.flipX, required this.flipY});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: flipX ? -1 : 1,
      scaleY: flipY ? -1 : 1,
      child:
          Opacity(
                opacity: 0.3,
                child: Text('🌸', style: const TextStyle(fontSize: 60)),
              )
              .animate()
              .fadeIn(delay: 800.ms, duration: 1000.ms)
              .slideY(begin: flipY ? 0.3 : -0.3, curve: Curves.easeOut),
    );
  }
}

class _LinenTexturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Subtle grid lines for linen texture
    for (double x = 0; x < size.width; x += 4) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EnvelopeFlapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.08)
      ..style = PaintingStyle.fill;

    // Top flap triangle
    final topPath = Path();
    topPath.moveTo(0, 0);
    topPath.lineTo(size.width, 0);
    topPath.lineTo(size.width / 2, size.height * 0.38);
    topPath.close();
    canvas.drawPath(topPath, paint);

    // Bottom flap
    final botPaint = Paint()
      ..color = Colors.black.withOpacity(0.05)
      ..style = PaintingStyle.fill;
    final botPath = Path();
    botPath.moveTo(0, size.height);
    botPath.lineTo(size.width, size.height);
    botPath.lineTo(size.width / 2, size.height * 0.62);
    botPath.close();
    canvas.drawPath(botPath, botPaint);

    // Side triangles (subtle)
    final sidePaint = Paint()
      ..color = Colors.black.withOpacity(0.04)
      ..style = PaintingStyle.fill;

    final leftPath = Path();
    leftPath.moveTo(0, 0);
    leftPath.lineTo(0, size.height);
    leftPath.lineTo(size.width / 2, size.height * 0.5);
    leftPath.close();
    canvas.drawPath(leftPath, sidePaint);

    final rightPath = Path();
    rightPath.moveTo(size.width, 0);
    rightPath.lineTo(size.width, size.height);
    rightPath.lineTo(size.width / 2, size.height * 0.5);
    rightPath.close();
    canvas.drawPath(rightPath, sidePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
