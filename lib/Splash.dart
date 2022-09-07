import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rental_bazaar/SignUp.dart';



// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const Splash());
// }




class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash> {

  Future<void> getTokenID()
  async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("Token : ${fcmToken}");
  }

  @override
  void initState() {
    getTokenID();
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
            const SignUp()
            ),
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.height * 0.25;
    MediaQuery.of(context).size.width * 0.25;
    return Container(
        color: Colors.white,
        child:Center(
          child: Image.asset("assets/images/splash.png",
            height: 200,
            width: 200,
          ),
        ),
    );
  }
}