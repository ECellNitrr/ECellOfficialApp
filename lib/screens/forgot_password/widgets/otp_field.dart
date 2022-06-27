import 'package:flutter/material.dart';

class OTPField extends StatelessWidget {
  const OTPField(this.controller);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      validator: _validateOTP,
      decoration: InputDecoration(
        suffixText: '*',
        suffixStyle: TextStyle(color: Colors.red, fontSize: 20),
        prefixIcon: Icon(Icons.error),
        border: OutlineInputBorder(),
        labelText: "OTP",
      ),
    );
  }

  String _validateOTP(String otp) {
    if (otp.length != 4) {
      return "Please enter 4 digit OTP";
    } else {
      return null;
    }
  }
}
