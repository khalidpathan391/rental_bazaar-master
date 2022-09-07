import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:rental_bazaar/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  // for resend tap
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool agree = false;
  void _doSomething() {}
  // for resend tap

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        // for resend tap
        key: _formKey, // for resend tap
        child: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Image.asset(
                      'assets/images/splash.png',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      color: Colors.deepPurple,
                      child: Card(
                        elevation: 20,
                        shadowColor: Colors.deepPurple,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Enter OTP',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ), //Textstyle
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              PinCodeFields(
                                length: 6,
                                fieldBorderStyle: FieldBorderStyle.Square,
                                responsive: false,
                                fieldHeight: 40.0,
                                fieldWidth: 30.0,
                                borderWidth: 1.0,
                                activeBorderColor: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(10.0),
                                keyboardType: TextInputType.number,
                                autoHideKeyboard: false,
                                borderColor: Colors.deepPurple,
                                textStyle: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                onComplete: (output) {
                                  // Your logic with pin code
                                  print(output);
                                },
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.deepPurple,
                                      minimumSize: const Size(300, 50)),
                                  child: const Text(
                                    'Confirm OTP',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Dashboard()));
                                  }),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(222, 0, 0, 0),
                                //color: Colors.greenAccent,
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const Otp()));
                                  },
                                  child: const Text('Resend',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                      )),
                                  // textColor: MyColor.white,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ), //SizedBox
                            ],
                          ), //Column
                        ), //SizedBox
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
