import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ContactDetails extends StatefulWidget {
  var vendorname;
  var email;
  var id;
  var phone;
   ContactDetails({this.phone,this.id,this.email,this.vendorname,super.key});

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Details"),
      ),
      body:Container(padding: EdgeInsets.all(20),
                height: 200,
                child: Card(
                  elevation: 5.0,
                  child: ListTile(
                    title: Column(
                      children: [
                        Text(widget.vendorname.toString()),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  UrlLauncher.launch(
                                      'tel:+${widget.phone.toString()}');
                                },
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.green,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Text(widget.phone.toString())
                          ],
                        ),SizedBox(height: 10,),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.email,
                                  color: Colors.green,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Text(widget.email.toString())
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
    );
  }
}
