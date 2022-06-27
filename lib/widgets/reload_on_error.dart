import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/strings.dart';

class ReloadOnErrorWidget extends StatelessWidget {
  final Function onReload;

  const ReloadOnErrorWidget(this.onReload);

  @override
  Widget build(BuildContext context) {
    double heightFactor = MediaQuery.of(context).size.height / 1000;
    double ratio = MediaQuery.of(context).size.aspectRatio;
    return DefaultTextStyle.merge(
      style: GoogleFonts.roboto().copyWith(
          color: C.primaryUnHighlightedColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5),
      child: Column(
        children: [
          SizedBox(
            height: ratio > 0.5 ? 100 : 120,
          ),
          Expanded(
              flex: 2,
              child: Image.asset(
                S.asset404Image,
                width: ratio > 0.5 ? 225 : 245,
              )),
          Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Text("Oops!"),
                    Text("Looks Like This Page Was"),
                    Text("Lost In Space"),
                    SizedBox(
                      height: ratio > 0.5 ? 40 : 60,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: C.authButtonColor.withOpacity(0.16),
                            blurRadius: 20,
                            offset: Offset(0, 5),
                          )
                        ],
                      ),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        color: C.authButtonColor,
                        onPressed: onReload,
                        child: Container(
                          height: ratio > 0.5 ? 40 : 60,
                          width: ratio > 0.5 ? 80 : 100,
                          alignment: Alignment.center,
                          child: Text(
                            "Retry",
                            style: TextStyle(
                                color: C.primaryUnHighlightedColor, fontSize: 20 * heightFactor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
