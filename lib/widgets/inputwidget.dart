import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String labelText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  InputWidget({
    this.onSaved,
    this.labelText,
    @required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: TextFormField(
        validator: validator,
        onSaved: onSaved,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}
