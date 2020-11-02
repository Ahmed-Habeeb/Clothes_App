import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/modules/item_module.dart';
import 'package:shop_app/modules/order_module.dart';
import 'package:shop_app/providers/store_provider.dart';

class MyOrders_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Store_Provider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "My-Orders",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "DancingScript",
            fontSize: 35,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
        future: data.get_orders_byid(),
        builder: (context, snapshot) {
          while (data.orders.isEmpty) {
            return Loading();
          }
          return Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                ListView.builder(
                  padding: EdgeInsets.only(bottom: 55),
                  itemCount: data.orders.length,
                  itemBuilder: (context, index) {
                    return _drawcard(data.orders[index], index,context);
                  },
                ),
                Positioned(
                  bottom: 10,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: RaisedButton(
                      child: Text(
                        "Order (" + data.orders.length.toString() + ") Items",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      onPressed: () {
                        data.order_many_items().then((value) {
                          Navigator.pop(context);
                        });

                      },
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Loading() {
    return Container(
      child: Center(
        child: Text(
          "No Data To Show",
          style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade800,
              fontFamily: "SansitaSwashed"),
        ),
      ),
    );
  }

  _drawcard(Item_Module item, int index,BuildContext context) {
    final data = Provider.of<Store_Provider>(context);
    return Card(
      elevation: 15,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: EdgeInsets.only(left: 15),
              width: 60,
              height: 150,
              child: Image(
                image: NetworkImage(item.image_link),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                item.name,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'SansitaSwashed',
                    fontWeight: FontWeight.w900),
              ),
              Text(item.price.toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(3),
                      margin: EdgeInsets.only(right: 15, top: 25),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red)),
                      child: Icon(FontAwesomeIcons.minus),
                    ),onTap: (){
                      data.quantity_minus(index);
                  },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 8, right: 8),
                    child: Text(
                      data.orders[index].quantity.toString(),
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      data.quantity_plus(index);
                    },
                    child: Container(
                      padding: EdgeInsets.all(3),
                      margin: EdgeInsets.only(top: 25, left: 15),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green)),
                      child: Icon(FontAwesomeIcons.plus),
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              children: [
                RaisedButton(
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                  onPressed: () {
                    data.delete_order(data.user.email, data.myorders[index].id);
                  },
                ),
                RaisedButton(
                  child: Text(
                    "Order",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.green,
                  onPressed: () {
                    Order_Module order=Order_Module(item_id: item.item_id,quantity: item.quantity);
                    data.order_one_item(order);
                    data.delete_order(data.user.email, data.myorders[index].id);

                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
