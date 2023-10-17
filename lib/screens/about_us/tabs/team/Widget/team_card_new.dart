import 'package:flutter/material.dart';

import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../models/team.dart';

class TeamsCardNew extends StatefulWidget {
  final TeamMember? teamMember;

  const TeamsCardNew({Key? key, this.teamMember}) : super(key: key);

  @override
  State<TeamsCardNew> createState() => _TeamsCardNewState();
}

class _TeamsCardNewState extends State<TeamsCardNew> {
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
        BoxShadow(
          color: Colors.black38,
          blurRadius: 10,
        )
      ]),
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Ink.image(
              image: (widget.teamMember!.image == null)
                  ? AssetImage(
                      S.assetUnknownIcon,
                    )
                  : NetworkImage(widget.teamMember!.image!) as ImageProvider,
              fit: BoxFit.cover,
              child: InkWell(
                onTap: () => setState(() => _displayFront = !_displayFront),
              ),
            ),
            Container(
              width: double.infinity,
              height: height * 0.07,
              decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.darken,
                color: Colors.black38,
              ),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                child: _displayFront
                    ? _buildFront(widget.teamMember!)
                    : _buildRear(widget.teamMember!, context),
              ),
            ),
          ])),
    );
  }
}

Widget _buildFront(TeamMember teamMember) {
  Map<String, String> domainList = {
    "tech": "Technical",
    "spons": "Sponsership",
    "pr": "Public Relation",
    "startup": "Startup Founder",
    "doc": "Documentation",
    "design": "Design",
    "videdit": "Video Editing",
    "em": "Event Management",
  };
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(teamMember.name!.toUpperCase(),
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
      teamMember.domain != null && teamMember.domain != "none"
          ? Text(domainList[teamMember.domain!]!,
              style: GoogleFonts.raleway(fontSize: 12, color: Colors.white))
          : Container()
    ],
  );
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
