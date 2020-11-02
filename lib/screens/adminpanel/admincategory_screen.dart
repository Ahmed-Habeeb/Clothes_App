import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/modules/item_module.dart';
import 'package:shop_app/providers/store_provider.dart';

import '../mydrawer.dart';
import 'edit_screen.dart';

class AdminCategory_Screen extends StatelessWidget {
  String category;

  AdminCategory_Screen(this.category);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Store_Provider>(context);
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          category,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "DancingScript",
            fontSize: 35,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder(future: data.get_item_by_category(category),builder: (context, snapshot) {
          List<Item_Module> data =snapshot.data;
          while (data==null){
            return Loading();
          }

          return GridView.builder( itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                childAspectRatio: .60,
                mainAxisSpacing: 2), itemBuilder: (context, index) {
              return (data[index].discount != 0)
                  ? _drawcard(context, data[index])
                  : _drawcard_without_discount(
                  context, data[index]);


            },);
        },),
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
