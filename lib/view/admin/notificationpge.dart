import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ManageNotification extends StatefulWidget {
  var uid;
  ManageNotification({super.key,this.uid});

  @override
  State<ManageNotification> createState() => _ManageNotificationState();
}

class _ManageNotificationState extends State<ManageNotification> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  final notifkey=GlobalKey<FormState>();

  var uuid = Uuid();
  var _notid;
  List<String>category=["User","Vendor"];
  String?_selectedCategory;
  @override
  initState() {
    _notid = uuid.v1();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(key: notifkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Create New Notification",style: TextStyle(fontSize: 20),),
                SizedBox(height: 20,),
                TextFormField(
                   controller: titleController,
                  validator: (value){
                     if(value!.isEmpty){
                       return "return a valid title";
                     }
                  },
                  decoration:InputDecoration(hintText: "Title"),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: descriptionController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "return a valid description";
                    }
                  },
                  decoration:InputDecoration(hintText: "Description"),
                ),
                SizedBox(height: 15,),
                DropdownButtonFormField<String>(decoration: InputDecoration(hintText: "Select Category"),
                    items: category.map((String value){
                      return DropdownMenuItem<String>(value:value,child: Text(value));
                    }).toList(),
                    onChanged: (String ?newValue){
                       _selectedCategory=newValue;
                    }),
                SizedBox(height: 30,),
                Center(
                  child: InkWell(
                    onTap: (){
                      if(notifkey.currentState!.validate()){
                        FirebaseFirestore.instance.collection("Notification").doc(_notid).set({
                          'notid':_notid, 'title':titleController.text,
                          'description':descriptionController.text,
                          'category':_selectedCategory,
                          'createdAt':DateTime.now(),
                          'status':1
                        }).then((value){
                          Navigator.pop(context);
                        });
                      }

                    },
                    child: Container(
                      height: 45,
                      width: 200,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blueGrey),
                      child: Center(
                        child: Text("Add"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

      ),
    );
  }
}
