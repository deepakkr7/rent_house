
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewALlVendors extends StatefulWidget {
  const ViewALlVendors({super.key});

  @override
  State<ViewALlVendors> createState() => _ViewALlVendorsState();
}

class _ViewALlVendorsState extends State<ViewALlVendors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Text("View All Vendors",style: TextStyle(fontSize: 24),) ,
            SizedBox(height: 20,),
            Expanded(child: StreamBuilder<QuerySnapshot>(
              stream:FirebaseFirestore.instance.collection('user').where('usertype',isEqualTo: 'vendor').snapshots(),
              builder: (context,snapshot){
                if(snapshot.hasError){
                  return Center(child: CircularProgressIndicator());
                }
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                      itemBuilder:(context, index){
                      return Card(
                        elevation: 5.0,
                        child: Container(
                          height: 100,
                          child: Center(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Center(
                                  child: Text((index+1).toString()),
                                ),
                              ),
                              trailing: IconButton(onPressed:(){ showDialog(context: context,builder: (context){
                                return AlertDialog(
                                  content: Container(
                                    height: 250,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Details",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 10,),
                                        Text(snapshot.data!.docs[index]['vendorname'],style: TextStyle(fontSize: 18),),
                                        Text(snapshot.data!.docs[index]['place'],style: TextStyle(fontSize: 16),),
                                        Text(snapshot.data!.docs[index]['email'],style: TextStyle(fontSize: 16),),
                                        Text(snapshot.data!.docs[index]['phone'],style: TextStyle(fontSize: 16),),
                                        SizedBox(height: 20,),
                                        snapshot.data!.docs[index]['status']==0?InkWell(
                                          onTap: (){
                                            FirebaseFirestore.instance.collection('user').doc(snapshot.data!.docs[index]['id']).update({
                                              'status':1
                                            }).then((value) {
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Approved")));
                                              Navigator.pop(context);
                                            });
                                          },
                                          child:Container(
                                            height: 45,
                                            width:250,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blueGrey),
                                            child: Center(
                                              child: Text("Approve"),
                                            ),
                                          ) ,
                                        ):

                                        InkWell(
                                          onTap: (){
                                            FirebaseFirestore.instance.collection('user').doc(snapshot.data!.docs[index]['id']).update({
                                              'status':0
                                            }).then((value){
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Removed")));
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Container(
                                              height: 45,
                                              width: 250,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blueGrey),
                                              child: Center(child: Text("Remove"),)
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                );
                              });
                              },
                                icon:Icon(Icons.arrow_forward_ios) ,
                              ),
                              title: Text(snapshot.data!.docs[index]['vendorname'],style: TextStyle(fontSize: 18),),
                              subtitle: Text(snapshot.data!.docs[index]['place'],style: TextStyle(fontSize: 16),),
                            ),
                          ),
                        ),
                      );
                      } );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },

            )

            ),


          ],
        ),
      ),
    );
  }
}
