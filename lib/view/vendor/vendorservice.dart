import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_house/view/vendor/addservices.dart';
import 'package:rent_house/view/vendor/servicedetails.dart';
import 'package:uuid/uuid.dart';
class VendorService extends StatefulWidget {
  var vendorname;
  var email;
  var phone;
  var place;
  var id;
  VendorService({super.key,
  this.vendorname,this.email,this.phone,this.place,this.id
  });

  @override
  State<VendorService> createState() => _VendorServiceState();
}

class _VendorServiceState extends State<VendorService> {
  String?_category;
  List<String> categories = [ "Houses",
    "Apartments",
    "Villa",
    "Flat",
    "Rent Rooms",
  ];
  TextEditingController serviceController = TextEditingController();
  TextEditingController servicedetailsController = TextEditingController();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              AddServices(
                id: widget.id,
               vendorname: widget.vendorname,
                email: widget.email,
                place: widget.place,
                phone: widget.phone,
              )));
        },
        child: Icon(Icons.add),
      ), appBar: AppBar(backgroundColor: Colors.blueGrey,),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("View All Services", style: TextStyle(fontSize: 24),),
              SizedBox(height: 20,),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.80,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('vendorservice')
                      .where('servicemanagerid', isEqualTo: widget.id)
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5.0,
                            child: Container(
                              height: 100,
                              child: Center(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Center(
                                      child: Text((index + 1).toString()),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              ServiceDetails(
                                                id: snapshot.data!
                                                    .docs[index]['id'],
                                                title: snapshot.data!
                                                    .docs[index]['title'],
                                                BedRooms:snapshot.data!.docs[index]['BedRooms'],
                                                BathRooms: snapshot.data!.docs[index]['BathRooms'],
                                                description: snapshot.data!.docs[index]['description'],
                                                price: snapshot.data!.docs[index]['Price'],
                                                servicemanagerid: snapshot.data!.docs[index]['servicemanagerid'],
                                              )));
                                    },
                                    icon: Icon(Icons.arrow_forward_ios),
                                  ),
                                  title: Text(
                                    snapshot.data!.docs[index]['title'],
                                    style: TextStyle(fontSize: 18),),
                                  subtitle: Text(
                                    snapshot.data!.docs[index]['description'],
                                    style: TextStyle(fontSize: 16),),

                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    if (snapshot.hasData && snapshot.data!.docs.length == 0) {
                      return Center(
                        child: Text("No Data"),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              )


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
