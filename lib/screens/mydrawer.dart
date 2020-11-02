import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helper/user_app.dart';
import 'package:shop_app/providers/store_provider.dart';
import 'package:shop_app/screens/adminpanel/admincat_screen.dart';
import 'package:shop_app/screens/adminpanel/home.dart';
import 'package:shop_app/screens/adminpanel/requests_users.dart';
import 'package:shop_app/screens/auth/login.dart';
import 'package:shop_app/screens/auth/register.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/screens/home.dart';
import 'package:shop_app/screens/requests_screen.dart';

import 'cat_screen.dart';


class MyDrawer extends StatelessWidget{
  var user=FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: (user!=null)?user_drawer(context):notuser_drawer(context),
    );
  }
  user_drawer(BuildContext context){
    final data = Provider.of<Store_Provider>(context,listen: true);
    if (data.user.admin == 1)
      //admin drawer
      return Column(
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Colors.deepPurple),

          accountName: Text(data.user.fullname+" -ADMIN",style: TextStyle(fontFamily: "SansitaSwashed"),),
          accountEmail: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.user.email),
              SizedBox(height: 10,),


            ],
          ),

        ),
        ListTile(leading: Icon(FontAwesomeIcons.home,color: Colors.black,),title: Text("Home Page",style: TextStyle(fontSize: 18),),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Home(),));
        },),
        ListTile(leading: Icon(Icons.category,color: Colors.black,),title: Text("Categories",style: TextStyle(fontSize: 18),),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AdminCat_Screen(),));

        },),
        ListTile(leading: Icon(FontAwesomeIcons.firstOrder,color: Colors.black,),title: Text("Requests",style: TextStyle(fontSize: 18),),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Requests_Users(),));

        },),
        ListTile(leading: Icon(FontAwesomeIcons.signOutAlt,color: Colors.red,), title: Text("SignOut",style: TextStyle(color: Colors.red),),onTap: (){
          data.emptyuser().then((value) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => User_App(),));

          });

        },)
      ],


    );



    //user drawer
    return Column(
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Colors.deepPurple),

          accountName: Text(data.user.fullname,style: TextStyle(fontFamily: "SansitaSwashed"),),
          accountEmail: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.user.email),
              SizedBox(height: 10,),

            ],
          ),

        ),
        ListTile(leading: Icon(FontAwesomeIcons.home,color: Colors.black,),title: Text("Home Page",style: TextStyle(fontSize: 18),),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home_Screen(),));
        },),
        ListTile(leading: Icon(Icons.category,color: Colors.black,),title: Text("Categories",style: TextStyle(fontSize: 18),),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Cat_Screen(),));

        },),
        ListTile(leading: Icon(FontAwesomeIcons.firstOrder,color: Colors.black,),title: Text("Requests",style: TextStyle(fontSize: 18),),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Requests_Screen(),));

        },),
        ListTile(leading: Icon(FontAwesomeIcons.signOutAlt,color: Colors.red,), title: Text("SignOut",style: TextStyle(color: Colors.red),),onTap: (){
          data.emptyuser().then((value) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => User_App(),));

          });

        },)


      ],
    );

  }
  notuser_drawer(BuildContext context){
    return Column(children: [

      UserAccountsDrawerHeader(
        accountEmail: Text(""),
        accountName: Text(""),decoration: BoxDecoration(color: Colors.deepPurple),),
      ListTile(leading: Icon(FontAwesomeIcons.home,color: Colors.black,),title: Text("Home"),onTap: (){
        Navigator.pop(context);
      },),
      ListTile(leading: Icon(FontAwesomeIcons.signInAlt,),title: Text("Login"),onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Screen(),));
      },),
      ListTile(leading: Icon(FontAwesomeIcons.userPlus,),title: Text("Register"),onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Register_Screen(),));
      },),

    ],);
  }
}
