import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../compontnt/customcontainer.dart';
import '../widgets/activity_card.dart';
import '../providers/fitness_provider.dart';

/// HistoryScreen — Sabhi saved activities dikhata hai.
/// Ab ye data Provider ke zariye sidha Hive database se aata hai.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Customcontainer(
      child: SafeArea(
        // Consumer widget UI ko rebuild karta hai jab provider me data change ho
        child: Consumer<FitnessProvider>(
          builder: (context, provider, child) {
            final activities = provider.activities;
            final bool isEmpty = activities.isEmpty;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Title ---
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'History',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'All your activities',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),

                // --- Activity List ya Empty State ---
                if (isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No activities yet.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Start tracking your fitness journey!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: activities.length,
                      itemBuilder: (context, index) {
                        final activity = activities[index];
                        // Date format: 20 Aug 2026
                        final dateStr = DateFormat('dd MMM yyyy').format(activity.date);

                        return ActivityCard(
                          date: dateStr,
                          exerciseType: activity.exerciseType,
                          workoutMinutes: activity.workoutMinutes,
                          steps: activity.steps,
                          calories: activity.calories,
                          onEdit: () {
                            // Edit baad me implement karenge
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Edit coming soon!')),
                            );
                          },
                          onDelete: () {
                            provider.deleteActivity(activity.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Activity deleted'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
