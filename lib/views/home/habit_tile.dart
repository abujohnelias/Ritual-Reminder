import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? editTapped;
  final Function(BuildContext)? deleteTapped;
  HabitTile(
      {super.key,
      required this.habitName,
      required this.habitCompleted,
      required this.onChanged,
      required this.editTapped,
      required this.deleteTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.width * 0.02),
      child: Slidable(
        endActionPane: ActionPane(motion: const BehindMotion(), children: [
          //edit
          SlidableAction(
            backgroundColor: Colors.grey.shade400,
            icon: Icons.edit,
            onPressed: editTapped,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12), topLeft: Radius.circular(12)),
          ),
          //delete
          SlidableAction(
            backgroundColor: Colors.grey.shade400,
            icon: Icons.delete,
            onPressed: deleteTapped,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(12),
                topRight: Radius.circular(12)),
          )
        ]),
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ], color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  //checkbox
                  Checkbox(
                    value: habitCompleted,
                    onChanged: onChanged,
                  ),

                  //name
                  Text(habitName),
                ],
              ),

              const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.grey,)
            ],
          ),
        ),
      ),
    );
  }
}
