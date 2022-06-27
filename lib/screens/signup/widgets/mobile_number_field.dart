import 'package:flutter/material.dart';

import '../../../core/res/colors.dart';
import '../../../core/res/dimens.dart';

class MobileNumberField extends StatelessWidget {
  const MobileNumberField(this.controller);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightFactor = height >= 1000 ? 1 : height / 1000;
    return TextFormField(
      controller: controller,
      validator: _validator,
      keyboardType: TextInputType.number,
      style: TextStyle(
        color: C.primaryUnHighlightedColor,
        fontSize: D.inputFieldFontSize * heightFactor,
      ),
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 0.1),
        prefixIcon: Icon(Icons.phone_outlined, size: D.iconSize, color: C.primaryHighlightedColor),
        labelText: "Mobile Number",
      ),
    );
  }

  String _validator(String number) => number.isEmpty ? "" : null;
}
