import 'package:hive/hive.dart';

part 'fitness_activity.g.dart'; // Ye file flutter build_runner generate karega

/// Fitness Activity Model
/// Isme har exercise ka data store hoga
@HiveType(typeId: 0) // typeId unique hona chahiye database ke andar
class FitnessActivity extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String exerciseType;

  @HiveField(3)
  final int workoutMinutes;

  @HiveField(4)
  final int steps;

  @HiveField(5)
  final int calories;

  FitnessActivity({
    required this.id,
    required this.date,
    required this.exerciseType,
    required this.workoutMinutes,
    required this.steps,
    required this.calories,
  });
}
