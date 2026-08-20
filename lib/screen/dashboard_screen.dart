import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../compontnt/customcontainer.dart';
import '../widgets/progress_card.dart';
import '../providers/fitness_provider.dart';

/// DashboardScreen — App ki main screen.
/// Today ki fitness stats dikhata hai: Steps, Calories, Workout.
/// Ab ye dynamically Provider se aaj ka data nikalta hai.
class DashboardScreen extends StatelessWidget {
  final VoidCallback? onAddActivity;

  const DashboardScreen({super.key, this.onAddActivity});

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
    // Consumer widget UI ko update karta hai jab Provider me kuch change ho
    return Consumer<FitnessProvider>(
      builder: (context, provider, child) {
        // --- Asli data Provider se ---
        final int todaySteps = provider.getTodaySteps();
        final int todayCalories = provider.getTodayCalories();
        final int todayWorkout = provider.getTodayWorkoutMinutes();

        // Daily Goals — Constants for now
        const int stepGoal = 10000;
        const int calorieGoal = 800;
        const int workoutGoal = 60;

        final bool hasActivity =
            todaySteps > 0 || todayCalories > 0 || todayWorkout > 0;

    return Customcontainer(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // --- Title ---
              const Text(
                'Fitness Dashboard',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Today's Progress",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 24),

              // --- Progress Cards ya Empty State ---
              if (hasActivity) ...[
                Row(
                  children: [
                    // Steps Card
                    Expanded(
                      child: ProgressCard(
                        title: 'Steps',
                        value: _formatNumber(todaySteps),
                        goal: _formatNumber(stepGoal),
                        progress: todaySteps / stepGoal,
                        icon: Icons.directions_walk,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Calories Card
                    Expanded(
                      child: ProgressCard(
                        title: 'Calories',
                        value: _formatNumber(todayCalories),
                        goal: '$calorieGoal kcal',
                        progress: todayCalories / calorieGoal,
                        icon: Icons.local_fire_department,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Workout Card
                    Expanded(
                      child: ProgressCard(
                        title: 'Workout',
                        value: '$todayWorkout',
                        goal: '$workoutGoal min',
                        progress: todayWorkout / workoutGoal,
                        icon: Icons.timer,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ] else ...[
                // --- Empty State ---
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.fitness_center,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No activity recorded today.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Start tracking your fitness!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // --- Add Activity Button ---
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: onAddActivity,
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Add Activity',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
      },
    );
  }
}

