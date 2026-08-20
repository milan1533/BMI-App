import 'package:flutter/material.dart';

/// ProgressCard — Dashboard mein steps/calories/workout dikhane ke liye.
/// Ek circular progress indicator hai jismein icon, value aur goal show hota hai.
class ProgressCard extends StatelessWidget {
  final String title;     // e.g., "Steps"
  final String value;     // e.g., "5,240"
  final String goal;      // e.g., "10,000"
  final double progress;  // 0.0 to 1.0
  final IconData icon;    // center icon
  final Color color;      // progress ring color

  const ProgressCard({
    super.key,
    required this.title,
    required this.value,
    required this.goal,
    required this.progress,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --- Circular Progress Indicator ---
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    // clamp ensures progress never exceeds 100%
                    value: progress.clamp(0.0, 1.0),
                    strokeWidth: 7,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation(color),
                  ),
                ),
                Icon(icon, color: color, size: 24),
              ],
            ),

            const SizedBox(height: 12),

            // --- Title ---
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 4),

            // --- Current Value ---
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            // --- Goal ---
            Text(
              '/ $goal',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
