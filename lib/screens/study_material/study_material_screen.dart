import 'package:flutter/material.dart';

class StudyMaterialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Study Material")),
      body: Center(
        child: Text("Study material links for the selected exam."),
      ),
    );
  }
}
