import 'package:flutter/material.dart';
import 'package:rent_house/view/admin/notificationpge.dart';
import 'package:rent_house/view/admin/viewallUser.dart';
import 'package:rent_house/view/admin/viewallVendor.dart';
import 'package:rent_house/view/admin/viewallfeedbacks.dart';
import 'package:rent_house/view/common/loginpage.dart';


class AdminHomepg extends StatefulWidget {
  const AdminHomepg({super.key});

  @override
  State<AdminHomepg> createState() => _AdminHomepgState();
}

class _AdminHomepgState extends State<AdminHomepg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey,
        title: Text("Admin Dash Board",style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>LoginPage()) , (route) => false);
          }, icon:Icon( Icons.logout_sharp))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.blueGrey ),
                      child: InkWell(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllUser()));
                      },
                      child: Center(
                        child: Text("View User"),
                      ),),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(child: Container(height: 100,
                    width: 150,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.blueGrey ),
                    child: InkWell(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewALlVendors()));
                    },
                      child: Center(
                        child: Text("View Vendor"),
                      ),),))

                ],
              ),
              SizedBox(height: 20,),
              Container(
                height:100,
                child: Row(
                  children: [
                    Expanded(child: InkWell(onTap: (){},
                    child: Container(height: 100,
                        width: 150,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.blueGrey ),
                        child: InkWell(onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewAllFeedbacks()));
                        },
                          child: Center(
                            child: Text("View All Feedbacks"),
                          ))
                    ),)),
                    SizedBox(width: 20,),
                    Expanded(child: Container(height: 100,
                      width: 150,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.blueGrey ),
                      child: InkWell(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageNotification()));
                      },
                        child: Center(
                          child: Text("Manage All Notification"),
                        ),),))

                  ],

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
