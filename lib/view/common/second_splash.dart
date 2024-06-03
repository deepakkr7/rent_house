import 'package:flutter/material.dart';
import 'package:rent_house/view/common/third_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
                      image: AssetImage("assets/images/farm.png")
                  )
              ),
            ),Container(
              padding: EdgeInsets.all(20),
              height: 200,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("Connect & Apply",style: TextStyle(fontSize:28,fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                  SizedBox(height: 20,),
                  Text("Connect with owners for personalized assistance.\nEasily apply and save your favourite listings",
                    style: TextStyle(fontSize: 15,color: Colors.white),)
                ],

              ),

            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Splash()), (route) => false);
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
