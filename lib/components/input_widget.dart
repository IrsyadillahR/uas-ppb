import 'package:flutter/material.dart';
import 'package:uas_ppb/components/style.dart';

class InputWidget extends StatelessWidget {
  String label;
  StatefulWidget inputField;

  InputWidget(
    this.label,
    this.inputField, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: headerStyle(level: 3)),
        const SizedBox(height: 5),
        Container(
          child: inputField,
        ),
        const SizedBox(height: 15)
      ],
    );
  }
}

InputDecoration customInputDecoration(String hintText, {Widget? suffixIcon}) {
  return InputDecoration(
      hintText: hintText,
      suffixIcon: suffixIcon,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));
}
