import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/modules/users_request_module.dart';
import 'package:shop_app/providers/store_provider.dart';
import 'package:shop_app/screens/adminpanel/requests_view_screen.dart';
import 'package:shop_app/screens/mydrawer.dart';

class Requests_Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Store_Provider>(context);
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Requests",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontFamily: "DancingScript",
            fontSize: 38,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
          child: FutureBuilder(
        future: data.get_requests_users(),
        builder: (context, snapshot) {
          //var data=List<User_Request_Module> ();
          List<User_Request_Module> data = snapshot.data;
          while (data==null) {
            return Container(
              child: Center(
                child: Text("No Data To Show "),
              ),
            );
          }
         // print(data[0].email);




          return GridView.builder(
            padding: EdgeInsets.only(top: 20,bottom: 10,right: 5,left: 5),
            itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .9,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0),
            itemBuilder: (context, index) {
              return _drawcard(data[index],context);
            },
          );
        },
      )),
    );
  }
  _drawcard(User_Request_Module request,BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Requests_View_Screen(request.email),));
      },
      child: Card(
        color: Colors.deepPurple,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Hero(
                tag: request.email,
                child: Text(
                  request.email,
                  maxLines: 2,
                  style: TextStyle(

                      height: 1,
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "SansitaSwashed"),
                ),
              ),
              Text(
                request.lenth.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: "SansitaSwashed"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
