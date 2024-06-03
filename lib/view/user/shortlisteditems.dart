import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShortlistedItem extends StatefulWidget {
  const ShortlistedItem({super.key});

  @override
  State<ShortlistedItem> createState() => _ShortlistedItemState();
}

class _ShortlistedItemState extends State<ShortlistedItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
    stream: FirebaseFirestore.instance.collection('shortlisted').where('isshortlisted',isEqualTo: true).snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) {
    return Center(child: CircularProgressIndicator());
    }
    final favorites = snapshot.data!.docs;
    return ListView.builder(
    itemCount: favorites.length,
    itemBuilder: (context, index) {
    var favorite = favorites[index];
    return Card(
    child: ListTile(
    leading: Image.network(favorite['imgurl']),
    title: Text('Item ${index + 1}'),
    trailing: Icon(
    favorite['isshortlisted'] ? Icons.bookmark_outline : Icons.bookmark_outline,
    color: favorite['isshortlisted'] ? Colors.red : Colors.grey,
    ),
    ),
    );
    },
    );
    },
    ),
    );
  }
}
