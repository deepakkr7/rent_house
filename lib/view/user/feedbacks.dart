import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Feedbacks extends StatefulWidget {
  const Feedbacks({super.key});
  @override
  State<Feedbacks> createState() => _FeedbacksState();
}
class _FeedbacksState extends State<Feedbacks> {
  TextEditingController titleController=TextEditingController();
  TextEditingController messageController=TextEditingController();
  final feedkey=GlobalKey<FormState>();
  var uuid=Uuid();
  var _notid;
  @override
  initState() {
    _notid = uuid.v1();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedbacks"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child:  Form(key: feedkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("Create New Notification",style: TextStyle(fontSize: 20),),
              // SizedBox(height: 20,),
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
                controller: messageController,
                validator: (value){
                  if(value!.isEmpty){
                    return "return a valid message";
                  }
                },
                decoration:InputDecoration(hintText: "Message"),
              ),
              SizedBox(height: 30,),
              Center(
                child: InkWell(
                  onTap: (){
                    if(feedkey.currentState!.validate()){
                      FirebaseFirestore.instance.collection("Feedback").doc(_notid).set({
                        'feedid':_notid, 'title':titleController.text,
                        'message':messageController.text,
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
    );
  }
}
