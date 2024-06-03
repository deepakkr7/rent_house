import 'package:flutter/material.dart';
import 'package:rent_house/view/common/loginpage.dart';
import 'package:rent_house/view/user/registerpage.dart';
import 'package:rent_house/view/vendor/vendorregister.dart';

class SplashReg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/resort.png'),

                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.2),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rent a House',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'for you.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
              // showDialog(context: context, builder: (context){
              //   return AlertDialog(
              //     title: Text("Sign Up"),
              //     content: Container(
              //       child: Text("Are You a Vendor/User?"),
              //     ),
              //     actions: [
              //       TextButton(onPressed: (){
              //         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>RegPage()), (route) => false);
              //       }, child:Text("User")),
              //       TextButton(onPressed: (){
              //         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>VendorRegister()), (route) => false);
              //       }, child: Text("Vendor"))
              //     ],
              //   );
              // });
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'REGISTER NOW',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}