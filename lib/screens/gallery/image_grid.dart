import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/res/colors.dart';
import '../../core/res/dimens.dart';
import '../../core/res/strings.dart';
import '../../widgets/screen_background.dart';

class ImageGrid extends StatelessWidget {
  ImageGrid({required this.imageUrls, required this.galleryText});
  final List<dynamic> imageUrls;
  final String galleryText;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          padding: EdgeInsets.only(left: D.horizontalPadding - 10, top: 10),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Stack(
        children: [
          ScreenBackground(elementId: 0),
          Padding(
            padding:
            EdgeInsets.fromLTRB(width * 0.1, height * 0.35, 0.0, 0.0),
            child: Container(
              height: height * 0.4,
              width: width * 0.8,
              child: Image.asset(
                S.assetEcellLogoWhite,
                fit: BoxFit.contain,
                opacity: const AlwaysStoppedAnimation<double>(0.5),
              ),
            ),
          ),
          Container(
            height: height*0.15,
            child: Align(
              alignment: Alignment.center,
              child: Text(galleryText, style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 32.0, color: Colors.white),),
            ),
          ),
          Column(
            children: [
              SizedBox(height: height*0.15,),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the full-screen view when an image is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return FullScreenImage(imageUrl: "${imageUrls[index]['big']}");
                            },
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'image$index',
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            "${imageUrls[index]['small']}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.backgroundBottom,
      appBar: AppBar(
        title: Text('Full Screen Image'),
      ),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}