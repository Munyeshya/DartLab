import 'package:flutter/material.dart';
import 'models/workout.dart';

void main() => runApp(WorkoutTrackerApp());

class WorkoutTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WorkoutListPage(),
    );
  }
}

class WorkoutListPage extends StatefulWidget {
  @override
  _WorkoutListPageState createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  final List<Workout> _workouts = [];

  void _addWorkout(String title) {
    setState(() {
      _workouts.add(Workout(title: title, exercises: []));
    });
  }

  void _editWorkout(int index, String title) {
    setState(() {
      _workouts[index].title = title;
    });
  }

  void _deleteWorkout(int index) {
    setState(() {
      _workouts.removeAt(index);
    });
  }

  void _showWorkoutDialog({Workout? workout, int? index}) {
    final titleController = TextEditingController();

    if (workout != null) {
      titleController.text = workout.title;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(workout == null ? 'Add Workout' : 'Edit Workout'),
        content: TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: 'Title'),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(workout == null ? 'Add' : 'Edit'),
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                if (workout == null) {
                  _addWorkout(titleController.text);
                } else {
                  _editWorkout(index!, titleController.text);
                }
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Tracker'),
      ),
      body: ListView.builder(
        itemCount: _workouts.length,
        itemBuilder: (context, index) {
          final workout = _workouts[index];
          return ListTile(
            title: Text(workout.title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () =>
                      _showWorkoutDialog(workout: workout, index: index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteWorkout(index),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkoutDetailPage(
                      workout: workout,
                      onUpdate: (updatedWorkout) {
                        setState(() {
                          _workouts[index] = updatedWorkout;
                        });
                      }),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showWorkoutDialog(),
      ),
    );
  }
}

class WorkoutDetailPage extends StatefulWidget {
  final Workout workout;
  final ValueChanged<Workout> onUpdate;

  WorkoutDetailPage({required this.workout, required this.onUpdate});

  @override
  _WorkoutDetailPageState createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  void _addExercise(String name, int sets, int reps, double weight) {
    setState(() {
      widget.workout.exercises
          .add(Exercise(name: name, sets: sets, reps: reps, weight: weight));
    });
    widget.onUpdate(widget.workout);
  }

  void _editExercise(
      int index, String name, int sets, int reps, double weight) {
    setState(() {
      widget.workout.exercises[index] =
          Exercise(name: name, sets: sets, reps: reps, weight: weight);
    });
    widget.onUpdate(widget.workout);
  }

  void _deleteExercise(int index) {
    setState(() {
      widget.workout.exercises.removeAt(index);
    });
    widget.onUpdate(widget.workout);
  }

  void _showExerciseDialog({Exercise? exercise, int? index}) {
    final nameController = TextEditingController();
    final setsController = TextEditingController();
    final repsController = TextEditingController();
    final weightController = TextEditingController();

    if (exercise != null) {
      nameController.text = exercise.name;
      setsController.text = exercise.sets.toString();
      repsController.text = exercise.reps.toString();
      weightController.text = exercise.weight.toString();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(exercise == null ? 'Add Exercise' : 'Edit Exercise'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: setsController,
              decoration: InputDecoration(labelText: 'Sets'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: repsController,
              decoration: InputDecoration(labelText: 'Reps'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(exercise == null ? 'Add' : 'Edit'),
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  setsController.text.isNotEmpty &&
                  repsController.text.isNotEmpty &&
                  weightController.text.isNotEmpty) {
                if (exercise == null) {
                  _addExercise(
                    nameController.text,
                    int.parse(setsController.text),
                    int.parse(repsController.text),
                    double.parse(weightController.text),
                  );
                } else {
                  _editExercise(
                    index!,
                    nameController.text,
                    int.parse(setsController.text),
                    int.parse(repsController.text),
                    double.parse(weightController.text),
                  );
                }
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.title),
      ),
      body: ListView.builder(
        itemCount: widget.workout.exercises.length,
        itemBuilder: (context, index) {
          final exercise = widget.workout.exercises[index];
          return ListTile(
            title: Text(
                '${exercise.name} - ${exercise.sets} sets of ${exercise.reps} reps @ ${exercise.weight}kg'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () =>
                      _showExerciseDialog(exercise: exercise, index: index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteExercise(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showExerciseDialog(),
      ),
    );
  }
}
