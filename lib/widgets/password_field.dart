import 'package:flutter/material.dart';

import '../core/res/colors.dart';
import '../core/res/dimens.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(this.controller);
  final TextEditingController controller;
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightFactor = height >= 1000 ? 1 : height / 1000;
    return TextFormField(
      controller: widget.controller,
      validator: _validator,
      style: TextStyle(
        color: C.primaryUnHighlightedColor,
        fontSize: D.inputFieldFontSize * heightFactor,
      ),
      textInputAction: TextInputAction.next,
      onEditingComplete: () => FocusScope.of(context)..nextFocus()..nextFocus(),
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 0.1),
        prefixIcon: Icon(
          Icons.lock_outline,
          size: D.iconSize * heightFactor,
          color: C.primaryHighlightedColor,
        ),
        suffixIcon: IconButton(
          icon: IconTheme(
            child: _passwordVisible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
            data: IconThemeData(color: C.primaryHighlightedColor, size: D.iconSize * heightFactor),
          ),
          onPressed: _togglePasswordVisibility,
        ),
        labelText: "Password",
      ),
    );
  }

  String _validator(String password) => password.isEmpty ? "" : null;

  void _togglePasswordVisibility() => setState(() => _passwordVisible = !_passwordVisible);
}
