import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPropertyScreen extends StatefulWidget {
  var id;
  var title;
  AddPropertyScreen({super.key, this.id, this.title});
  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  String?_category;
  List<String>categories=[
    "Houses",
    "Apartments",
    "Villa",
    "Flat",
    "Rent Rooms",
  ];
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _bathroomsController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print('Image selected: ${_image!.path}');
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _uploadData() async {
    if (_formKey.currentState!.validate() && _image != null) {
      try {
        // Upload image to Firebase Storage
        String fileName = _image!.path.split('/').last;
        Reference storageReference =
        FirebaseStorage.instance.ref().child('properties/$fileName');
        UploadTask uploadTask = storageReference.putFile(_image!);
        await uploadTask.whenComplete(() => null);
        String imageUrl = await storageReference.getDownloadURL();

        // Save data to Firestore
        await FirebaseFirestore.instance.collection('properties').add({
          'name': _nameController.text,
          'price': int.parse(_priceController.text),
          'bedrooms': int.parse(_bedroomsController.text),
          'bathrooms': int.parse(_bathroomsController.text),
          'imageUrl': imageUrl,
          'title':_category
        });

        // Clear form
        _nameController.clear();
        _priceController.clear();
        _bedroomsController.clear();
        _bathroomsController.clear();
        setState(() {
          _image = null; // Resetting the image state
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Property added successfully')));
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add property: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please complete all fields and select an image')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
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
                ),SizedBox(height: 20,),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Property Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the property name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bedroomsController,
                  decoration: InputDecoration(labelText: 'Bedrooms'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the number of bedrooms';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bathroomsController,
                  decoration: InputDecoration(labelText: 'Bathrooms'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the number of bathrooms';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _image == null
                    ? Text('No image selected.')
                    : Image.file(_image!, height: 150, width: 150),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Select Image'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _uploadData,
                  child: Text('Upload Property'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


