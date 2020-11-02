import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/modules/item_module.dart';
import 'package:shop_app/providers/store_provider.dart';


class Edit_Screen extends StatefulWidget {
  Item_Module item;

  Edit_Screen(this.item);

  @override
  _Edit_ScreenState createState() => _Edit_ScreenState(item);
}

class _Edit_ScreenState extends State<Edit_Screen> {
  TextEditingController _name, _price, _discount;
  Item_Module item;

  _Edit_ScreenState(this.item);
  List<String> _categories = [
    "Summer",
    "Winter",
    "Bags",
    "Shoes",
    "Accessories",
    "Select Category"
  ];
  String category = "Select Category";
  int val;

  GlobalKey<FormState> _formkey;

  @override
  void initState() {
    _name = TextEditingController();
    _price = TextEditingController();
    _discount = TextEditingController();
    _formkey = GlobalKey<FormState>();
    category=item.category;
    if(item.discount==0){
      val=1;

    }
    else{
      val=2;
    }

    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _discount.dispose();
    _price.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final data=Provider.of<Store_Provider>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,statusBarBrightness: Brightness.light,statusBarColor: Colors.white
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          "Edit "+item.name,
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 3.1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  (val == 1) ? without_discount() : with_discount(),
                  Container(
                    width: double.infinity,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: _categories.map((String e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (s) {
                        setState(() {
                          category = s;
                        });
                      },
                      value: category,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text("Submit"),
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          if (val == 1) {
                            data
                                .edit_item(
                                category,
                                Item_Module(
                                  item_id: item.item_id,
                                    category: category,
                                    price: double.parse(_price.text),
                                    discount: 0.0,
                                    discprice: 0.0,
                                    name: _name.text,
                                    image_link: item.image_link))
                                .then((value) {
                              if (value != null) {

                                (value)
                                    ? Navigator.pop(context)
                                    : Scaffold.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                  Text("Error Please Try Again"),
                                ));
                              }
                            });
                          }
                          else if (val==2){
                            data
                                .edit_item(
                                category,
                                Item_Module(
                                  item_id: item.item_id,
                                  category: category,
                                    price: double.parse(_price.text),
                                    discount: double.parse(_discount.text),
                                    discprice: item.discprice,
                                    name: _name.text,
                                    image_link: item.image_link))
                                .then((value) {
                              if (value != null) {
                                (value)
                                    ? Navigator.pop(context)
                                    : Scaffold.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                  Text("Error Please Try Again"),
                                ));
                              }
                            });

                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),

          ],),

        ),
      ),
    );
  }
  with_discount() {
    return Column(
      children: [
        Text("Real Price : " + item.discprice.toString()),
        SizedBox(
          height: 20,
        ),
        Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: _name,
                validator: (v) {
                  if (v.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: item.name),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _price,
                validator: (v) {
                  if (v.isEmpty) {
                    return 'Price is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: item.price.toString()),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _discount,
                onChanged: (p) {
                  setState(() {
                    item.discprice = double.parse(calc_realprice(
                        double.parse(_price.text), double.parse(p)));
                  });
                },
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v.isEmpty) {
                    return 'Discount is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: item.discount.toString()),
              ),
            ],
          ),
        ),
      ],
    );
  }
  String calc_realprice(double price, double disc) {
    double calc1 = (price * (disc / 100));
    double calc = price - calc1;

    print(calc);
    String realprice = calc.toString();
    return realprice;
  }


  without_discount() {
    return Column(
      children: [
        Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: _name,
                validator: (v) {
                  if (v.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: item.name),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _price,
                validator: (v) {
                  if (v.isEmpty) {
                    return 'Price is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: item.price.toString()),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
