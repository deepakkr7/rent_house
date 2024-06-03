import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("SETTINGS"),),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                Text("Notification")
              ],
            ),
            Divider(thickness: 1,color: Colors.grey,),
            Row(
              children: [Text("Privacy"),
              SizedBox(width:200 ,),
                IconButton(onPressed: (){}, icon:Icon(Icons.arrow_forward_ios)),
              ],
            ),
            Divider(thickness: 1,color: Colors.grey,),
          Row(
            children: [
              Text("Delete Account"),
              SizedBox(width:150 ,),
              IconButton(onPressed: (){

              }, icon:Icon(Icons.arrow_forward_ios)),
            ],
          ),
            Divider(thickness: 1,color: Colors.grey,),
          ],
        ),
      ),
    );
  }
}
