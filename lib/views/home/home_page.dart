import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ritual_reminder/components/month_summery.dart';
import 'package:ritual_reminder/components/my_fabutton.dart';
import 'package:ritual_reminder/components/my_alert_box.dart';
import 'package:ritual_reminder/data/habbit_database.dart';
import 'package:ritual_reminder/views/home/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");
  @override
  void initState() {
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }
    db.updateDatabase();
    super.initState();
  }

  //checkbox tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value!;
    });
    db.updateDatabase();
  }

  //create new
  final _newHabbitNameController = TextEditingController();

  void createNewHabbit() {
    //dialouge box
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabbitNameController,
          onSave: saveNewHabit,
          onCancel: cancelDialougeBox,
          hintText: 'Enter Habit Name...',
        );
      },
    );
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(
        onPressed: () => createNewHabbit(),
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: ListView(
        children: [
          //heatmap
          MonthlySummary(
              datasets: db.heatMapDataSet,
              startDate: _myBox.get(
                "START_DATE",
              )),

          //listview builder
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.todaysHabitList.length,
            itemBuilder: (context, index) {
              return HabitTile(
                habitName: db.todaysHabitList[index][0],
                habitCompleted: db.todaysHabitList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                editTapped: (context) => openHabbitSetings(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          )
        ],
      )),
    );
  }

  void saveNewHabit() {
    String newHabitName = _newHabbitNameController.text.trim();

    if (newHabitName.isNotEmpty) {
      setState(() {
        db.todaysHabitList.add([newHabitName, false]);
      });

      _newHabbitNameController.clear();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey.shade600,
          content: const Text('Habit name cannot be empty!'),
        ),
      );
    }
    db.updateDatabase();
  }

  void cancelDialougeBox() {
    _newHabbitNameController.clear();
    Navigator.of(context).pop();
  }

  void openHabbitSetings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabbitNameController,
          onSave: () => saveExisting(index),
          onCancel: cancelDialougeBox,
          hintText: db.todaysHabitList[index][0],
        );
      },
    );
  }

  void saveExisting(int index) {
    // setState(() {
    //   db.todaysHabitList[index][0] = _newHabbitNameController.text;
    // });
    // _newHabbitNameController.clear();
    // Navigator.of(context).pop();
    // db.updateDatabase();

    if (_newHabbitNameController.text.isNotEmpty) {
      setState(() {
      db.todaysHabitList[index][0] = _newHabbitNameController.text;
    });

      _newHabbitNameController.clear();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey.shade600,
          content: const Text('Habit name cannot be empty!'),
        ),
      );
    }
  }

  // void deleteHabbit(int index) {
  //   setState(() {
  //     db.todaysHabbitList.removeAt(index);
  //   });
  // }
  void deleteHabit(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Are you sure you want to delete this habit?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: Colors.green.shade200,
                          width: .7,
                        ),
                      ),
                      child: Icon(Icons.close, color: Colors.green[200])),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      db.todaysHabitList.removeAt(index);
                      db.updateDatabase();
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "delete",
                    style: TextStyle(color: Colors.red[700]),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
    db.updateDatabase();
  }
}
