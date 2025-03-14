import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecellapp/screens/login/login.dart';
import 'cubit/login_cubit.dart';
class firebaseCred {
  static String? name;
}
Future<void> userSetup(int Score) async {
  String email=LoginScreen.emailController.text;
  String? Name=firebaseCred.name;
  CollectionReference users = FirebaseFirestore.instance.collection('SCORE');
  await users.doc(LoginCubit.mailToken).set({'Name': Name,'email':email, 'token': LoginCubit.mailToken,'Score':Score});
  // FirebaseFirestore auth = FirebaseFirestore.instance;
  // users.add({'Name': Name,'email':email, 'token': LoginCubit.Token,'Score':Score});
  return;
}