enum WorkmanagerState {
  oneOff("task-identifier", "task-identifier"),
  periodic("com.bobipermanasandi.foodea", "com.bobipermanasandi.foodea");

  final String uniqueName;
  final String taskName;

  const WorkmanagerState(this.uniqueName, this.taskName);
}
