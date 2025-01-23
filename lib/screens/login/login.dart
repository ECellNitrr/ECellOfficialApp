import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/email_field.dart';
import 'package:ecellapp/widgets/password_field.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/injection.dart';
import '../../widgets/raisedButton.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecellapp/models/global_state.dart';
import 'package:ecellapp/models/user.dart' as uo;
import '../home/home.dart';
import 'cubit/login_cubit.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  String? UserName;
  String? Photourl;
  googleLogin() async {
    await Firebase.initializeApp();
    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var result = await _googleSignIn.signIn();
      if (result == null) {
        return;
      }
      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult =
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        actions: [
          ElevatedButton(
            onPressed: logout,
            child: const Text(
              'LogOut',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Google Login'), onPressed:(){
          googleLogin;
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        },
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  static final TextEditingController passwordController = TextEditingController();
  static final TextEditingController emailController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  static String f="a";
  static String l="b";
  static String e="Unknown";
  static String  p="xxxxxxxxxx";
  Future<bool> googleLogin() async {
    await Firebase.initializeApp();
    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var reslut = await _googleSignIn.signIn();
      if (reslut == null) {
        return false;
      }
      final userData = await reslut.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);

      String token = reslut.id;

      while (token!.length > 0) {
        int initLength = (token!.length >= 500 ? 500 : token.length);
        print(token.substring(0, initLength));
        int endLength = token.length;
        token = token.substring(initLength, endLength);
      }


      var finalResult =
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("Result $reslut");print(token);
      print(reslut.displayName);
      print(reslut.email);
      print(reslut.id);
      await sl
          .get<SharedPreferences>()
          .setString(S.tokenKeySharedPreferences, reslut.id);
      await sl
          .get<SharedPreferences>()
          .setString('email',reslut.email);
      await sl
          .get<SharedPreferences>()
          .setString('name',reslut.displayName??"Unknown");
      print(reslut.photoUrl);
      List<String> words = reslut.displayName!.split(' ');
      f=words[0];
      if(words.length>1)l=words[words.length-1];
      e=reslut.email;
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    try{
      FirebaseAuth.instance.signOut();
    }
    catch(error){
      print(error);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Login Successful")));
            Navigator.pushReplacementNamed(context, S.routeSplash);
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              ScreenBackground(elementId: 1),
              if (state is LoginLoading)
                _buildLoading(context)
              else
                _buildInitial(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInitial(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    double heightFactor = height / 1000;
    if (_scrollController.hasClients) {
      if (bottom > height * 0.25) {
        _scrollController.animateTo(
          bottom - height * 0.25,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else {
        _scrollController.animateTo(0,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
    }
    return DefaultTextStyle(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            child: Container(
              height: height * 1.25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Space for clouds
                  Expanded(flex: 2, child: Container()),
                  //Contains all fields
                  Flexible(
                    flex: 7,
                    child: Column(
                      children: [
                        // Logo
                        Container(
                          alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.only(left: D.horizontalPadding + 1),
                          child: Image.asset(
                            S.assetEcellLogoWhite,
                            width: width * 0.25 * heightFactor,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                              left: D.horizontalPadding, top: 20),
                          child: Text(
                            "Welcome",
                            style: TextStyle(
                                fontSize: 35 * heightFactor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        //Text Greeting
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                              left: D.horizontalPadding, top: 5),
                          child: RichText(
                            text: TextSpan(
                              text: "Let's ",
                              children: [
                                TextSpan(
                                    text: "Sign ",
                                    style: TextStyle(
                                        color: C.primaryHighlightedColor)),
                                TextSpan(
                                    text: "you in",
                                    style: TextStyle(
                                        color: C.primaryUnHighlightedColor)),
                              ],
                              style: TextStyle(fontSize: 25 * heightFactor),
                            ),
                          ),
                        ),
                        SizedBox(height: 23 * heightFactor),
                        //Fields
                        Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: D.horizontalPadding),
                              child: Column(
                                children: [
                                  EmailField(emailController),
                                  SizedBox(height: 20 * heightFactor),
                                  PasswordField(passwordController),
                                  SizedBox(height: 20 * heightFactor),
                                ],
                              ),
                            )),
                        SizedBox(height: 20 * heightFactor),
                        //Redirect to Forgot Password
                        // Container(
                        //   padding: EdgeInsets.only(right: D.horizontalPadding),
                        //   alignment: Alignment.topRight,
                        //   child: GestureDetector(
                        //     child: Text(
                        //       "",
                        //       style: TextStyle(
                        //           fontSize: 20 * heightFactor,
                        //           color: C.secondaryColor),
                        //     ),
                        //     onTap: () {
                        //       //TODO: Forgot Password Route
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  //LoginButton
                  Flexible(
                    child: Container(
                      height:50,
                      padding: EdgeInsets.only(right: D.horizontalPadding),
                      alignment: Alignment.topRight,
                      child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: C.authButtonColor.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: Offset(0, 12),
                            )
                          ],
                        ),
                       child: LegacyRaisedButton(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        color: C.authButtonColor,
                      onPressed: () => _login(context),
                      child: Container(
                        height: 50,
                        width: 100,
                        alignment: Alignment.center,
                        child: Text(
                          "Log In!",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color: C.backgroundBottom,
                            fontSize: 20 * heightFactor,
                          ),
                        ),
                      ),
                    ),
                      ),
                    ),
                  ),
                  SizedBox(height:30*heightFactor),
                  Flexible(
                    child: Container(
                      height:50,
                      padding: EdgeInsets.only(right: D.horizontalPadding),
                      alignment: Alignment.topRight,
                      child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: C.authButtonColor.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: Offset(0, 12),
                            )
                          ],
                        ),
                       child:  LegacyRaisedButton(
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              color: C.authButtonColor,
                              onPressed:(){
                                // logout();
                                googleLoginwait() async{
                                  bool lg=await googleLogin();
                                  if(lg){

                                    context.read<GlobalState>().user=uo.User.rtr(f,l,e,p);
                                    print(context.read<GlobalState>().user?.firstName);
                                    Navigator.pushReplacementNamed(context, S.routeHome);}
                                }
                                googleLoginwait();
                              },
                              child: Container(
                                height: 50,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: C.authButtonColor.withOpacity(0.2),
                                      blurRadius: 10,
                                      spreadRadius: 3,
                                      offset: Offset(0, 12),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/google.png',
                                      height: 20 * heightFactor,
                                      color: C.backgroundBottom,
                                    ),
                                    SizedBox(width: 8), // Add spacing between the icon and the container
                                    Text(
                                      "Sign in",
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        color: C.backgroundBottom,
                                        fontSize: 20 * heightFactor,
                                      ),
                      )]))))
                                    ),
                      
                                  
                  ),
                  SizedBox(height:30*heightFactor),
                  Flexible(
                    child: Container(
                      height:50,
                      padding: EdgeInsets.only(right: D.horizontalPadding),
                      alignment: Alignment.topRight,
                      child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: C.authButtonColor.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: Offset(0, 12),
                            )
                          ],
                        ),
                       child: LegacyRaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          color: C.authButtonColor,
                          onPressed: () {
                            // logout();
                            f = "Guest";
                            l = "Guest";
                            e = "Unkown";
                            context.read<GlobalState>().user =
                                uo.User.rtr(f, l, e, p);
                            Navigator.pushReplacementNamed(
                                context, S.routeHome);
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: C.authButtonColor.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 3,
                                  offset: Offset(0, 12),
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/guests.png',
                                  height: 20 * heightFactor,
                                  color: C.backgroundBottom,
                                ),
                                SizedBox(
                                    width:
                                        8), // Add spacing between the icon and the container
                                Text(
                                  "Skip",
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                    color: C.backgroundBottom,
                                    fontSize: 20 * heightFactor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   flex:2,
                  //   child: Container(
                  //     height:50,
                  //     padding: EdgeInsets.only(right: D.horizontalPadding),
                  //     alignment: Alignment.topRight,
                  //     child: Column(
                  //     children: [
                  //     LegacyRaisedButton(
                  //     shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  //             ),
                  //             color: C.authButtonColor,
                  //             onPressed:(){
                  //               // logout();
                  //               googleLoginwait() async{
                  //                 bool lg=await googleLogin();
                  //                 if(lg){

                  //                   context.read<GlobalState>().user=uo.User.rtr(f,l,e,p);
                  //                   print(context.read<GlobalState>().user?.firstName);
                  //                   Navigator.pushReplacementNamed(context, S.routeHome);}
                  //               }
                  //               googleLoginwait();
                  //             },
                  //             child: Container(
                  //               height: 50,
                  //               width: 100,
                  //               alignment: Alignment.center,
                  //               decoration: BoxDecoration(
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(20)),
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                     color: C.authButtonColor.withOpacity(0.2),
                  //                     blurRadius: 10,
                  //                     spreadRadius: 3,
                  //                     offset: Offset(0, 12),
                  //                   )
                  //                 ],
                  //               ),
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: <Widget>[
                  //                   Image.asset(
                  //                     'assets/google.png',
                  //                     height: 20,
                  //                     color: C.backgroundBottom,
                  //                   ),
                  //                   SizedBox(width: 8), // Add spacing between the icon and the container
                  //                   Text(
                  //                     "Sign in",
                  //                     style: GoogleFonts.lato(
                  //                       fontWeight: FontWeight.bold,
                  //                       color: C.backgroundBottom,
                  //                       fontSize: 20 * heightFactor,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(height: 30 * heightFactor),
                            // LegacyRaisedButton(
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.all(Radius.circular(10)),
                            //   ),
                            //   color: C.authButtonColor,
                            //   onPressed:(){
                            //     // logout();
                            //     f="Guest";
                            //     l="Guest";
                            //     e="Unkown";
                            //     context.read<GlobalState>().user=uo.User.rtr(f,l,e,p);
                            //     Navigator.pushReplacementNamed(context, S.routeHome);
                            //   },
                            //   child: Container(
                            //     height: 50,
                            //     width: 100,
                            //     alignment: Alignment.center,
                            //     decoration: BoxDecoration(
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(20)),
                            //       boxShadow: [
                            //         BoxShadow(
                            //           color: C.authButtonColor.withOpacity(0.2),
                            //           blurRadius: 10,
                            //           spreadRadius: 3,
                            //           offset: Offset(0, 12),
                            //         )
                            //       ],
                            //     ),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: <Widget>[
                            //         Image.asset(
                            //           'assets/guests.png',
                            //           height: 20,
                            //           color: C.backgroundBottom,
                            //         ),
                            //         SizedBox(width: 8), // Add spacing between the icon and the container
                            //         Text(
                            //           "Skip",
                            //           style: GoogleFonts.lato(
                            //             fontWeight: FontWeight.bold,
                            //             color: C.backgroundBottom,
                            //             fontSize: 20 * heightFactor,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                  //           //New here Text
                  //         ],
                  //     ),
                  //   )

                  // ),

                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: (width / 10), top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('New here? ',
                              style: TextStyle(
                                  fontSize: 20 * heightFactor,
                                  color: C.secondaryColor)),
                          GestureDetector(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: C.primaryHighlightedColor,
                                  fontSize: 20 * heightFactor),
                            ),
                            onTap: () => Navigator.pushReplacementNamed(
                                context, S.routeSignup),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // To flex background
                  Expanded(flex: 3, child: Container()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(child: ECellLogoAnimation(size: width / 2));
  }

  void _login(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    if (_formKey.currentState!.validate())
      cubit.login(emailController.text, passwordController.text);
  }
}
