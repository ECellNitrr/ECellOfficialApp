import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecellapp/models/sponsor.dart';
import 'package:ecellapp/models/sponsor_category.dart';
import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/reload_on_error.dart';
import 'package:ecellapp/widgets/stateful_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cubit/sponsors_cubit.dart';

class SponserCarousel extends StatelessWidget {
  const SponserCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () => _getAllSponsors(context),
      child: BlocBuilder<SponsorsCubit, SponsorsState>(
        builder: (context, state) {
          if (state is SponsorsInitial)
            return Container();
          else if (state is SponsorsSuccess)
            return _buildSuccess(context, state.sponsorsList);
          else if (state is SponsorsLoading)
            return Container();
          else
            return ReloadOnErrorWidget(() => _getAllSponsors(context));
        },
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, List<SponsorCategory> data) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Sponsor> list = [];
    data.forEach((element) {
      element.spons.forEach((e) {
        list.add(e);
      });
    });

    return (list.length==0)?Container():CarouselSlider.builder(
      itemCount: list.length,
      itemBuilder: ((context, index, realIndex) {
        return Container(
            color: Colors.white,
            width: width * 0.4,
            height: height * 0.12,
            child: Image.network(
              list[index].picUrl!,
              fit: BoxFit.contain,
            ));
      }),
      options: CarouselOptions(
        height: 200,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  void _getAllSponsors(BuildContext context) {
    final cubit = context.read<SponsorsCubit>();
    cubit.getSponsorsList();
  }
}
