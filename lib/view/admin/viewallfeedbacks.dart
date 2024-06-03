import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewAllFeedbacks extends StatefulWidget {
  const ViewAllFeedbacks({super.key});

  @override
  State<ViewAllFeedbacks> createState() => _ViewAllFeedbacksState();
}

class _ViewAllFeedbacksState extends State<ViewAllFeedbacks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FEEDBACKS"),
      ),
       body:
      // Container(
      //   height: double.infinity,
      //   width: double.infinity,
      //  child: Column(
      //    children: [
           StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection("Feedback").snapshots(),
               builder: (context,snapshot){
             if(snapshot.hasData){
               return ListView.builder(
                 itemCount: snapshot.data!.docs.length,
                   itemBuilder: (context,index){
                   return ListTile(
                     title: Text(snapshot.data!.docs[index]['title']),
                     subtitle: Text(snapshot.data!.docs[index]['message']),
                   );
                   });
             }return Center(child: CircularProgressIndicator(),);
               })
        // ],
      // ),
     // ),
    );
  }
}
