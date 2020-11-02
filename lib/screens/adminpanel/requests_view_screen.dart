import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/modules/item_module.dart';
import 'package:shop_app/modules/my_orders.dart';
import 'package:shop_app/providers/store_provider.dart';

class Requests_View_Screen extends StatelessWidget {
  String email;


  Requests_View_Screen(this.email);

  @override
  Widget build(BuildContext context) {
    final data=Provider.of<Store_Provider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Hero(
          tag: email,
          child: Text(
            email,style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: "SansitaSwashed",
              fontSize: 28,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder(

          future: data.get_requests_by_user(email),
          builder: (context, snapshot) {
            List<Item_Module> data0=snapshot.data;
            while(data0==null){
              return Container(
                child: Center(
                  child: Text("No Data To Show "),

                ),
              );
            }

            return Container(
            //  margin: EdgeInsets.only(top: 20,),
              width: double.infinity,
              child: Column(

                children: [
                  Text(data0.length.toString()+"  Items"
                  ,style:TextStyle(fontFamily: "SansitaSwashed",fontSize: 25,letterSpacing: 2.5)
                      ),
                  Expanded(
                    child: ListView.builder(itemCount: data0.length,itemBuilder: (context, index) {
                      return _drawcard(data0[index], context);
                    },),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  _drawcard(Item_Module item, BuildContext context) {
    return Card(
      elevation: 15,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 15),
              width: 60,
              height: 150,
              child: Image(
                image: NetworkImage(item.image_link),
              )),
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.name,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'SansitaSwashed',
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 5,),

              Text(item.price.toString()+"  L.E"),
              SizedBox(height: 15,),
              Text(item.quantity.toString()+" Item",style:TextStyle(fontFamily: "SansitaSwashed",fontSize: 20,letterSpacing: 2.5)
    )



            ],
          ),

        ],
      ),
    );
  }

}
