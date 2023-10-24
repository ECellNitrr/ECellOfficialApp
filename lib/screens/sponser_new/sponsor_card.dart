import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecellapp/models/sponsor.dart';
import 'package:flutter/material.dart';

import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SponsorCard extends StatefulWidget {
  final Sponsor? sponsor;

  const SponsorCard({Key? key, this.sponsor}) : super(key: key);

  @override
  State<SponsorCard> createState() => _SponsorCardState();
}

class _SponsorCardState extends State<SponsorCard> {
  bool isBack = true;
  double angle = 0;

  void _flip() {
    setState(() {
      print("pressed");
      angle = (angle + pi) % (2 * pi);
    });
  }

  @override
  Widget build(BuildContext context) {
    double ratio = MediaQuery.of(context).size.aspectRatio;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: _flip,
          child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: angle),
              duration: Duration(seconds: 1),
              builder: (BuildContext context, double val, __) {
                if (val >= (pi / 2)) {
                  isBack = false;
                } else {
                  isBack = true;
                }
                return (Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(val),
                  child: Container(
                    height: height * 0.25,
                    width: width*0.5,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow:[
                          BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: isBack? Offset(20, 20): Offset(-20, 20),
                                blurRadius: 3,
                                spreadRadius: -10)
                        ]
                      ),
                      
                      child: isBack
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                
                                child: Image.network(widget.sponsor!.picUrl!,fit: BoxFit.contain,),
                              ),
                          )
                          : Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..rotateY(
                                    pi),
                              child: Container(
                                height: height * 0.2,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black87,
                                  
                                  
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(widget.sponsor!.name!,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.raleway(
                                          color: Colors.white,
                                          fontSize: 22*height/1000,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    if (widget.sponsor!.details != null)
                                      Text(
                                      widget.sponsor!.details!,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.raleway(
                                        color: Colors.white,
                                        fontSize: 18*height/1000,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    if(widget.sponsor!.website!=null)InkWell(
                                      onTap: () async {
                                          if (await canLaunchUrlString(
                                              widget.sponsor!.website!)) {
                                            await launchUrlString(
                                                widget.sponsor!.website!);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(S
                                                        .redirectIntentError)));
                                          }
                                        },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1,color: Colors.white),
                                        ),
                                        child: Text("Website",
                                            style: GoogleFonts.raleway(
                                              color: Colors.white,
                                              fontSize: 18* height / 1000,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                      ),
                ));
              }),
        )
      ],
    );
  }
}
