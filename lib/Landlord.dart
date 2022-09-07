import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:rental_bazaar/base_category.dart';
import 'package:rental_bazaar/model/landlord.dart';

class Landlord extends StatefulWidget {
  const Landlord({Key? key}) : super(key: key);

  @override
  State<Landlord> createState() => _LandlordState();
}

class _LandlordState extends State<Landlord> {
  ImagePicker picker = ImagePicker();
  XFile? uploadimage;

  bool isLoading = false;

  TextEditingController name = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController mobile = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController reference_code = new TextEditingController();

  Future<void> PicInsert() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "https://khancollege.000webhostapp.com/service_hub/landlord_profile.php"));

    request.files
        .add(await http.MultipartFile.fromPath('image', uploadimage!.path));

    request.fields["name"] = name.text;
    request.fields["address"] = address.text;
    request.fields["mobile"] = mobile.text;
    request.fields["email"] = email.text;
    request.fields["reference_code"] = reference_code.text;

    // request.fields["desig"] = designationName!;
    var res = await request.send();
    print("hello");

    if (res.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      name.clear();
      address.clear();
      mobile.clear();
      email.clear();
      reference_code.clear();

      uploadimage = null;
      print("Successfully Uploaded");

      Fluttertoast.showToast(
          msg: "Saved Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setState(() {
        isLoading = false;
        print("Error :Data is not subbmitted");
      });
    }
  }

  String error = "";
  var landlordList;
  List<LandlordCat> p = [];
  List? data;

  @override
  void initState() {
// TODO: implement initState
    super.initState();

    getLandlord();
  }

  // Future<void> getLandlord() async {
  //   print("Bye........");

  //   var prm = {"name": name};
  //   print(name.toString());
  //   // var prm = {};
  //   // Starting App API Call.
  //   var response = await http
  //       .post(
  //           Uri.parse(
  //               "https://khancollege.000webhostapp.com/service_hub/fetch_landlord.php"),
  //           body: prm)
  //       .catchError((e) {
  //     log(e.toString());
  //     if (e is SocketException) print("No internet connection");
  //   });
  //   var obj = jsonDecode(response.body);
  //   if (obj["result"] == "S") {
  //     print("Hello........");
  //     setState(() {
  //       data = obj["data"];
  //       int? l = data?.length;
  //       // for (int x = 0; x < l!; x++) {
  //       //   print(data[x]);
  //       //   p.add(LandlordCat(
  //       //       data![x]["id"],
  //       //       data![x]["name"],
  //       //       data![x]["address"],
  //       //       data![x]["mobile"],
  //       //       data![x]["email"],
  //       //       data![x]["reference_code"],
  //       //       data![x]["pic"]));
  //       log(name.toString());
  //       // }
  //       print("Lengthhhh:${l}");
  //     });
  //   } else {
  //     setState(() {
  //       // isLoading = false;
  //       // error = "Student Class is not valid in the list";
  //     });
  //   }
  // }
  Future<void> getLandlord() async {
    var data = {
      "class": "",
    };
// Starting App API Call.
    var response = await http
        .post(
            Uri.parse(
                "https://khancollege.000webhostapp.com/service_hub/fetch_landlord.php"),
            body: json.encode(data))
        .catchError((e) {
      if (e is SocketException) print("No internet connection");
      log(data.toString());
      setState(() {
        error = "";
        isLoading = false;
      });
    });
// Getting Server response into variable.
    var obj = jsonDecode(response.body);

    if (obj["result"] == "S") {
      setState(() {
        error = "";
        isLoading = false;
        landlordList = obj["data"];
      });

      for (int x = 0; x < landlordList.length; x++) {
        p.add(new LandlordCat(
            landlordList[x]['name'],
            landlordList[x]['address'],
            landlordList[x]['mobile'],
            landlordList[x]['email'],
            landlordList[x]['reference_code'],
            landlordList[x]['pic']));
      }

      log("Result:${p[0].email}");
    } else {
      setState(() {
        isLoading = false;
        error = "Student Class is not valid in the list";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            const Text(
              "PROFILE DETAILS",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.deepPurple),
            ),
            const Text(
              "Give us few details about yourself",
              style: TextStyle(fontSize: 15),
            ),
            const Text(
              "to create your Profile",
              style: TextStyle(fontSize: 15),
            ),
            GestureDetector(
              onTap: () {
                showPicker(context);
              },
              child: uploadimage == null
                  ? Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurple),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add_a_photo_outlined,
                        size: 50,
                        color: Colors.deepPurple,
                      ),
                    )
                  : Container(
                      width: 150.0,
                      height: 150.0,
                      // decoration: BoxDecoration(
                      //   shape: BoxShape.circle,
                      //   color: Colors.black,
                      //   image: DecorationImage(
                      //     fit: BoxFit.cover,
                      //     image: FileImage(File(uploadimage!.path.toString())
                      //     ),
                      //   ),
                      // ),
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: address,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.home,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Full Address',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: mobile,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.phone_android,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Mobile Number',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Email ID',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: reference_code,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.messenger,
                  color: Colors.deepPurple,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Reference Code (optional)',
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    minimumSize: const Size(330, 50)),
                child: const Text(
                  'CONFIRM',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                onPressed: () {
                  // Navigator.push(
                  //     context,MaterialPageRoute(builder:(context)=> SelectDeliveryLocation())
                  setState(() {
                    isLoading = true;
                    PicInsert();
                  });
                }),
          ],
        ),
      ),
    );
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Album'),
                    onTap: () {
                      chooseImageFromGalary();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    chooseImageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> chooseImageFromGalary() async {
    XFile? choosedimage = await picker.pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage!;
    });
  }

  Future<void> chooseImageFromCamera() async {
    XFile? choosedimage = await picker.pickImage(source: ImageSource.camera);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage!;
    });
  }
}
