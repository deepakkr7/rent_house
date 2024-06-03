import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rent_house/view/common/loginpage.dart';
import 'package:rent_house/view/common/splashpage.dart';
import 'package:rent_house/view/user/housepage.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyBLKhr-oJvvxUl-PNgNbMH707WKVL1dTho", appId: "1:610912941848:android:b297d86c400eef016c506d", messagingSenderId: "", projectId: "rent1-b2e34",storageBucket: "rent1-b2e34.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent a House',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login':(context)=>LoginPage()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splashpage(),
    );
  }
}


