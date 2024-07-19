class Exercise {
  String name;
  int sets;
  int reps;
  double weight;

  Exercise(
      {required this.name,
      required this.sets,
      required this.reps,
      required this.weight});
}

class Workout {
  String title;
  List<Exercise> exercises;

  Workout({required this.title, required this.exercises});
}
