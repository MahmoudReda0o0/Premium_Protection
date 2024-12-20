class TaskInfo {
  String taskName;
  String taskType;
  String taskDescription;
  String dateTime;
  bool isNew;
  TaskInfo(
      {required this.taskName, required this.isNew, required this.dateTime,required this.taskType,required this.taskDescription});
}
class LocalTask{
  static List<TaskInfo> list = [
    TaskInfo(taskName: 'Complete Flutter tutorial', isNew: false, dateTime: '2025-01-15 / 10:30 AM', taskType: 'personal', taskDescription: 'Watch and practice the Flutter tutorial videos.'),
    TaskInfo(taskName: 'Grocery shopping', isNew: true, dateTime: '2024-11-20 / 6:00 PM', taskType: 'personal', taskDescription: 'Buy vegetables, fruits, and bread.'),
    TaskInfo(taskName: 'Dentist appointment', isNew: false, dateTime: '2025-02-14 / 4:45 PM', taskType: 'health', taskDescription: 'Visit Dr. Smith for a regular check-up.'),
    TaskInfo(taskName: 'Submit tax documents', isNew: false, dateTime: '2025-01-05 / 2:00 PM', taskType: 'work', taskDescription: 'Prepare and send all required tax forms.'),
    TaskInfo(taskName: 'Birthday party', isNew: true, dateTime: '2024-12-05 / 1:03 PM', taskType: 'social', taskDescription: 'Attend Jake’s birthday celebration.'),
    TaskInfo(taskName: 'Yoga session', isNew: false, dateTime: '2024-12-18 / 7:30 AM', taskType: 'health', taskDescription: 'Join the evening yoga session at the gym.'),
    TaskInfo(taskName: 'Fix laptop issues', isNew: true, dateTime: '2024-10-01 / 11:15 AM', taskType: 'personal', taskDescription: 'Visit the repair shop to resolve performance problems.'),
    TaskInfo(taskName: 'Team meeting', isNew: false, dateTime: '2025-03-02 / 9:00 AM', taskType: 'work', taskDescription: 'Discuss the quarterly project goals.'),
    TaskInfo(taskName: 'Plan holiday trip', isNew: true, dateTime: '2024-12-10 / 8:20 PM', taskType: 'leisure', taskDescription: 'Research destinations for the summer vacation.'),
    TaskInfo(taskName: 'Car service', isNew: false, dateTime: '2025-02-28 / 3:00 PM', taskType: 'personal', taskDescription: 'Take the car for its annual servicing.'),
    TaskInfo(taskName: 'Weekly book club', isNew: true, dateTime: '2024-11-22 / 5:30 PM', taskType: 'social', taskDescription: 'Discuss the latest book in the reading group.'),
    TaskInfo(taskName: 'Prepare presentation', isNew: false, dateTime: '2025-01-10 / 1:45 PM', taskType: 'work', taskDescription: 'Create slides for the upcoming product launch.'),
    TaskInfo(taskName: 'Gardening', isNew: true, dateTime: '2024-10-15 / 6:00 AM', taskType: 'hobby', taskDescription: 'Plant new flowers and trim hedges.'),
    TaskInfo(taskName: 'Online course enrollment', isNew: false, dateTime: '2024-12-25 / 10:00 AM', taskType: 'personal', taskDescription: 'Sign up for the Python programming course.'),
    TaskInfo(taskName: 'Visit grandparents', isNew: true, dateTime: '2024-09-15 / 3:15 PM', taskType: 'family', taskDescription: 'Spend the weekend with grandparents.'),
    TaskInfo(taskName: 'Learn to cook', isNew: false, dateTime: '2025-01-20 / 6:45 PM', taskType: 'hobby', taskDescription: 'Experiment with new recipes and techniques.'),
    TaskInfo(taskName: 'Renew passport', isNew: true, dateTime: '2024-08-12 / 2:30 PM', taskType: 'personal', taskDescription: 'Complete the renewal process for the upcoming trip.'),
    TaskInfo(taskName: 'Organize closet', isNew: false, dateTime: '2025-03-12 / 11:00 AM', taskType: 'personal', taskDescription: 'Sort clothes and donate unused items.'),
    TaskInfo(taskName: 'Write a blog post', isNew: true, dateTime: '2024-12-01 / 7:00 PM', taskType: 'hobby', taskDescription: 'Create a post about favorite books of the year.'),
    TaskInfo(taskName: 'Volunteer at shelter', isNew: false, dateTime: '2025-02-05 / 4:30 PM', taskType: 'social', taskDescription: 'Help at the animal shelter for the afternoon.'),
  ];

  static addNewTask({
 required String taskName,
 required String taskType,
 required String taskDescription,
 required String dateTime,
 
  }){
list.add(TaskInfo(taskName: taskName, isNew: true, dateTime: dateTime, taskType: taskType, taskDescription: taskDescription));
  }

}
