// import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class FlatBtn extends StatelessWidget {
//   final Function onClick;
//   final Widget childW;
//
//   const FlatBtn({Key? key, required this.onClick, required this.childW})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return TextButton(onPressed: () => onClick, Widget: childW);
//   }
// }

class RaiseBtn extends StatelessWidget {
  final Function onClick;
  final Widget childW;

  const RaiseBtn({Key? key, required this.onClick, required this.childW})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(onPressed: () => onClick, child: childW);
  }
}

class LegacyRaisedButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final OutlinedBorder shape;
  final Color color;

  const LegacyRaisedButton(
      {Key? key,
      required this.onPressed,
      required this.child,
      required this.shape,
      required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(shape),
          backgroundColor: MaterialStateProperty.all(color),
          foregroundColor: MaterialStateProperty.all(color),
          shadowColor: MaterialStateProperty.all(color),
        ),
        onPressed: () {
          onPressed();
        },
        child: child);
  }
}

class LegacyFlatButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const LegacyFlatButton(
      {Key? key, required this.onPressed, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(

        onPressed: () => onPressed, child: child);
  }
}

class LegacyFlatButtonShape extends StatelessWidget {

  final VoidCallback onPressed;
  final Widget child;
  final OutlinedBorder shape;
  final Color color;

  const LegacyFlatButtonShape(
      {Key? key,
      required this.onPressed,
      required this.child,
      required this.shape,
      required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(shape),
          backgroundColor: MaterialStateProperty.all(color),
          foregroundColor: MaterialStateProperty.all(color),
          shadowColor: MaterialStateProperty.all(color),
        ),
        onPressed: () {
          onPressed();
        },
        child: child);
  }
}

// LegacyRaisedButton(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.all(Radius.circular(30)),
// ),
// color: C.authButtonColor,
// onPressed: () => _signup(context),
// child: Container(
// height: 60,
// width: 120,
// alignment: Alignment.center,
// child: Text(
// "Sign Up!",
// style: TextStyle(
// color: C.primaryUnHighlightedColor,
// fontSize: 20 * heightFactor,
// ),
// ),
// ),
// )
