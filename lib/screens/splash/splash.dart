import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/res/dimens.dart';
import '../../core/res/strings.dart';
import '../../core/utils/injection.dart';
import '../../models/global_state.dart';
import '../../widgets/ecell_animation.dart';
import '../../widgets/screen_background.dart';
import 'cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    String token = sl.get<SharedPreferences>().getString(S.tokenKey);
    if (token == null) {
      Future.delayed(Duration(milliseconds: D.splashDelay))
          .then((value) => Navigator.pushReplacementNamed(context, S.routeLogin));
    } else {
      context.read<SplashCubit>().getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(elementId: 0),
          BlocConsumer<SplashCubit, SplashState>(
            listener: (context, state) {
              if (state is SplashError) {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("Something went wrong. Try loging in again.")));
                Navigator.pushReplacementNamed(context, S.routeLogin);
              } else if (state is SplashSuccess) {
                context.read<GlobalState>().user = state.user;
                Future.delayed(Duration(milliseconds: D.splashDelay ~/ 2))
                    .then((value) => Navigator.pushReplacementNamed(context, S.routeHome));
              }
            },
            builder: (context, state) {
              if (state is SplashSuccess || state is SplashLoading) {
                return Center(child: ECellLogoAnimation(size: width / 2));
              } else {
                return Center(
                  child: Text("Check your internet connection and try again"),
                ); // TODO add retry widget
              }
            },
          ),
        ],
      ),
    );
  }
}
