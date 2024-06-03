
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rent_house/view/admin/adminhomepage.dart';
import 'package:rent_house/view/user/registerpage.dart';
import 'package:rent_house/view/user/userhomepage.dart';
import 'package:rent_house/view/vendor/vendorhomepg.dart';
import 'package:rent_house/view/vendor/vendorregister.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formkey=GlobalKey<FormState>();
  bool  showpass=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child:Form(key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value){
                  if(value!.isEmpty){
                    return  "Enter a valid email";
                  }
                },
                controller: usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,width: 2,
                    ),
                  ),focusedBorder: OutlineInputBorder(
                  borderSide:BorderSide(color: Colors.white54,width: 2
                ),
                ),hintText: "Email",icon: Icon(Icons.email_outlined,color: Colors.blue,),
                  hintStyle: TextStyle(color: Colors.blueGrey),
              ),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value){
                  if(value!.isEmpty&&value!.length<=5){
                    return  "Enter a valid password";
                  }
                },
                controller: passwordController,
              obscureText: showpass,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54,width:2),
                ),hintText: "Password",icon: Icon(Icons.password_sharp,color: Colors.blue,),
                hintStyle: TextStyle(color: Colors.blueGrey),
                suffixIcon: IconButton(onPressed: (){
                  if(showpass==true){
                    setState(() {
                      showpass=false;
                    });
                  }else{
                    setState(() {
                      showpass=true;
                    });
                  }
                },icon: showpass==true?
                Icon(Icons.visibility_off)
                    :Icon(Icons.visibility),

                )
              ),),
              SizedBox(height: 20,),
              Center(
                child: InkWell(onTap: (){
                  if (_formkey.currentState?.validate() ?? false) {
                    if (usernameController.text == "admin@gmail.com" &&
                        passwordController.text == "admin12") {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => AdminHomepg()),
                            (route) => false,
                      );
                    } else {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: usernameController.text,
                        password: passwordController.text,
                      )
                          .then((userCredential) {
                        FirebaseFirestore.instance
                            .collection('user')
                            .doc(userCredential.user!.uid)
                            .get()
                            .then((value) {
                          if (value.exists) {
                            var userData = value.data();
                            if (userData!['usertype'] == 'user') {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => UserHomePage(
                                  name: value.data()!['name'],
                                  email: value.data()!['email'],
                                  id: value.data()!['id'],
                                  phone: value.data()!['phone'],
                                )),
                                    (route) => false,
                              );
                            } else if (userData['usertype'] == 'vendor' &&
                                userData['status'] == 1) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => VendorHome(
                                  email:value.data()!['email'],
                                  vendorname: value.data()!['vendorname'],
                                  phone: value.data()!['phone'],
                                  place: value.data()!['place'],
                                  id: value.data()!['id'],

                                )),
                                    (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Waiting for admin approval"),
                                  backgroundColor: Colors.blueGrey,
                                ),
                              );
                            }
                          } else {
                            // Handle case where user document does not exist
                            print("User document does not exist");
                          }
                        }).catchError((error) {
                          // Handle Firestore errors
                          print("Firestore Error: $error");
                        });
                      }).catchError((error) {
                        // Handle FirebaseAuth errors
                        print("FirebaseAuth Error: $error");
                      });
                    }
                  }


                },
                  child: Container(
                    height: 45,
                    width: 200,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blue),
                    child: Center(
                      child:Text("login") ,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("Don't have an account?",style: TextStyle(color: Colors.black),),
                  SizedBox(width: 5,),
                  Container(
                    child: InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: Text("Sign Up"),
                            content: Container(
                              child: Text("Are You a Vendor/User?"),
                            ),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>RegPage()), (route) => false);
                              }, child:Text("User")),
                              TextButton(onPressed: (){
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>VendorRegister()), (route) => false);
                              }, child: Text("Vendor"))
                            ],
                          );
                        });
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>RegPage()));
                      },
                      child:  Text("Sign Up",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                    ),
                  ),


                ],
              ),


            ],
          ),
        ) ,

      ),
    );
  }
}
