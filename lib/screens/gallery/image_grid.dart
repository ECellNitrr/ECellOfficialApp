import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/res/colors.dart';
import '../../widgets/screen_background.dart';

class ImageGrid extends StatelessWidget {
  ImageGrid({required this.imageUrls, required this.galleryText});
  final List<dynamic> imageUrls;
  final String galleryText;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(elementId: 0),
          Container(
            height: height*0.15,
            child: Align(
              alignment: Alignment.center,
              child: Text(galleryText, style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 32.0, color: Colors.white),),
            ),
          ),
          Column(
            children: [
              SizedBox(height: height*0.12,),
              SizedBox(
                height: height*0.88,
                child: GridView.builder(
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
                              return FullScreenImage(imageUrl: imageUrls[index]['small']);
                            },
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'image$index',
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            imageUrls[index]['small'],
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