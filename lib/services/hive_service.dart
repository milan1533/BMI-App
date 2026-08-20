import 'package:hive_flutter/hive_flutter.dart';
import '../models/fitness_activity.dart';

/// HiveService — Database operations handle karne ke liye
/// Isme hum Activities create, read, update, aur delete (CRUD) karenge.
class HiveService {
  static const String boxName = 'fitness_box';

  /// Hive Box (Database Table)
  Box<FitnessActivity> get _box => Hive.box<FitnessActivity>(boxName);

  /// Sabhi saved activities nikalna (Read)
  List<FitnessActivity> getActivities() {
    // Activities ko ulta sort karke list banayenge (latest sabse pehle)
    return _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  /// Nayi activity save karna (Create)
  Future<void> saveActivity(FitnessActivity activity) async {
    await _box.put(activity.id, activity);
  }

  /// Puraani activity ko update karna (Update)
  Future<void> updateActivity(FitnessActivity activity) async {
    await activity.save(); // Kyunki ye HiveObject hai, direct .save() chalega
  }

  /// Activity ko delete karna (Delete)
  Future<void> deleteActivity(String id) async {
    await _box.delete(id);
  }

  /// Specific date ka data count karna (For Dashboard)
  List<FitnessActivity> getActivitiesForDate(DateTime date) {
    return _box.values.where((activity) {
      return activity.date.year == date.year &&
          activity.date.month == date.month &&
          activity.date.day == date.day;
    }).toList();
  }
}
