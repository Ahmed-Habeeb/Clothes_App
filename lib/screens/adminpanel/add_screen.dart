import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/modules/item_module.dart';
import 'package:shop_app/providers/store_provider.dart';
import 'package:shop_app/screens/mydrawer.dart';

class Add_Screen extends StatefulWidget {
  @override
  _Add_ScreenState createState() => _Add_ScreenState();
}

class _Add_ScreenState extends State<Add_Screen> {
  TextEditingController _name, _price, _discount;
  String image_link = "";
  int val = 1;
  String realprice = "0.0";
  List<String> _categories = [
    "Summer",
    "Winter",
    "Bags",
    "Shoes",
    "Accessories",
    "Select Category"
  ];
  String category = "Select Category";

  GlobalKey<FormState> _formkey;

  @override
  void initState() {
    _name = TextEditingController();
    _price = TextEditingController();
    _discount = TextEditingController();
    _formkey = GlobalKey<FormState>();

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
    final data = Provider.of<Store_Provider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          "ADD ITEM",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 3.1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(

                    child: RadioListTile(
                      activeColor: Colors.deepPurple,
                      value: 1,
                      groupValue: val,
                      title: Text("Without Discount"),
                      onChanged: (value) {
                        setState(() {
                          val = value;
                        });
                      },
                    ),
                  ),
                  Flexible(
                    child: RadioListTile(
                      activeColor: Colors.deepPurple,
                      value: 2,
                      groupValue: val,
                      title: Text("With Discount"),
                      onChanged: (value) {
                        setState(() {
                          val = value;
                        });
                      },
                    ),
                  )
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.add_a_photo,
                  color: Colors.deepPurple,
                  size: 30,
                ),
                onPressed: () {
                  data.get_images().then((value) {
                    setState(() {
                      image_link = value;
                    });
                  });
                },
              ),
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
                                  .add_item(
                                      category,
                                      Item_Module(
                                        category: category,
                                          price: double.parse(_price.text),
                                          discount: 0.0,
                                          discprice: 0.0,
                                          name: _name.text,
                                          image_link: image_link))
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
                                  .add_item(
                                  category,
                                  Item_Module(
                                    category: category,
                                      price: double.parse(_price.text),
                                      discount: double.parse(_discount.text),
                                      discprice: double.parse(realprice),
                                      name: _name.text,
                                      image_link: image_link))
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
            ],
          ),
        ),
      ),
    );
  }

  String calc_realprice(double price, double disc) {
    double calc1 = (price * (disc / 100));
    double calc = price - calc1;

    print(calc);
    String realprice = calc.toString();
    return realprice;
  }

  with_discount() {
    return Column(
      children: [
        Text("Real Price : " + realprice),
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
                    border: OutlineInputBorder(), labelText: "Title"),
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
                    border: OutlineInputBorder(), labelText: "Price"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _discount,
                onChanged: (p) {
                  setState(() {
                    realprice = calc_realprice(
                        double.parse(_price.text), double.parse(p));
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
                    border: OutlineInputBorder(), labelText: "Discount"),
              ),
            ],
          ),
        ),
      ],
    );
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
                    border: OutlineInputBorder(), labelText: "Title"),
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
                    border: OutlineInputBorder(), labelText: "Price"),
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
