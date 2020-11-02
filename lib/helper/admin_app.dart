import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/store_provider.dart';
import 'package:shop_app/screens/adminpanel/home.dart';

class Admin_App extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    getdata(context);
    return MaterialApp(
      title: "Clothes-App",
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Material(
          child: Admin_Home(),
        ),
      ),
    );
  }
  getdata(BuildContext context){
    var user = FirebaseAuth.instance.currentUser;

    final data=Provider.of<Store_Provider>(context);
    if (user!=null) {
      data.getuser(user.email);
    }
  }
}
