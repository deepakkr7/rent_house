

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServiceDetails extends StatefulWidget {
  String ?id;
  String? title;
  String? description;
  String?BedRooms;
  String?BathRooms;
  String?price;
  String? servicemanagerid;
  ServiceDetails({super.key,
    this.id,this.title,this.description,this.servicemanagerid,this.BathRooms,this.BedRooms,this.price
  });

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  TextEditingController serviceController=TextEditingController();
  TextEditingController servicedetailsController=TextEditingController();
  TextEditingController specificationController=TextEditingController();
  TextEditingController specification1Controller=TextEditingController();
  TextEditingController priceController=TextEditingController();
  @override
  initState(){
    servicedetailsController.text=widget.description.toString();
    specificationController.text=widget.BedRooms.toString();
    specification1Controller.text=widget.BathRooms.toString();
    priceController.text=widget.price.toString();
    serviceController.text=widget.title.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Details",style: TextStyle(fontSize: 20),),backgroundColor: Colors.blueGrey,),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Service Details",style: TextStyle(fontSize: 20),),
            SizedBox(height: 20,),
            TextFormField(
              controller: serviceController,
              decoration: InputDecoration(hintText: "Service",),
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: specificationController,
              decoration: InputDecoration(hintText: "BedRooms",),
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: specification1Controller,
              decoration: InputDecoration(hintText: "BathRooms",),
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: servicedetailsController,
            decoration: InputDecoration(hintText: "Description"),
            ),SizedBox(height: 15,),
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Price"),
            ),
            SizedBox(height: 20,),
            InkWell(onTap: (){
              FirebaseFirestore.instance.collection('vendorservice').doc(widget.id.toString()).update({
                'title':serviceController.text,
                'BedRooms':specificationController.text,
                'BathRooms':specification1Controller.text,
                'description':servicedetailsController.text,
                'Price':priceController.text
              }).then((value) => Navigator.pop(context));
            },
              child: Center(
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blueGrey)  ,
                  child: Center(
                    child: Text(
                      "Update"
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
