import 'package:flutter/material.dart';

import '../../../core/res/colors.dart';
import '../../../core/res/dimens.dart';

class NameField extends StatelessWidget {
  const NameField(this.controller, this.label);
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightFactor = height >= 1000 ? 1 : height / 1000;
    return TextFormField(
      controller: controller,
      validator: _validator,
      keyboardType: TextInputType.name,
      style: TextStyle(
        color: C.primaryUnHighlightedColor,
        fontSize: D.inputFieldFontSize * heightFactor,
      ),
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 0.1),
        prefixIcon: Icon(
          Icons.account_circle_outlined,
          size: D.iconSize,
          color: C.primaryHighlightedColor,
        ),
        labelText: label,
      ),
    );
  }

  String _validator(String name) => name.isEmpty ? "" : null;
}
