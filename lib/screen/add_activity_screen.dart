import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../compontnt/customcontainer.dart';
import '../providers/fitness_provider.dart';

/// AddActivityScreen — User yahan fitness activity manually add karega.
/// Form fields: Exercise Type, Duration, Steps, Calories, Date.
class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  // --- Exercise type options ---
  final _exerciseTypes = [
    'Running',
    'Walking',
    'Cycling',
    'Swimming',
    'Yoga',
    'Gym',
    'Other',
  ];

  // --- Form state ---
  String? _selectedExercise;
  final _durationController = TextEditingController();
  final _stepsController = TextEditingController();
  final _caloriesController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _durationController.dispose();
    _stepsController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  /// Real save — Provider ke through Hive mein save karta hai
  void _saveActivity() async {
    // Basic validation
    if (_selectedExercise == null ||
        _durationController.text.isEmpty ||
        _stepsController.text.isEmpty ||
        _caloriesController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // String to int convert karna
    final duration = int.tryParse(_durationController.text) ?? 0;
    final steps = int.tryParse(_stepsController.text) ?? 0;
    final calories = int.tryParse(_caloriesController.text) ?? 0;

    // Provider get karna (listen: false kyunki ye sirf action trigger kar raha hai)
    final provider = Provider.of<FitnessProvider>(context, listen: false);

    // Save call
    await provider.addActivity(
      date: _selectedDate,
      exerciseType: _selectedExercise!,
      workoutMinutes: duration,
      steps: steps,
      calories: calories,
    );

    // Success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Activity saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }

    // Form clear karo
    setState(() {
      _selectedExercise = null;
      _durationController.clear();
      _stepsController.clear();
      _caloriesController.clear();
      _selectedDate = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                'Add Activity',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Record your workout',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 24),

              // --- Form Card ---
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Exercise Type — Dropdown
                      DropdownButtonFormField<String>(
                        initialValue: _selectedExercise,
                        decoration: InputDecoration(
                          labelText: 'Exercise Type',
                          prefixIcon: const Icon(Icons.fitness_center),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        items: _exerciseTypes.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedExercise = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Duration
                      TextField(
                        controller: _durationController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Duration (minutes)',
                          prefixIcon: const Icon(Icons.timer_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Steps
                      TextField(
                        controller: _stepsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Steps',
                          prefixIcon: const Icon(Icons.directions_walk),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Calories
                      TextField(
                        controller: _caloriesController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Calories Burned',
                          prefixIcon:
                              const Icon(Icons.local_fire_department_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Date Picker — InkWell + InputDecorator combo
                      // Ye ek "read-only field" jaisa dikhta hai jo tap pe date picker kholega
                      InkWell(
                        onTap: _pickDate,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Date',
                            prefixIcon: const Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            '${_selectedDate.day.toString().padLeft(2, '0')}/'
                            '${_selectedDate.month.toString().padLeft(2, '0')}/'
                            '${_selectedDate.year}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // --- Save Button ---
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveActivity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    'Save Activity',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
