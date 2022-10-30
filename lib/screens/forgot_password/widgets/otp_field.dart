import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../core/res/colors.dart';

class OTPField extends StatelessWidget {
   OTPField(this.controller);

   late TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    double heightFactor = height / 1000;
    return Stack(
      alignment: Alignment.center,
      children: [
        OtpDecoration(),
        Pinput(
          defaultPinTheme: PinTheme(
            width: 56,
            height: 56,
            textStyle: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          pinputAutovalidateMode: PinputAutovalidateMode.disabled,
          showCursor: false,
          onCompleted: (pin) => _validateOTP(pin),
        ),
      ],
    );
  }

  String? _validateOTP(String? otp) {
    if (otp!.length != 4) {
      return "Please enter 4 digit OTP";
    } else {
      controller.text=otp;
      return null; ;
    }
  }
}

Widget OtpDecoration()
{
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Field(C.ring1),
      Field(C.ring2),
      Field(C.ring3),
      Field(C.ring4),
    ],
  );
}

Container Field(Color color, ) {
  return Container(
      margin: EdgeInsets.all(4.4),
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: color,
        style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(28),
      ),
    );
}