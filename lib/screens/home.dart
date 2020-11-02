import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/modules/item_module.dart';
import 'package:shop_app/providers/store_provider.dart';
import 'package:shop_app/screens/auth/login.dart';
import 'package:shop_app/screens/mydrawer.dart';
import 'package:shop_app/screens/myorders_screen.dart';

class Home_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth=FirebaseAuth.instance;
    final data=Provider.of<Store_Provider>(context);
      if (_auth.currentUser!=null)
        data.get_my_orders(_auth.currentUser.email);

    return Scaffold(
      drawer: MyDrawer(),
      floatingActionButton: Container(
        child: Stack(
          children: [
            FloatingActionButton(
              backgroundColor: Colors.deepPurple,
              child: Icon(FontAwesomeIcons.shoppingBasket),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrders_Screen(),));

              },
            ),
        Transform.translate(
          offset: Offset(37,-9),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.purple),
            child: Text((_auth.currentUser!=null)?data.myorders.length.toString():"0",style: TextStyle(color: Colors.white,fontSize: 15),),),
        )

          ],
        ),
      ),
      backgroundColor: Colors.white,

      appBar: AppBar(

        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Clothes App ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "DancingScript",
            fontSize: 35,
            color: Colors.black,
          ),
        ),

        backgroundColor: Colors.transparent,
      elevation: 0,),
      body: FutureBuilder(
        future: data.get_all_items(),
        builder: (context, snapshot) {
          while (data.items.isEmpty) {
            return Loading();
          }
          return Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Text(
                    "Welcome in our App ",
                    style: TextStyle(color: Colors.black, letterSpacing: 1.5),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  margin: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextField(
                    // controller: _controller,
                    decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(fontSize: 16),
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.only(left: 12, right: 12, top: 5),
                    itemCount: data.items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        childAspectRatio: .60,
                        mainAxisSpacing: 2

                      // ignore: missing_return
                    ),
                    itemBuilder: (context, index) {
                      return (data.items[index].discount != 0)
                          ? _drawcard(context, data.items[index])
                          : _drawcard_without_discount(
                          context, data.items[index]);
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
  _drawcard(BuildContext context, Item_Module item) {
    return Card(
      elevation: 10,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.red,
                child: Text(
                  item.discount.toInt().toString() + "%",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.cartPlus,
                  color: Colors.deepPurple,
                ),
                onPressed: () {
                  addoreder(item.item_id, item.category,context);
                },
              ),
            ],
          ),
          Container(
              width: 100,
              height: 150,
              child: Image(
                image: NetworkImage(item.image_link),
              )),
          Text(
            item.name,
            style: TextStyle(
                fontSize: 20,
                fontFamily: "SansitaSwashed",
                fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.discprice.toInt().toString() + " L.E ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                item.price.toInt().toString() + " L.E ",
                style: TextStyle(decoration: TextDecoration.lineThrough),
              )
            ],
          )
        ],
      ),
    );
  }

  _drawcard_without_discount(BuildContext context, Item_Module item) {
    return Card(
      elevation: 10,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.cartPlus,
                  color: Colors.deepPurple,
                ),
                onPressed: () {
                  addoreder(item.item_id, item.category,context);
                },
              ),
            ],
          ),
          Container(
              width: 100,
              height: 150,
              child: Image(
                image: NetworkImage(item.image_link),
              )),
          Text(
            item.name,
            style: TextStyle(
                fontSize: 20,
                fontFamily: "SansitaSwashed",
                fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.price.toInt().toString() + " L.E ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  addoreder(String id,String category,BuildContext context){
    final data =Provider.of<Store_Provider>(context,listen: false);
    if(data.user!=null && data.user.email!=""){
      data.addorder(data.user.email, id, category);
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Screen(),));
    }

  }
}
