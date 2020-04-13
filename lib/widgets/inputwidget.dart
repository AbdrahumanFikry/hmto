import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String labelText;
  final FormFieldSetter<String> onSaved;

  InputWidget({
    this.onSaved,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null) {
            return 'this field is requred!';
          }
          return null;
        },
        onSaved: onSaved,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}
