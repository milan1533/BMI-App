import 'package:flutter/material.dart';

/// ActivityCard — History mein har activity dikhane ke liye.
/// Date, exercise type, stats (duration/steps/calories) aur Edit/Delete buttons.
class ActivityCard extends StatelessWidget {
  final String date;
  final String exerciseType;
  final int workoutMinutes;
  final int steps;
  final int calories;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ActivityCard({
    super.key,
    required this.date,
    required this.exerciseType,
    required this.workoutMinutes,
    required this.steps,
    required this.calories,
    this.onEdit,
    this.onDelete,
  });

  /// Number mein commas add karta hai: 5240 → "5,240"
  String _formatNumber(int number) {
    final str = number.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(str[i]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Date ---
            Text(
              date,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            // --- Exercise Type ---
            Text(
              exerciseType,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // --- Stats Row ---
            Row(
              children: [
                _buildStat(Icons.timer_outlined, '$workoutMinutes min'),
                const SizedBox(width: 20),
                _buildStat(
                  Icons.directions_walk,
                  '${_formatNumber(steps)} steps',
                ),
                const SizedBox(width: 20),
                _buildStat(
                  Icons.local_fire_department_outlined,
                  '${_formatNumber(calories)} kcal',
                ),
              ],
            ),

            const Divider(height: 24),

            // --- Action Buttons ---
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text('Edit'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.purple,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outlined, size: 18),
                  label: const Text('Delete'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red.shade400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Individual stat item: icon + text
  Widget _buildStat(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}
