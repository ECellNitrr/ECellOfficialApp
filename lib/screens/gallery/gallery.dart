import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/models/event.dart';
import 'package:ecellapp/screens/events/cubit/events_cubit.dart';
import 'package:ecellapp/screens/gallery/cubit/gallery_cubit.dart';
import 'package:ecellapp/screens/gallery/cubit/gallery_state.dart';
import 'package:ecellapp/screens/gallery/image_grid.dart';
import 'package:ecellapp/widgets/UI2023widgets/HomeScreen.dart';
import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/reload_on_error.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:ecellapp/widgets/stateful_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/res/strings.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () => _getAllGallery(context),
      child: Scaffold(
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
            BlocBuilder<GalleryCubit, GalleryState>(
              builder: (context, state) {
                if (state is GalleryInitialState)
                  return _buildLoading(context);
                else if (state is GallerySuccessfulState)
                  return _buildSuccess(context, state.galleryList);
                else if (state is GalleryLoadingState)
                  return _buildLoading(context);
                else
                  return ReloadOnErrorWidget(() => _getAllGallery(context));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(child: ECellLogoAnimation(size: width / 2));
  }

  Widget _buildSuccess(BuildContext context, Map<String, dynamic> galleryList) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double ratio = MediaQuery.of(context).size.aspectRatio;
    double top = MediaQuery.of(context).viewPadding.top;

    print(galleryList);
    List<String> years = [];
    galleryList.forEach((key, value) {
      years.add(key);
    });

    return DefaultTextStyle.merge(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: Stack(
        children: [
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
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: EdgeInsets.only(top: top + 40),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Gallery",
                      style: GoogleFonts.raleway(
                          fontSize: ratio>0.5?37:42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5),
                    ),
                  ),
                  SizedBox(
                    height: height ,
                    child: ListView.builder(
                      itemCount: years.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HomeImageSection(
                          height: height,
                          image: S.assetSpeakerBackdrop,
                          text: years[index],
                          elementColor: C.menuButtonColor,
                          gradientColor: C.backgroundBottom,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ImageGrid(
                                    imageUrls: galleryList[years[index]]!.toList(),
                                  galleryText: years[index],
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getAllGallery(BuildContext context) {
    final cubit = context.read<GalleryCubit>();
    cubit.getAllGalleryImages();
  }
}
