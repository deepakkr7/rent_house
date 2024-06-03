import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rent_house/view/vendor/add%20images.dart';
import 'package:rent_house/view/vendor/vendor%20notification.dart';
import 'package:rent_house/view/vendor/vendorprofile.dart';
import 'package:rent_house/view/vendor/vendorservice.dart';
import 'package:rent_house/view/vendor/viewallbooking.dart';


class VendorHome extends StatefulWidget {
  var vendorname;
  var email;
  var phone;
  var place;
  var id;
  var title;
  VendorHome({super.key,this.title,
  this.vendorname,this.email,this.phone,this.place,this.id});
  @override
  State<VendorHome> createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
              onPressed: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    title: Text("Sign Out"),
                    content: Container(
                      child: Text("Do You Really Want to Log Out?"),
                    ),
                    actions: [
                      TextButton(onPressed: (){
                        FirebaseAuth.instance.signOut().then((value) =>
                            Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic>route) => false)

                        );
                      },child: Text("Yes"),
                      ),
                      TextButton(onPressed: (){Navigator.pop(context);}, child: Text("No"),)
                    ],
                  );
                });
              }, icon: Icon(Icons.logout_sharp)
          )
        ],
      ),
      body:Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome${widget.vendorname}"),
              Text("Vendor Dashboard",style: TextStyle(color: Colors.black,fontSize: 25),),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      width: 200,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey),
                      child: InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorService(
                      id: widget.id,
                       vendorname: widget.vendorname,
                        email: widget.email,
                        place: widget.place,
                        phone: widget.phone,
                      ),
                      )
                        );
                      },child: Center(
                        child: Text("Manage Services",style: TextStyle(color: Colors.white),),
                      ),),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(child: Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey),
                    child: InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllBooking()));},child: Center(
                      child: Text("View All Bookings",style: TextStyle(color: Colors.white),),
                    ),),
                  )),
                ],
              ),
              SizedBox(height: 20,),
            Row(
              children: [
                Expanded(child: Container(
                  height: 150,
                  width: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey),
                  child: InkWell(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorNotification()));

                  },child: Center(child: Text("View All Notification",style: TextStyle(color: Colors.white),),),),
                )),
                SizedBox(width: 20,),
                Expanded(child: Container(
                  height: 150,
                  width: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey),
                  child: InkWell(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorProfile(
                      id: widget.id,
                      name: widget.vendorname,
                      email: widget.email,
                      place: widget.place,
                      phone: widget.phone,

                    )));

                  },child: Center(
                    child: Text("Edit Profile",style: TextStyle(color: Colors.white),),
                  ),),
                )),
              ],
            ),
             // SizedBox(height: 10,),
              Expanded(child: Center(
                child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey),
                  child: InkWell(onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPropertyScreen(
                      // title: widget.title,
                      // id: widget.id,

                     )));

                  },child: Center(
                    child: Text("Image Add",style: TextStyle(color: Colors.white),),
                  ),),
                ),
              ))
                  ],
                ),

            )
    );
  }
}
