import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const ParticleDemoApp());
}

class ParticleDemoApp extends StatelessWidget {
  const ParticleDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CelebrationScreen(),
    );
  }
}

class CelebrationScreen extends StatefulWidget {
  const CelebrationScreen({super.key});

  @override
  State<CelebrationScreen> createState() => _CelebrationScreenState();
}

class _CelebrationScreenState extends State<CelebrationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool showParticles = false;

  List<Particle> particles = [];
  final Random random = Random();

  //  3 Properties
  final Size customSize = const Size(300, 400);
  final bool isComplexValue = true;
  final bool willChangeValue = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // 10 seconds
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            showParticles = false; // hide after 10 seconds
          });
        }
      });
  }

  void startCelebration() {
    //  STOP previous animation completely
    _controller.stop();
    _controller.reset();

    //  Regenerate particles EVERY click
    particles = List.generate(50, (index) {
      return Particle(
        startPosition: const Offset(150, 200),
        radius: random.nextDouble() * 6 + 2,
        color: Colors.primaries[random.nextInt(Colors.primaries.length)],
        speed: random.nextDouble() * 2 + 1,
        direction: random.nextDouble() * 2 * pi,
      );
    });

    setState(() {
      showParticles = true;
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Completion Demo"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: startCelebration,
              child: const Text("Complete Task"),
            ),
          ),
          if (showParticles)
            Center(
              child: CustomPaint(
                size: customSize, // PROPERTY 1
                isComplex: isComplexValue, // PROPERTY 2
                willChange: willChangeValue, // PROPERTY 3
                painter: ParticlePainter(
                  progress: _controller.value,
                  particles: particles,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class Particle {
  final Offset startPosition;
  final double radius;
  final Color color;
  final double speed;
  final double direction;

  Particle({
    required this.startPosition,
    required this.radius,
    required this.color,
    required this.speed,
    required this.direction,
  });

  Offset getCurrentPosition(double progress) {
    final dx = cos(direction) * speed * progress * 200;
    final dy = sin(direction) * speed * progress * 200;
    return startPosition.translate(dx, dy);
  }
}

class ParticlePainter extends CustomPainter {
  final double progress;
  final List<Particle> particles;

  ParticlePainter({
    required this.progress,
    required this.particles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final position = particle.getCurrentPosition(progress);

      final paint = Paint()
        ..color = particle.color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(position, particle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
