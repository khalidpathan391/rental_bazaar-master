import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_bazaar/Dashboard.dart';



class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    //final imageUrl ="https://www.facebook.com/imaxamerica/photos/a.372836146242713/731233933736264";
    return Drawer(
      child: Container(
        color: Colors.deepPurple,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName: const Text(
                  "Mohmmed Salman",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                accountEmail: const Text(
                  "m.salman98m@gmail.com",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // currentAccountPicture: CircleAvatar(
                //   backgroundImage: NetworkImage(imageUrl),
                // ),
                currentAccountPicture: Image.asset("assets/images/profile_image.jpg"),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                    context,MaterialPageRoute(builder:(context)=> const Dashboard())
                );
              },
              child: const ListTile(
                leading: Icon(
                  CupertinoIcons.home,
                  color: Colors.white,
                ),
                title: Text(
                  "Dashboard",
                  textScaleFactor: 1.2,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const ListTile(
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white,
              ),
              title: Text(
                "Profile",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
            ),
            const ListTile(
              leading: Icon(
                CupertinoIcons.lock,
                color: Colors.white,
              ),
              title: Text(
                "Change Password",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.privacy_tip,
                color: Colors.white,
              ),
              title: Text(
                "About Us",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text(
                "Sign Out",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
