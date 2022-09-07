import 'package:flutter/material.dart';
import 'package:rental_bazaar/Landlord.dart';
import 'package:rental_bazaar/Tenant.dart';
import 'Drawer.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "RENTAL BAZAAR",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 4),
        ),
        // backgroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Image.asset(
                "assets/images/splash.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Landlord()));
                },
                child: AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.deepPurple,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.deepPurple,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(100, 75, 100, 75),
                  child: const Text('AS A LANDLORD',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Tenant()));
                },
                child: AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.deepPurple,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.deepPurple,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(110, 75, 110, 75),
                  child: const Text('AS A TENANT',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
