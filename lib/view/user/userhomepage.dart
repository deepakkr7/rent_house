import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_house/view/user/feedbacks.dart';
import 'package:rent_house/view/user/flatpage.dart';
import 'package:rent_house/view/user/housepage.dart';
import 'package:rent_house/view/common/loginpage.dart';
import 'package:rent_house/view/user/notifictionpage.dart';
import 'package:rent_house/view/user/rentroomspage.dart';
import 'package:rent_house/view/user/settings.dart';
import 'package:rent_house/view/user/shortlisteditems.dart';
import 'package:rent_house/view/user/userprofile.dart';
import 'package:rent_house/view/user/villapage.dart';

import 'apartments.dart';

class UserHomePage extends StatefulWidget {
  var name;
  var email;
  var id;
  var phone;
  var uid;
   UserHomePage({this.uid,this.id,this.name,this.email,this.phone,super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return DefaultTabController(length: 5, child:Scaffold(
      appBar: AppBar( title: Text("Welcome ${widget.name}"),
        backgroundColor: Colors.white54,actions: [InkWell(
        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Notifications()));},
        child: Icon(Icons.notifications_none_sharp),
      )

      ],elevation: 0.0,bottom: TabBar(indicatorColor:Colors.green,isScrollable:true,tabs: [
        Tab(icon: Text("Houses",style: TextStyle(color:Colors.black),),),
    Tab(icon:Text("Apartments",style: TextStyle(color:Colors.black),)),
    Tab(icon:Text("Villa",style: TextStyle(color:Colors.black),)),
    Tab(icon:Text("Flat",style: TextStyle(color:Colors.black),)),
    Tab(icon:Text("Rent Rooms",style: TextStyle(color:Colors.black),)),
    ]), ),
      drawer: Drawer(width: 200,shape:  OutlineInputBorder( borderRadius: BorderRadius.circular(10),),backgroundColor: Colors.blueGrey,
         child: ListView(
           children: [
             SingleChildScrollView(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    ListTile(onTap:(){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>UserHomePage()), (route) => false);
                    },
                      leading: Icon(CupertinoIcons.home,),title:Text("Home") ,
                    ),
                     ListTile(onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfile(
                         id: widget.id,
                         name: widget.name,
                         email: widget.email,
                         phone: widget.phone,
                       )));
                     },
                       leading: Icon(CupertinoIcons.person),title: Text("Profile"),
                     ),
                     // ListTile(onTap: (){},
                     //   leading: Icon(CupertinoIcons.location_solid),title: Text("Nearby"),
                     // ),
                     SizedBox(height: 10,),
                     Divider(
                       color: Colors.grey,
                       thickness: 2.0,
                     ),
                     ListTile(onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ShortlistedItem()));
                     },
                       leading: Icon(CupertinoIcons.bookmark),title: Text("Bookmark"),
                     ),
                     // ListTile(onTap: (){},
                     //   leading: Icon(Icons.notifications),title: Text("Notifications"),
                     // ),
                     ListTile(onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Feedbacks()));
                     },
                       leading: Icon(Icons.message_sharp),title: Text("Feedbacks"),
                     ),
                     SizedBox(height: 10,),Divider(
                       color:Colors.grey,
                       thickness: 2.0,
                     ),
                     ListTile(onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));
                     },
                       leading: Icon(Icons.settings),title: Text("Settings"),
                     ),
                     ListTile(onTap: (){},
                       leading: Icon(Icons.help_outline_sharp),title: Text("Help"),
                     ),
                     ListTile(
                       onTap: (){
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text("Sign Out"),
                            content: Container(
                              child: Text("Do You Realy want to Log Out?"),
                            ),
                            actions: [
                              TextButton(onPressed: (){
                                FirebaseAuth.instance.signOut().then((value) =>
                                Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic>route) => false)
                                );
                              }, child: Text("Yes")
                              ),
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text("No"))
                            ],
                          );
                        });
                       },
                       leading: Icon(Icons.logout),title: Text("Logout"),
                     ),
                   ],
                 ),
               ),

           ],
         ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: TabBarView(
          children: [
             Housepage(),
            ApartmentsPage(),
            VillaPage(),
            FlatPage(),
            RentroomPage()
          ],
        )
      ),
    ),
    );
  }
}
