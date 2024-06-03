import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorNotification extends StatefulWidget {
  const VendorNotification({super.key});
  @override
  State<VendorNotification> createState() => _VendorNotificationState();
}
class _VendorNotificationState extends State<VendorNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NOTIFICATION"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Notification").
          where('category',isEqualTo: 'Vendor').snapshots(),
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
