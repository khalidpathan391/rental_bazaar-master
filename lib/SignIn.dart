// import 'package:flutter/material.dart';
// import 'package:rental_bazaar/SignUp.dart';
// import 'Otp.dart';
//
// class SignIn extends StatefulWidget {
//   const SignIn({Key? key}) : super(key: key);
//
//   @override
//   State<SignIn> createState() => _SignInState();
// }
//
// class _SignInState extends State<SignIn> {
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
//                                 decoration: new InputDecoration(
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
//                                         'Welcome Back',
//                                         style: TextStyle(
//                                             color: Colors.green,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                   );
//                                  // Navigator.pushNamed(context, MyRoutes.homeRoute);
//                                 }
//                               },
//                               child: const Text(
//                                 'LOGIN',
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
//                               context,MaterialPageRoute(builder:(context)=> const SignUp())
//                           );
//                         },
//                         child: Row(mainAxisAlignment: MainAxisAlignment.center,
//                           children: [Text(
//                             'Create New Account ',
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
