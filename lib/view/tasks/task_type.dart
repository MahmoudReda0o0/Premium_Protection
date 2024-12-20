import 'package:excp_training/constant/constant.dart';
import 'package:flutter/material.dart';

class TaskType extends StatefulWidget {
  const TaskType({super.key});

  @override
  State<TaskType> createState() => _TaskTypeState();
}

class _TaskTypeState extends State<TaskType> {
  List<String> typeList = [
    'Exercise',
    'Meditate',
    'Journal',
    'Take vitamins',
    'Submit reports',
    "Respond to emails",
  ];

// Personal Tasks
  List<String> personalTasks = [
    "Exercise",
    "Meditate",
    "Journal",
    "Drink 2L water",
    "Take vitamins",
    "Grocery shopping",
    "Meal preparation",
    "Laundry",
    "Organize room/desk",
    "Exercise",
    "Meditate",
    "Journal",
    "Drink 2L water",
    "Take vitamins",
    "Grocery shopping",
    "Meal preparation",
    "Laundry",
    "Organize room/desk",
    "Exercise",
    "Meditate",
    "Journal",
    "Drink 2L water",
    "Take vitamins",
    "Grocery shopping",
    "Meal preparation",
    "Laundry",
    "Organize room/desk",
  ];

// Work-Related Tasks
  List<String> workTasks = [
    "Complete project milestones",
    "Respond to emails",
    "Attend meetings",
    "Review documents",
    "Submit reports",
    "Brainstorm ideas",
  ];

// Educational Tasks
  List<String> educationalTasks = [
    "Review Chapter 5",
    "Practice Math Problems",
    "Complete assignments",
    "Watch educational videos",
    "Read a book/article",
    "Prepare for exams",
  ];

// Social/Relationship Tasks
  List<String> socialTasks = [
    "Call a family member or friend",
    "Attend a social event",
    "Write a thank-you note",
    "Plan a date or outing",
    "Send birthday wishes",
  ];

// Hobby/Leisure Tasks
  List<String> hobbyTasks = [
    "Practice a musical instrument",
    "Work on a personal project",
    "Watch a movie/TV show",
    "Play a video game",
    "Read a novel",
  ];

// Household Tasks
  List<String> householdTasks = [
    "Vacuum living room",
    "Clean bathroom",
    "Pay bills",
    "Repair something",
    "Water plants",
    "Take out the trash",
  ];

// Fitness Tasks
  List<String> fitnessTasks = [
    "Go for a run/walk",
    "Attend a fitness class",
    "Stretch or yoga",
    "Track steps or calories",
    "Weightlifting routine",
  ];

// Self-Care Tasks
  List<String> selfCareTasks = [
    "Schedule doctor appointments",
    "Spa or relaxation time",
    "Journaling or gratitude practice",
    "Listen to a podcast",
    "Spend time outdoors",
  ];

// Errands
  List<String> errands = [
    "Pick up dry cleaning",
    "Visit the bank",
    "Buy a gift",
    "Car maintenance",
    "Drop off packages",
  ];

// Goal-Oriented Tasks
  List<String> goalTasks = [
    "Set weekly/monthly goals",
    "Track progress on a project",
    "Plan a trip",
    "Learn a new skill",
    "Save money",
  ];

// Digital Tasks
  List<String> digitalTasks = [
    "Organize files/photos",
    "Backup data",
    "Update apps/software",
    "Clear email inbox",
    "Manage subscriptions",
  ];

// Recurring Tasks
  List<String> recurringTasks = [
    "Daily habits: Drink water",
    "Daily habits: Take a walk",
    "Weekly reviews",
    "Monthly expenses check",
    "Quarterly house maintenance",
    "Annual medical check-up",
  ];

// Miscellaneous Tasks
  List<String> miscellaneousTasks = [
    "Donate unused items",
    "Volunteer work",
    "Random acts of kindness",
    "Explore a new place",
    "Reflect on achievements",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Type'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => SizedBox(
                    height: mediaHeight * 0.3,
                    child: Column(
                      children: [
                        
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('take'))
                      ],
                    ),
                  ));
        },
        backgroundColor: Constant.primaryColor,
        child: const Icon(Icons.add),
      ),
      body: Container(
          height: mediaHeight * 0.9,
          width: mediaWidth * 0.9,
          color: Constant.blueGradientLight,
          child: Column(
            children: [
              const Text('Regular Type'),
              Expanded(
                child: Container(
                  color: Constant.darkGrayColor,
                  child: ListView.builder(
                    itemCount: personalTasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          personalTasks[index],
                          style: const TextStyle(color: Constant.blackColor),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Text('Personal Type'),
              Expanded(
                child: Container(
                  color: Constant.dimGrayColor,
                  child: ListView.builder(
                    itemCount: digitalTasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          typeList[index],
                          style: const TextStyle(color: Constant.blackColor),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
