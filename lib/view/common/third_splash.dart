import 'package:flutter/material.dart';
import 'package:rent_house/view/common/loginpage.dart';
import 'package:rent_house/view/common/splashreg.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.blueGrey,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 450,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/farmh.png")
                  )
              ),
            ),Container(
              padding: EdgeInsets.all(20),
              height: 200,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("Let's Get Started",style: TextStyle(fontSize:28,fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                  SizedBox(height: 20,),
                  Text("Receive your updates,find your dream home and get started today!",
                    style: TextStyle(fontSize: 16,color: Colors.white),)
                ],

              ),

            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SplashReg()), (route) => false);
              },
                child: Text(
                  "Next",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}
