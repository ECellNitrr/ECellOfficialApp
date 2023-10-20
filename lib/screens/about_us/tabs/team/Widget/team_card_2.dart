import 'package:flutter/material.dart';

import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../models/team.dart';

class TeamsCard2 extends StatefulWidget {
  final TeamMember? teamMember;

  const TeamsCard2({Key? key, this.teamMember}) : super(key: key);

  @override
  State<TeamsCard2> createState() => _TeamsCard2State();
}

class _TeamsCard2State extends State<TeamsCard2> {
  late bool _displayFront;

  late bool _flipXAxis;

  @override
  void initState() {
    super.initState();
    _displayFront = true;
    _flipXAxis = true;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => setState(() {
        _displayFront = !_displayFront;
      }),
      // width: width * 0.4,
      // height: height * 0.25,
      child: Container(
        width: double.infinity,
        height: height * 0.07,
        decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.darken,
            color: Colors.black38,
            borderRadius: BorderRadius.circular(20)),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 600),
          child: _displayFront
              ? _buildFront(widget.teamMember!)
              : _buildRear(widget.teamMember!, context),
        ),
      ),
    );
  }
}

Widget _buildFront(TeamMember teamMember) {
  return Text(teamMember.name!,
      textAlign: TextAlign.center,
      style: GoogleFonts.raleway(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white));
}

Widget _buildRear(TeamMember teamMember, BuildContext context) {
  return Container(
    child: GestureDetector(
      onTap: () async {
        //Handle sponsor.spons[0].socialMedia
        print('Presssed');
        if (await canLaunchUrlString(teamMember.linkedin!)) {
          await launchUrlString(teamMember.linkedin!);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(S.redirectIntentError)));
        }
      },
      child: Image.asset(
        S.assetIconLinkdin,
        height: 50,
        color: Colors.white,
      ),
    ),
  );
}
