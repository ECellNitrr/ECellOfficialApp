import 'package:ecellapp/screens/b_quiz/bquiz.dart';
import 'package:ecellapp/screens/b_quiz/leaderBoard/cubit/leaderboard_cubit.dart';
import 'package:ecellapp/screens/b_quiz/leaderBoard/leader_board.dart';
import 'package:ecellapp/screens/b_quiz/leaderBoard/leaderboard_repository.dart';
import 'package:ecellapp/screens/b_quiz/leaderboard_list.dart';
import 'package:ecellapp/screens/b_quiz/quiz_success.dart';
import 'package:ecellapp/screens/sponsors/sponsorship_head/cubit/sponsors_head_cubit.dart';
import 'package:ecellapp/screens/sponsors/sponsorship_head/sponsors_head_repository.dart';
import 'package:ecellapp/screens/sponsors/sponsorship_head/sponsorship_head.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'core/res/strings.dart';
import 'core/themes/app_theme.dart';
import 'core/utils/injection.dart';
import 'models/global_state.dart';
import 'screens/about_us/about_us.dart';
import 'screens/about_us/tabs/team/cubit/team_cubit.dart';
import 'screens/about_us/tabs/team/team_repository.dart';
import 'screens/esummit/esummit.dart';
import 'screens/events/cubit/events_cubit.dart';
import 'screens/events/events.dart';
import 'screens/events/events_repository.dart';
import 'screens/home/cubit/feedback_cubit.dart';
import 'screens/home/home.dart';
import 'screens/home/home_repository.dart';
import 'screens/login/cubit/login_cubit.dart';
import 'screens/login/login.dart';
import 'screens/login/login_repository.dart';
import 'screens/signup/cubit/signup_cubit.dart';
import 'screens/signup/signup.dart';
import 'screens/signup/signup_repository.dart';
import 'screens/speaker/cubit/speaker_cubit.dart';
import 'screens/speaker/speaker.dart';
import 'screens/speaker/speaker_repository.dart';
import 'screens/splash/cubit/splash_cubit.dart';
import 'screens/splash/splash.dart';
import 'screens/splash/splash_repository.dart';
import 'screens/sponsors/cubit/sponsors_cubit.dart';
import 'screens/sponsors/sponsors.dart';
import 'screens/sponsors/sponsors_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(ECellApp());
}

class ECellApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Provider(
      create: (_) => GlobalState(),
      child: MaterialApp(
        routes: {
          S.routeSplash: (_) => BlocProvider(
              create: (_) => SplashCubit(APISplashRepository()),
              child: SplashScreen()),
          S.routeLogin: (_) => BlocProvider(
              create: (_) => LoginCubit(APILoginRepository()),
              child: LoginScreen()),
          S.routeSignup: (_) => BlocProvider(
              create: (_) => SignupCubit(APISignupRepository()),
              child: SignupScreen()),
          S.routeHome: (_) => BlocProvider(
              create: (_) => FeedbackCubit(APIHomeRepository()),
              child: HomeScreen()),
          S.routeSpeaker: (_) => BlocProvider(
              create: (_) => SpeakerCubit(APISpeakerRepository()), child: SpeakerScreen()),
          S.routeEvents: (_) => BlocProvider(
              create: (_) => EventsCubit(APIEventsRepository()), child: EventsScreen()),
          S.routeSponsors: (_) => BlocProvider(
              create: (_) => SponsorsCubit(APISponsorsRepository()), child: SponsorsScreen()),
          S.routeSponsorsHead: (_) => BlocProvider(
              create: (_) => SponsorsHeadCubit(APISponsorsHeadRepository()), child: SponsorsHeadScreen()),
          S.routeEsummit: (_) => ESummitScreen(),
          S.routeBQuiz: (_) => BQuiz(),
          S.routeBQuizLeaderboard: (_) => LeaderList(),
          S.routeAboutUs: (_) =>
              BlocProvider(create: (_) => TeamCubit(APITeamRepository()), child: AboutUsScreen()),
          S.routeTeamYear: (_) =>
              BlocProvider(create: (_) => TeamCubit(APITeamRepository()), child: AboutUsScreen()),
        },
        initialRoute: S.routeSplash,
        title: "ECellApp",
        theme: AppTheme.themeData(context),
      ),
    );
  }
}