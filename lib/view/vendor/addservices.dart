import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
class AddServices extends StatefulWidget {
  var email;
  var vendorname;
  var place;
  var phone;
  var id;
  AddServices({super.key,
  this.email,this.vendorname,this.phone,this.place,this.id});

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  String?_category;
  List<String>categories=[
    "Houses",
    "Apartments",
    "Villa",
    "Flat",
    "Rent Rooms",
  ];
  TextEditingController serviceController=TextEditingController();
  TextEditingController servicedetailsController=TextEditingController();
  TextEditingController specificationController=TextEditingController();
  TextEditingController specification1Controller=TextEditingController();
  TextEditingController priceController=TextEditingController();
  final ImagePicker _picker = ImagePicker(); // For pick Image
  XFile? _image; // For accept Null:-?
  var imageurl;
  var uuid = Uuid();

  var serviceid;
  initState() {
    serviceid = uuid.v1();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:Colors.blueGrey ,),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(items: categories.map((String category){
                return new DropdownMenuItem<String>(value: category,
                    child: Row(
                      children:<Widget> [
                        Text(category)

                      ],
                    ));

              }).toList(),
                  onChanged: (String ?value){
                setState(()=> _category=value);
                },
    value: _category,
                decoration: InputDecoration(hintText: "Services"),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: specificationController,
                decoration: InputDecoration(hintText: "BedRooms"),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: specification1Controller,
                decoration: InputDecoration(hintText: "BathRooms"),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: servicedetailsController,
                decoration: InputDecoration(hintText: "Description"),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText:"Price"),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    showimage();
                  },
                  child: Container(
                    width: 250,
                    color: Colors.transparent,
                    child: _image != null
                        ? ClipRRect(
                        child: Image.file(
                          File(_image!.path),
                          fit: BoxFit.cover,
                        ))
                        : Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 100.0,
                            // backgroundImage: NetworkImage(widget.imgurl.toString()),
                            backgroundColor: Colors.transparent,
                          ),
                          Icon(
                            Icons.upload_file,
                            size: 40,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50,),
              InkWell(onTap: (){
                String fileName = DateTime.now().toString();
                var ref = FirebaseStorage.instance
                    .ref()
                    .child("service/$fileName");
                UploadTask uploadTask = ref.putFile(File(_image!.path));

                uploadTask.then((res) async {
                  imageurl = (await ref.getDownloadURL()).toString();
                }).then((value) {
                  FirebaseFirestore.instance.collection('vendorservice').doc(serviceid).set({
                    'id':serviceid,
                    'title':_category,
                    'description':servicedetailsController.text,
                    'BedRooms':specificationController.text,
                    'BathRooms':specification1Controller.text,
                    'Price':priceController.text,
                    'status':1,
                    'place':widget.place,
                    'phone':widget.phone,
                    'servicemanagerid':widget.id,
                    'vendorname':widget.vendorname,
                    'imgurl':imageurl
                  }).then((value){
                    setState(() {
                      serviceid=uuid.v1();
                    });
                  });

                } ).then((value){
                 Navigator.pop(context);
               });

              },
                child: Center(
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blueGrey),
                    child: Center(
                      child: Text("Add Services"),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

_imagefromgallery() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  setState(() {
    _image = image;
  });
}

_imagefromcamera() async {
  final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  setState(() {
    _image = photo;
  });
}

showimage() {
  showModalBottomSheet(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Ink(
                      decoration: ShapeDecoration(
                        color: Colors.pink,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _imagefromcamera();
                        },
                        icon: Icon(Icons.camera_alt_rounded,
                            color: Colors.white),
                        iconSize: 20,
                        splashRadius: 40,
                      ),
                    ),
                    Text("Camera"),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Ink(
                      decoration: ShapeDecoration(
                        color: Colors.purple,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _imagefromgallery();
                        },
                        icon: Icon(Icons.photo),
                        color: Colors.white,
                        iconSize: 20,
                        splashRadius: 40,
                      ),
                    ),
                    Text("Gallery"),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
}
