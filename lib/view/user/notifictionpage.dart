import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});
  @override
  State<Notifications> createState() => _NotificationsState();
}
class _NotificationsState extends State<Notifications> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NOTIFICATIONS"),
      ),
      body: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Notification").
        where('category',isEqualTo: 'User').snapshots(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                          return ListTile(
                            title: Text(snapshot.data!.docs[index]['title']),
                            subtitle: Text(snapshot.data!.docs[index]['description']),
                          );
                        });

                  }return Center(child: CircularProgressIndicator(),);

                })
    );
  }
}
