import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_house/view/user/contactdetails.dart';
import 'package:rent_house/view/user/housepage.dart';
import 'package:rent_house/view/user/userhomepage.dart';


class VillaDetails extends StatefulWidget {
  String?title;
  String?id;
  String?servicemanagerid;
  String?vendorname;
  String?description;
  String?phone;
  String?imgurl;
  String?customerphone;
  String?customerid;
  String?customername;
  String?place;
  String?Bedrooms;
  String?Bathrooms;
  String?Price;
  VillaDetails({super.key,this.Bathrooms,this.Bedrooms,this.Price,
    this.title,this.id,this.phone,this.vendorname,this.imgurl,this.servicemanagerid,this.description,this.customerid,
    this.customername,this.customerphone,this.place});
  @override
  State<VillaDetails> createState() => _VillaDetailsState();
}
class _VillaDetailsState extends State<VillaDetails> {
  bool  isshortlisted=false;
  void toggleshortlisted() async{
    setState(() {
      isshortlisted=!isshortlisted;
    });
    await FirebaseFirestore.instance.collection('shortlisted').add({
      //'imgurl':,
      'isshortlisted':isshortlisted,
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
                          // Add contact logic here
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
