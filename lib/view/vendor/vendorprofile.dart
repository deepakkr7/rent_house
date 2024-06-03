import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VendorProfile extends StatefulWidget {
  var imgurl;
  var name;
  var email;
  var phone;
  var place;
  var  id;
   VendorProfile({super.key,this.imgurl,
   this.name,this.email,this.place,this.phone,this.id});

  @override
  State<VendorProfile> createState() => _VendorProfileState();
}

class _VendorProfileState extends State<VendorProfile> {
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController placeController=TextEditingController();
  final _formkey=GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker(); // For pick Image
  XFile? _image; // For accept Null:-?
  var imageurl;

  initState() {
    nameController.text = widget.name;
    placeController.text = widget.place;
    phoneController.text = widget.phone;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey,
        title: Text("Edit/Update Profile"),
      ),
      body: Container(height: double.infinity,
      width: double.infinity,
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                   "Add Images:",style: TextStyle(fontSize: 20,),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    onTap: () {
                      showimage();
                    },
                    child: Container(
                      height: 250,
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
                              backgroundImage: NetworkImage(
                                  widget.imgurl.toString()),
                              backgroundColor: Colors.transparent,
                            ),
                            Icon(
                              Icons.upload_file,
                              size: 40,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: nameController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter a Valid name";
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white,width: 2,
                      ),
                    ),
                    hintText: "Name",
                    hintStyle: TextStyle(color:Colors.black54),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: phoneController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter a Valid phone";
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white,width: 2,
                      ),
                    ),
                    hintText: "Phone",
                    hintStyle: TextStyle(color:Colors.black54),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: placeController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter a Valid place";
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white,width: 2,
                      ),
                    ),
                    hintText: "Place",
                    hintStyle: TextStyle(color:Colors.black54),
                  ),
                ),
                SizedBox(height: 30,),
                Center(
                  child: InkWell(onTap: (){
                   if (_formkey.currentState!.validate()) {
    String fileName = DateTime.now().toString();
    var ref = FirebaseStorage.instance.ref().child("profile/$fileName");
    UploadTask uploadTask =
    ref.putFile(File(_image!.path));

    uploadTask.then((res) async {
    imageurl = (await ref.getDownloadURL()).toString();
    }).then((value){
    FirebaseFirestore.instance.collection('user').doc(widget.id).update({
    'name':nameController.text,
    'place':placeController.text,
    'phone':phoneController.text,
    });
    }).then((value) =>Navigator.pop(context));
    }},
                  child: Container(
                    height: 45,
                    width: 150,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blueGrey),
                    child: Center(child:
                      Text("Update"),),
                  ),
                  ),
                )
              ],
            ),
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

