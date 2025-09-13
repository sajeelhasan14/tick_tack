import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tick_tack/UI/widget/neon_cirlce_painter.dart';
import 'package:tick_tack/provider/stopwatch_provider.dart';

class StopWatchScreen extends StatelessWidget {
  const StopWatchScreen({super.key});

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final millis = (duration.inMilliseconds.remainder(1000) ~/ 10)
        .toString()
        .padLeft(2, '0');
    return "$minutes:$seconds.$millis";
  }

  @override
  Widget build(BuildContext context) {
    final stopwatchProvider = context.watch<StopwatchProvider>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.tealAccent, Colors.pinkAccent],
          ).createShader(bounds),
          child: const Text(
            "TickTack",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0f0c29), Color(0xFF302b63), Color(0xFF24243e)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Stopwatch circle
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0,
                end: stopwatchProvider.elapsed.inMilliseconds / 60000,
              ),
              duration: const Duration(milliseconds: 300),
              builder: (context, value, child) {
                return CustomPaint(
                  painter: NeonCirclePainter(progress: value),
                  child: Container(
                    width: 270,
                    height: 270,
                    alignment: Alignment.center,
                    child: Text(
                      _formatTime(stopwatchProvider.elapsed),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 25,
                            color: Colors.tealAccent,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // Last stopped time (glass card)
            if (stopwatchProvider.lastElapsed != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2),),
                ),
                child: Text(
                  "Last Stopped: ${_formatTime(stopwatchProvider.lastElapsed!)}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            const SizedBox(height: 60),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _circleButton(Icons.play_arrow, Colors.tealAccent,
                    stopwatchProvider.start),
                const SizedBox(width: 20),
                _circleButton(Icons.stop, Colors.redAccent,
                    stopwatchProvider.stop),
                const SizedBox(width: 20),
                _circleButton(Icons.refresh, Colors.purpleAccent,
                    stopwatchProvider.reset),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [Colors.white.withValues(alpha: 0.9), Colors.transparent],
            radius: 1.2,
          ),
          border: Border.all(color: color, width: 2),
        ),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}