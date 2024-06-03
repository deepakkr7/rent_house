import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_house/view/user/contactdetails.dart';
import 'package:rent_house/view/user/housepage.dart';
import 'package:rent_house/view/user/userhomepage.dart';

class Detailspage extends StatefulWidget {
  String? title;
  String? id;
  String? servicemanagerid;
  String? vendorname;
  String? description;
  var phone;
  String? imgurl;
  String? customerphone;
  String? customerid;
  String? customername;
  String? place;
  var email;
  String?Bathrooms;
  String?Bedrooms;
  String?Price;
  Detailspage(
      {super.key,this.Bathrooms,this.Bedrooms,this.Price,
      this.email,
      this.title,
      this.id,
      this.phone,
      this.vendorname,
      this.imgurl,
      this.servicemanagerid,
      this.description,
      this.customerid,
      this.customername,
      this.customerphone,
      this.place});
  @override
  State<Detailspage> createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  bool isshortlisted = false;
  late String imgurl;
  void toggleshortlisted() async {
    setState(() {
      isshortlisted = !isshortlisted;
    });
    await FirebaseFirestore.instance.collection('shortlisted').add({
      'imgurl': imgurl,
      'isshortlisted': isshortlisted,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
    child: Column(
    children: [
    Stack(
    children: [
    Image.network(
    widget.imgurl.toString(),
    width: double.infinity,
    height: 200,
    fit: BoxFit.cover,
    ),
    // Positioned(
    // top: 10,
    // left: 10,
    // child: IconButton(
    // icon: Icon(Icons.arrow_back),
    // onPressed: () {
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHomePage()));
    // },
    // ),
    // ),
    Positioned(
    bottom: 10,
    right: 10,
    child: IconButton(
    icon: Icon(Icons.bookmark_border),
    onPressed: () {
    // Add bookmark logic here
      toggleshortlisted();
    },
    ),
    ),
    Positioned(
    bottom: 20,
    left: 20,
    child: Text(
    widget.title.toString(),
    style: TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    ],
    ),
    Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    Icon(Icons.location_on),
    SizedBox(width: 8),
    Text(widget.place.toString()),
    ],
    ),
    SizedBox(height: 16),
    Row(
    children: [
    Icon(Icons.bed),
    SizedBox(width: 8),
    Text(widget.Bedrooms.toString()),
    SizedBox(width: 16),
    Icon(Icons.bathtub),
    SizedBox(width: 8),
    Text(widget.Bathrooms.toString()),
    ],
    ),
    SizedBox(height: 16),
    Text(
    'Description',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 8),
    Text(widget.description.toString()),
    SizedBox(height: 16),
    Text(
    'Gallery',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 8),
    SizedBox(
    height: 100,
    // child: ListView(
    // scrollDirection: Axis.horizontal,
    // children: images.map((imageUrl) => buildGalleryImage(imageUrl)).toList(),
    // ),
    ),
    SizedBox(height: 8),
    Text(
    'Price',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    // SizedBox(height: 8),
    // Image.network(
    // data['map_image'],
    // ),
    SizedBox(height: 10),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    widget.Price.toString(),
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    ElevatedButton(
    onPressed: () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactDetails(
      phone: widget.phone,
      vendorname: widget.vendorname,
      email: widget.email,
    )));
    },
    child: Text('Contact Now'),
    ),
    ],
    ),
    ],
    ),
    ),
    ],
    ),
      )
    );
  }
}
      // Container(
      //   height: double.infinity,
      //   width: double.infinity,
      //   padding: EdgeInsets.all(20),
      //   child: ListView(
      //     children: [
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Container(
      //             color: Colors.green,
      //             height: 200,
      //             child: Stack(
      //               children: [
      //                 Container(
      //                     height: 200,
      //                     width: MediaQuery.of(context).size.width,
      //                     child: Image.network(
      //                       widget.imgurl.toString(),
      //                       fit: BoxFit.cover,
      //                     )),
      //                 // Positioned(
      //                 //   bottom: 20,
      //                 //   left: 20,
      //                 //   child: Row(
      //                 //     children: [
      //                 //       Icon(Icons.bed_outlined),
      //                 //       Text(),
      //                 //       SizedBox(
      //                 //         width: 80,
      //                 //       ),
      //                 //       Icon(Icons.bathtub_outlined),
      //                 //       Text(snapshot.data!.docs[index]['BathRooms'])
      //                 //     ],
      //                 //   ),
      //                 // )
      //
      //               ],
      //             ),
      //           ),
      //           //             Container(
      //           //               height: 250,
      //           //
      //           //               child:StreamBuilder<QuerySnapshot>(
      //           //                 stream: FirebaseFirestore.instance.collection('vendorservice').where('title',isEqualTo: 'Houses').snapshots(),
      //           //                 builder: (context,snapshot) {
      //           //                   if (snapshot.hasData && snapshot.data!.docs.length == 0) {
      //           //                     return Center(
      //           //                       child: CircularProgressIndicator(),
      //           //                     );
      //           //                   }
      //           //                   if (snapshot.hasData) {
      //           //                     return ListView.builder(
      //           //                         itemCount: snapshot.data!.docs.length,
      //           //                         itemBuilder: (context, index) {
      //           //                           return Card(
      //           //                             elevation: 5.0,
      //           //                             shape: RoundedRectangleBorder(
      //           //                                 borderRadius: BorderRadius.circular(15)),
      //           //                             child: Stack(
      //           //                               children: [
      //           //                                 ClipRRect(
      //           //                                   borderRadius: BorderRadius.circular(15),
      //           //                                   child: snapshot.data!
      //           //                                       .docs[index]['imgurl'] == null
      //           //                                       ? Image.asset(
      //           //                                     'assets/images/h1.jpg', fit: BoxFit.cover,
      //           //                                   ) : Image.network(
      //           //                                       snapshot.data!.docs[index]['imgurl'],
      //           //                                       fit: BoxFit.cover),
      //           //                                 ),
      //           //                                 Positioned(
      //           //                                   top: 10,
      //           //                                   left: 20,
      //           //                                   child: IconButton(
      //           //                                     icon: Icon(
      //           //                                         Icons.arrow_back_ios_new_outlined),
      //           //                                     onPressed: () {},
      //           //                                   ),
      //           //                                 ),
      //           //                                 Positioned(top: 10,right: 20,
      //           //                                     child: IconButton(icon: Icon(isshortlisted?Icons.bookmark_outline:Icons.bookmark_outline,
      //           //                                     color: isshortlisted?Colors.red:Colors.white,),onPressed: toggleshortlisted,)),
      //           //                                 Positioned(bottom: 20,left: 20,
      //           //                                   child: Row(
      //           //                                     children: [Icon(Icons.bed_outlined),
      //           //                                       Text(snapshot.data!.docs[index]['BedRooms']),
      //           //                                       SizedBox(width: 80,),
      //           //                                       Icon(Icons.bathtub_outlined),
      //           //                                       Text(snapshot.data!.docs[index]['BathRooms'])
      //           //                                     ],
      //           //                                   ),
      //           //                                 )
      //           //
      //           //                               ],
      //           //                             ),
      //           //                           );
      //           //                         }
      //           //
      //           //                     );
      //           //                   }return Center(child: CircularProgressIndicator(),);
      //           //                 })
      //           // ),
      //           Text(
      //             "Description",
      //             style: TextStyle(fontSize: 20),
      //           ),
      //           Container(
      //             height: 100,
      //             child: StreamBuilder<QuerySnapshot>(
      //               stream: FirebaseFirestore.instance
      //                   .collection('vendorservice')
      //                   .where('id', isEqualTo: widget.id)
      //                   .snapshots(),
      //               builder: (context, snapshot) {
      //                 if (snapshot.hasData && snapshot.data!.docs.length == 0) {
      //                   return Center(
      //                     child: CircularProgressIndicator(),
      //                   );
      //                 }
      //                 if (snapshot.hasData) {
      //                   return ListView.builder(
      //                       itemCount: snapshot.data!.docs.length,
      //                       itemBuilder: (context, index) {
      //                         return Text(
      //                             snapshot.data!.docs[index]["description"]);
      //                       });
      //                   // return ;
      //                 }
      //                 return Center(
      //                   child: CircularProgressIndicator(),
      //                 );
      //               },
      //             ),
      //           ),
      //           SizedBox(height: 10),
      //           Text(
      //             "Gallery",
      //             style: TextStyle(fontSize: 20),
      //           ),
      //           Container(
      //             height: 150,
      //             child: StreamBuilder<QuerySnapshot>(
      //                 stream: FirebaseFirestore.instance
      //                     .collection('images')
      //                     .where('title', isEqualTo: 'Houses')
      //                     .snapshots(),
      //                 builder: (context, snapshot) {
      //                   if (snapshot.hasData &&
      //                       snapshot.data!.docs.length == 0) {
      //                     return Center(
      //                       child: CircularProgressIndicator(),
      //                     );
      //                   }
      //                   if (snapshot.hasData) {
      //                     return GridView.builder(
      //                         gridDelegate:
      //                             SliverGridDelegateWithFixedCrossAxisCount(
      //                           crossAxisCount: 3,
      //                               childAspectRatio: 1,
      //                               mainAxisSpacing: 8.0,
      //                               crossAxisSpacing: 8.0,
      //                         ), itemCount: snapshot.data!.docs.length,
      //                       itemBuilder: (context, index) {
      //                         var imageUrl = snapshot.data!.docs[index]['imageUrl'];
      //                         return ClipRRect(
      //                           borderRadius: BorderRadius.circular(8.0),
      //                           child: Image.network(
      //                             imageUrl,
      //                             fit: BoxFit.cover,
      //                             width: double.infinity,
      //                             height: double.infinity,
      //                           ),
      //                         );
      //                       },
      //                         // itemCount: snapshot.data!.docs.length,
      //                         // itemBuilder: (context, index) {
      //                         //   return Card(
      //                         //     elevation: 5.0,
      //                         //     child: Stack(
      //                         //       children: [
      //                         //         ClipRRect(
      //                         //           borderRadius: BorderRadius.circular(15),
      //                         //           child: snapshot.data!.docs[index]
      //                         //                       ['imageUrl'] ==
      //                         //                   null
      //                         //               ? Image.asset(
      //                         //                   'assets/images/h1.jpg',
      //                         //                   fit: BoxFit.cover,
      //                         //                 )
      //                         //               : Image.network(
      //                         //                   snapshot.data!.docs[index]
      //                         //                       ['imageUrl'],
      //                         //                   fit: BoxFit.cover),
      //                         //         ),
      //                         //       ],
      //                         //     ),
      //                         //   );
      //                         // }
      //                         );
      //                   }
      //                   return Center(
      //                     child: CircularProgressIndicator(),
      //                   );
      //                 }),
      //           ),
      //           SizedBox(
      //             height: 10,
      //           ),
      //           Text(
      //             "Price",
      //             style: TextStyle(fontSize: 20),
      //           ),
      //           Container(
      //             height: 200,
      //             child: StreamBuilder<QuerySnapshot>(
      //               stream: FirebaseFirestore.instance
      //                   .collection("vendorservice")
      //                   .where("id", isEqualTo: widget.id)
      //                   .snapshots(),
      //               builder: (context, snapshot) {
      //                 if (snapshot.hasData && snapshot.data!.docs.length == 0) {
      //                   return Center(
      //                     child: CircularProgressIndicator(),
      //                   );
      //                 }
      //                 if (snapshot.hasData) {
      //                   return ListView.builder(
      //                     itemCount: snapshot.data!.docs.length,
      //                     itemBuilder: (context, index) {
      //                       return Row(
      //                         children: [
      //                           Text(snapshot.data!.docs[index]["Price"]),
      //                           SizedBox(
      //                             width: 60,
      //                           ),
      //                           InkWell(
      //                             onTap: () {
      //                               Navigator.push(
      //                                   context,
      //                                   MaterialPageRoute(
      //                                       builder: (context) =>
      //                                           ContactDetails(
      //                                             vendorname: widget.vendorname,
      //                                             email: widget.email,
      //                                             id: widget.id,
      //                                             phone: widget.phone,
      //                                           )));
      //                             },
      //                             child: Container(
      //                               height: 45,
      //                               width: 200,
      //                               decoration: BoxDecoration(
      //                                   borderRadius: BorderRadius.circular(20),
      //                                   color: Colors.blueGrey),
      //                               child: Center(
      //                                 child: Text("Contact Now"),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       );
      //                     },
      //                   );
      //                 }
      //                 return Center(
      //                   child: CircularProgressIndicator(),
      //                 );
      //               },
      //             ),
      //           )
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
