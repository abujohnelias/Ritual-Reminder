import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hintText;
  const MyAlertBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black54),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38),
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(8), right: Radius.circular(8))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38),
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(8), right: Radius.circular(8))),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(
              onPressed: onCancel,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: Colors.red.shade200,
                      width: .7,
                    ),
                  ),
                  child: Icon(Icons.close, color: Colors.red[200])),
            ),
            MaterialButton(
              onPressed: onSave,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.green[700]),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
