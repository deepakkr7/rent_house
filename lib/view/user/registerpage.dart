
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rent_house/view/common/loginpage.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  TextEditingController usernameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController passController=TextEditingController();
  TextEditingController confpassController=TextEditingController();
final _formkey=GlobalKey<FormState>();
  bool showpass=true;
  bool showpass1=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child:  Form(key: _formkey,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter a valid name";
                        }
                      },
                       controller:usernameController ,
                        keyboardType: TextInputType.name,
                      decoration: InputDecoration(hintText: "Name",icon: Icon(Icons.person,color: Colors.blue,) ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter a valid email";
                        }
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "Email",icon: Icon(Icons.email_outlined,color: Colors.blue,)),
                    ),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter a valid phone";
                        }
                      },
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(hintText: "Phone",icon: Icon(Icons.phone,color: Colors.blue,)),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      validator: (value){
                        if(value!.length<=5){
                          return "Password requires minimum 5 chracters";
                        }
                      },
                      controller: passController,
                      obscureText: showpass,
                      obscuringCharacter: "*",
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(hintText: "Password",icon: Icon(Icons.password_sharp,color: Colors.blue,),
                        suffixIcon: IconButton(onPressed: (){
                          if(showpass==true)
                            {
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
                         : Icon(Icons.visibility)
                        )
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      validator: (value){
                        if(value!=passController.text){
                          return "Password doesnot match";
                        }
                      },
                      obscureText: showpass1,
                      obscuringCharacter: "*",
                      controller: confpassController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(hintText: "ConfirmPassword",icon: Icon(Icons.password_sharp,color: Colors.blue,),
                        suffixIcon: IconButton(onPressed: (){
                          if(showpass1==true){
                            setState(() {
                              showpass1=false;
                            });
                          }else{
                            setState(() {
                              showpass1=true;
                            });
                          }
                        },icon: showpass1==true?
                            Icon(Icons.visibility_off) :
                            Icon(Icons.visibility)
                        )

                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: InkWell(
                        onTap: (){
                          if(_formkey.currentState!.validate()){
                            FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: emailController.text.trim(), password: passController.text.trim()).then((value){
                                  FirebaseFirestore.instance.collection('user').doc(value.user!.uid).set(
                                    {
                                      'id':value.user!.uid,
                                      'email':value.user!.email,
                                      'name':usernameController.text,
                                      'phone':phoneController.text,
                                      'password':passController.text,
                                      'confirmpassword':confpassController.text,
                                      'create_at':DateTime.now(),
                                      'status':1,
                                      'usertype':"user"
                                    }).then((value){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account Created",style:TextStyle(color: Colors.blueGrey),)));
                                  });
                            } );
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent
                          ),
                          child:Center(
                            child:Text("Register",style: TextStyle(color: Colors.black),) ,
                          )
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        Text("Already have an account?",style: TextStyle(color: Colors.black),),
                        SizedBox(width: 5,),
                        InkWell(onTap: (){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
                        },
                            child: Text("Log in",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))
                      ],
                    )

                  ],


                ),
              ),
            ),
          ),

        ),
      ),
    );
  }
}
