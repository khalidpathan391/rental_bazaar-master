// import 'package:flutter/material.dart';
// import 'package:rental_bazaar/SignIn.dart';
// import 'Otp.dart';
//
// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//
//
//   // ignore: unused_field
//   final _formKey = GlobalKey<FormState>();
//   bool isChecked = false;
//   bool agree = false;
//   void _doSomething() {
//     // Do something
//   }
//   @override
//   Widget build(BuildContext context) {
//     return
//       Scaffold(
//         backgroundColor: Colors.white,
//         resizeToAvoidBottomInset: false,
//         body:
//         Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Expanded(
//                   child: Stack(
//                     alignment: Alignment.bottomCenter,
//                     children: [
//                       Column(
//                         children: [
//                           SizedBox(height: 100,),
//                           Image.asset(
//                             'assets/images/splash.png',
//                             fit: BoxFit.cover,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(20.0),
//                             child: Container(
//                               color: Colors.white,
//                               child: TextFormField(
//                                 keyboardType: TextInputType.number,
//                                 decoration: const InputDecoration(
//                                   prefixIcon: Icon(Icons.phone_android,color: Colors.deepPurple,),
//                                   hintText: 'Enter Mobile No.',
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Mobile no. can not be empty';
//                                   } else if (value.length < 10) {
//                                     return 'Mobile no. should be atleast 10 digit';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(20.0),
//                             child: ElevatedButton(
//                               style: TextButton.styleFrom(
//                                   backgroundColor: Colors.deepPurple,
//                                   minimumSize: const Size(330, 50)
//                               ),
//                               onPressed: () {
//                                 if (_formKey.currentState!.validate()) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                         'OTP sent on your Mobile No.',
//                                         style: TextStyle(
//                                             color: Colors.green,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                   );
//                                   Navigator.push(
//                                       context,MaterialPageRoute(builder:(context)=> const Otp())
//                                   );
//                                 }
//                               },
//                               child: const Text(
//                                 'CREATE ACCOUNT',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       ElevatedButton(
//                         style: TextButton.styleFrom(
//                             backgroundColor: Colors.deepPurple,
//                             minimumSize: const Size(300, 50)
//                         ),
//                         onPressed: () {
//                           Navigator.push(
//                               context,MaterialPageRoute(builder:(context)=> const SignIn())
//                           );
//                         },
//                         child: Row(mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [Text(
//                             'Already have an account ? Please Login Here',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15),
//                           ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   )),
//             ],
//           ),
//         ),
//       );
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Otp.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? hint;
  String? token;

  //TextEditingController mobile=new TextEditingController();

  DeviceInfoPlugin deviceInfo =
      DeviceInfoPlugin(); // instantiate device info plugin
  late AndroidDeviceInfo androidDeviceInfo;

  late String board,
      brand,
      device,
      hardware,
      host,
      android_version_id,
      manufacture,
      model,
      product,
      type,
      androidid;
  late bool isphysicaldevice;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    getTokenID();
    getDeviceinfo();
    super.initState();
  }

  void getDeviceinfo() async {
    androidDeviceInfo = await deviceInfo
        .androidInfo; // instantiate Android Device Infoformation
    setState(() {
      board = androidDeviceInfo.board!;
      brand = androidDeviceInfo.brand!;
      device = androidDeviceInfo.device!;
      hardware = androidDeviceInfo.hardware!;
      host = androidDeviceInfo.host!;
      android_version_id = androidDeviceInfo.id!;
      manufacture = androidDeviceInfo.manufacturer!;
      model = androidDeviceInfo.model!;
      product = androidDeviceInfo.product!;
      type = androidDeviceInfo.type!;
      isphysicaldevice = androidDeviceInfo.isPhysicalDevice!;

      androidid = androidDeviceInfo.id!;
    });

    log("Borad:${board}");
  }

  Future<void> getTokenID() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    token = fcmToken;
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fb_token', fcmToken!);
    log("Token : ${fcmToken}");
  }

  Future<void> UploadDeviceInfo() async {
    log("Hello");
    // SERVER LOGIN API URL
    var url = Uri.parse(
        'https://khancollege.000webhostapp.com/service_hub/add_device_info.php');
    // Store all data with Param Name.

    var data = {
      'brand': brand.toString(),
      'board': board.toString(),
      'android_id': androidid.toString(),
      'device': device.toString(),
      'hardware': hardware.toString(),
      'model': model.toString(),
      'android_version_id': android_version_id.toString(),
      'token': token,
      'type': type.toString(),
      'manufacture': manufacture.toString(),
      'host': host.toString(),
      'isphysicaldevice': isphysicaldevice.toString()
    };
    log("Data:${data}");
    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));
    // var response = await http.post(url, body: json.toString);

    // Getting Server response into variable.
    var obj = jsonDecode(response.body.toString());

    // If the Response Message is Matched.
    if (obj["result"] == 'S') {
      print("You are Successfully Registered");
      setState(() {
        // device = "";
      });
    } else {
      print("Sorry Something went wrong.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.deepPurple,
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .05,
            ),
            child: Card(
              color: Colors.white,
              elevation: 25,
              shadowColor: Colors.deepPurple,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  // Image.asset(
                  //   "splash.png",height: 120,
                  // ),
                  const Text(
                    "RENTAL BAZAAR",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Enter your mobile number for verification!",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.deepPurple,
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextFormField(
                        //controller: mobile,
                        onChanged: (text) {
                          setState(() {
                            hint = text;
                          });
                        },
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            counterText: "",
                            icon: Icon(
                              Icons.phone_android,
                              color: Colors.white,
                            ),
                            hintText: "Enter Your Mobile Number",
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  hint?.length == 10
                      ? RaisedButton(
                          color: Colors.deepPurple,
                          onPressed: () {
                            UploadDeviceInfo();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Otp()));
                          },
                          child: const Text(
                            'Send',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
