import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/fitness_activity.dart';
import '../services/hive_service.dart';

class FitnessProvider extends ChangeNotifier {
  final HiveService _hiveService = HiveService();
  List<FitnessActivity> _activities = [];

  List<FitnessActivity> get activities => _activities;

  FitnessProvider() {
    loadActivities();
  }

  /// Database se data read karke list update karta hai
  void loadActivities() {
    _activities = _hiveService.getActivities();
    notifyListeners(); // UI ko update karne ke liye bolta hai
  }

  /// Nayi activity save karna
  Future<void> addActivity({
    required DateTime date,
    required String exerciseType,
    required int workoutMinutes,
    required int steps,
    required int calories,
  }) async {
    final newActivity = FitnessActivity(
      id: const Uuid().v4(), // Unique ID generate karta hai
      date: date,
      exerciseType: exerciseType,
      workoutMinutes: workoutMinutes,
      steps: steps,
      calories: calories,
    );

    await _hiveService.saveActivity(newActivity);
    loadActivities(); // Save hone ke baad list refresh
  }

  /// Activity ko update karna
  Future<void> updateActivity(FitnessActivity activity) async {
    await _hiveService.updateActivity(activity);
    loadActivities();
  }

  /// Activity ko delete karna
  Future<void> deleteActivity(String id) async {
    await _hiveService.deleteActivity(id);
    loadActivities();
  }

  // --- Dashboard Data Calculate Karne Ke Methods ---

  int getTodaySteps() {
    final today = DateTime.now();
    final todayActivities = _hiveService.getActivitiesForDate(today);
    int total = 0;
    for (var act in todayActivities) {
      total += act.steps;
    }
    return total;
  }

  int getTodayCalories() {
    final today = DateTime.now();
    final todayActivities = _hiveService.getActivitiesForDate(today);
    int total = 0;
    for (var act in todayActivities) {
      total += act.calories;
    }
    return total;
  }

  int getTodayWorkoutMinutes() {
    final today = DateTime.now();
    final todayActivities = _hiveService.getActivitiesForDate(today);
    int total = 0;
    for (var act in todayActivities) {
      total += act.workoutMinutes;
    }
    return total;
  }
}
