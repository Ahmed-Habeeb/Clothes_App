import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/modules/item_module.dart';
import 'package:shop_app/providers/store_provider.dart';
import 'package:shop_app/screens/adminpanel/add_screen.dart';
import 'package:shop_app/screens/adminpanel/edit_screen.dart';

import '../mydrawer.dart';

class Admin_Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Store_Provider>(context);
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Clothes App-Admin ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
              fontFamily: "DancingScript",
              fontSize: 35,
              color: Colors.black,
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Add_Screen(),
              ));
        },
        child: Icon(Icons.add),
      ),
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
                  Icons.edit,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Edit_Screen(item),
                      ));
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
                fontStyle: FontStyle.italic,
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
                  Icons.edit,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Edit_Screen(item),
                      ));
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
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.price.toInt().toString() + " L.E ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
}
