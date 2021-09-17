import 'package:flutter/material.dart';

class FormFieldItem extends StatelessWidget {
  const FormFieldItem({
    Key? key,
    required this.keyboardType,
    required this.hintName,
    required this.validator,
    required this.onSave,
  }) : super(key: key);
  final TextInputType keyboardType;
  final String? hintName;
  final String? Function(String?) validator;
  final void Function(String?) onSave;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(hintText: hintName),
      validator: validator,
      onSaved: onSave,
    );
  }
}
