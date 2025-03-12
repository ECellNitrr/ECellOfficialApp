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
import 'package:ecellapp/models/user.dart' as uo;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // String? token = sl.get<SharedPreferences>().getString(S.mailTokenKey);
    String? email = sl.get<SharedPreferences>().getString(S.email);
    String? firstName = sl.get<SharedPreferences>().getString(S.firstName);
    String? lastName = sl.get<SharedPreferences>().getString(S.lastName);
    String? phone = sl.get<SharedPreferences>().getString(S.phone);
    if (email == null) {
      Future.delayed(Duration(milliseconds: D.splashDelay)).then(
          (value) => Navigator.pushReplacementNamed(context, S.routeLogin));
    } else {
      print('I have come here');
      // if(email!=null){
      String f = (firstName == null ? email : firstName);
      String l = (lastName == null ? "" : lastName);
      String e = email;
      String p = (phone == null ? "xxxxxxxxxx" : phone);
      // List<String> words = sl.get<SharedPreferences>().getString('name')!.split(' ');
      // f=words[0];
      // if(words.length>1)l=words[words.length-1];
      // e=sl.get<SharedPreferences>().getString('email')??"Unknown";
      context.read<GlobalState>().user = uo.User.rtr(f, l, e, p);
      Future.delayed(Duration(milliseconds: D.splashDelay)).then(
          (value) => Navigator.pushReplacementNamed(context, S.routeHome));
      // }
      // else context.read<SplashCubit>().getProfile();
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
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text("Something went wrong. Try logging in again.")));
                Navigator.pushReplacementNamed(context, S.routeLogin);
              } else if (state is SplashSuccess) {
                context.read<GlobalState>().user = state.user;
                Future.delayed(Duration(milliseconds: D.splashDelay ~/ 2)).then(
                    (value) =>
                        Navigator.pushReplacementNamed(context, S.routeHome));
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
