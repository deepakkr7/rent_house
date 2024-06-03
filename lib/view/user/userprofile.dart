import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  var name;
  var id;
  var email;
  var phone;
  var uid;
  UserProfile({super.key,
  this.name,this.email,this.id,this.phone,this.uid});
  @override
  State<UserProfile> createState() => _UserProfileState();
}
class _UserProfileState extends State<UserProfile> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  initState() {
    nameController.text = widget.name;
    phoneController.text = widget.phone;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit/Update Profile",style: TextStyle(color:Colors.blueGrey),),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          TextFormField(
          controller: nameController,
          validator: (value){
            if(value!.isEmpty){
              return "Enter a Valid name";
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white,width: 2,
              ),
            ),
            hintText: "Name",
            hintStyle: TextStyle(color:Colors.black54),
          ),
        ),
        SizedBox(height: 10,),
        TextFormField(
          controller: phoneController,
          validator: (value){
            if(value!.isEmpty){
              return "Enter a Valid phone";
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white,width: 2,
              ),
            ),
            hintText: "Phone",
            hintStyle: TextStyle(color:Colors.black54),
          ),
        ),
        SizedBox(height: 30,),
            Center(
              child: InkWell(
                onTap: (){
                  FirebaseFirestore.instance.collection('user').doc(widget.id).update({
                    'name':nameController.text,
                    'phone':phoneController.text,
                  }).then((value) => Navigator.pop(context));
                },
                child: Container(
                  height: 45,
                  width: 150,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blueGrey),
                  child: Center(child:
                  Text("Update"),),
                ),
              ),
            )
        ]
      ),
    )
    );
  }
}
