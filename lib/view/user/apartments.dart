import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_house/view/user/apartmentdetails.dart';
import 'package:rent_house/view/user/detailspage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApartmentsPage extends StatefulWidget {
  var  name;
  var email;
  var phone;
  var id;
  var price;
  var bedrooms;
  var bathrooms;
  var description;
  String?imgurl_pref;
   ApartmentsPage({this.description,this.price,this.bedrooms,this.bathrooms,
     this.email,this.imgurl_pref,this.id,this.name,this.phone,super.key});

  @override
  State<ApartmentsPage> createState() => _ApartmentsPageState();
}

class _ApartmentsPageState extends State<ApartmentsPage> {
  var imgurl;
  getdata() async{
    SharedPreferences _pref=await SharedPreferences.getInstance();
    setState((){
      imgurl=_pref.getString('img');
    });
    print(imgurl);
  }
  @override
  iniState(){
    imgurl=widget.imgurl_pref;
    print(widget.imgurl_pref);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment:MainAxisAlignment.start ,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text("For You"),
                  ],
                ),SizedBox(height: 15,),
                Container(
                  height: 300,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('vendorservice').where('title',isEqualTo: 'Apartments').snapshots(),
                    builder: (context,snapshot){
                      if(snapshot.hasData&&snapshot.data!.docs.length==0){
                        return Center(
                          child:CircularProgressIndicator(),
                        );
                      }
                      if(snapshot.hasData){
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder:(context,index){
                              return Padding(padding: EdgeInsets.all(8),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ApartDetails(
                                      vendorname: snapshot.data!.docs[index]['vendorname'],
                                      id: snapshot.data!.docs[index]['id'],
                                      title: snapshot.data!.docs[index]['title'],
                                      description: snapshot.data!.docs[index]['description'],
                                      phone: snapshot.data!.docs[index]['phone'],
                                      place: snapshot.data!.docs[index]['place'],
                                      Bedrooms: snapshot.data!.docs[index]['BedRooms'],
                                      Bathrooms: snapshot.data!.docs[index]['BathRooms'],
                                      Price: snapshot.data!.docs[index]['Price'],
                                      customerid: widget.id,
                                      customerphone: widget.phone,
                                      customername: widget.name,
                                      servicemanagerid: snapshot.data!.docs[index]['servicemanagerid'],
                                      imgurl: snapshot.data!.docs[index]['imgurl'],
                                    )));
                                  },
                                  child:   Card(
                                    elevation: 5.0,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 280,
                                          width: 250,
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 200,
                                                width: 250,
                                                child: snapshot.data!
                                                    .docs[index]
                                                ['imgurl'] ==
                                                    null
                                                    ? Image.asset(
                                                  'assets/images/h1.jpg',
                                                  fit: BoxFit.cover,
                                                )
                                                    : Image.network(
                                                    snapshot.data!
                                                        .docs[index]
                                                    ['imgurl'],
                                                    fit: BoxFit.cover),

                                              ),Container(
                                                height: 60,
                                                width: size.width,
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.only(left: 10),
                                                        width: 150,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(snapshot.data!.docs[index]['title'],style: TextStyle(fontSize: 20),),
                                                            Text(snapshot.data!.docs[index]['place'],style: TextStyle(fontSize: 16),)
                                                          ],
                                                        ),
                                                      ),

                                                    ]

                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],


                                    ),
                                  ),

                                ),
                              );
                            } );
                      }return Center(child: CircularProgressIndicator(),);
                    },
                  ),

                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Best For You") ,

                  ],
                ),
                SizedBox(height: 15,),
                Container(
                    height: 200,
                    width: 400,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('properties').where('title',isEqualTo: 'Apartments').snapshots(),
                        builder: (context,snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if(snapshot.hasData){
                            return ListView.builder(scrollDirection: Axis.vertical,
                                //physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context,index){
                                  var property=snapshot.data!.docs[index];
                                  return Card(
                                      margin: EdgeInsets.all(8.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(8.0),
                                              child: Image.network(
                                                property['imageUrl'],
                                                height: 80,
                                                width: 80,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(width: 10.0),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    property['name'],
                                                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'Rp. ${property['price']} / Year',
                                                    style: TextStyle(color: Colors.green, fontSize: 16.0),
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.bed, size: 16.0),
                                                      SizedBox(width: 4.0),
                                                      Text('${property['bedrooms']} Bedroom'),
                                                      SizedBox(width: 20.0),
                                                      Icon(Icons.bathtub, size: 16.0),
                                                      SizedBox(width: 4.0),
                                                      Text('${property['bathrooms']} Bathroom'),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                                  //   ListTile(
                                  //   leading: Card(
                                  //     elevation: 5.0,
                                  //     child: Image.network(
                                  //       snapshot.data!.docs[index]['imageUrl'],
                                  //       fit: BoxFit.contain,
                                  //     ),
                                  //   ),
                                  //
                                  // );
                                  //     Padding(padding:EdgeInsets.only(right: 8),
                                  //         child: Card(
                                  //           elevation: 5.0,
                                  //           child: Stack(
                                  //             children: [
                                  //               Container(
                                  //                 height: 200,
                                  //                 width: 200,
                                  //                 child: Row(
                                  //                   children: [
                                  //                     Positioned.fill(
                                  //                       child: Container(
                                  //                         height: 150,
                                  //                         width:150,
                                  //                         child:  snapshot.data!
                                  //                       .docs[index]
                                  //                       ['imageUrl'] ==
                                  //                       null
                                  //                       ? Image.asset(
                                  //                         'assets/images/h1.jpg',
                                  //                         fit: BoxFit.fitHeight,
                                  //                       )
                                  //                         : Image.network(
                                  //           snapshot.data!
                                  //               .docs[index]
                                  //               ['imageUrl'],
                                  //               fit: BoxFit.contain),
                                  //                       ),
                                  //                     ),
                                  //                     SizedBox(width: 20,),
                                  //                     Container(
                                  //                       height: 50,
                                  //                       child: Column(
                                  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //                         crossAxisAlignment: CrossAxisAlignment.center,
                                  //                         children: [
                                  //                           Row(
                                  //                             mainAxisAlignment: MainAxisAlignment.center,
                                  //                             crossAxisAlignment: CrossAxisAlignment.start,
                                  //                             children: [
                                  //                               Text("hai"),
                                  //                             ],
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 ))]))
                                  // );
                                }
                            );

                          }return Center(
                            child: CircularProgressIndicator(),
                          );
                        })

                ),




      ]),
      ))
    ));
  }
}
