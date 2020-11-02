import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/modules/item_module.dart';
import 'package:shop_app/modules/my_orders.dart';
import 'package:shop_app/modules/order_module.dart';
import 'package:shop_app/modules/user_module.dart';
import 'package:shop_app/modules/users_request_module.dart';
import 'package:shop_app/network/auth.dart';
import 'package:shop_app/network/firestore.dart';

class Store_Provider with ChangeNotifier {
  FireStore _store = FireStore();
  Auth _auth = Auth();

  List<Item_Module> items = List<Item_Module>();
  List<Item_Module> orders = List<Item_Module>();

  List<My_Orders> myorders = List<My_Orders>();
  User_Module user;

  Future<List<User_Request_Module>> get_requests_users()async{
    List<User_Request_Module> data= await _store.get_requests_users();


   return data;

  }

  Future emptyuser() async {
    await _auth.Signout().then((value) {
      user.admin = 0;
      user.email = "";
      myorders = List<My_Orders>();
    });

    notifyListeners();
  }

  quantity_plus(int index) {
    orders[index].quantity++;

    notifyListeners();
  }
  quantity_minus(int index) {
    orders[index].quantity--;

    notifyListeners();
  }

  Future<bool> addorder(String email, String item_id, String category) async {
    _store.addorder(email, item_id, category);
    get_my_orders(email);
  }

  Future<List<My_Orders>> get_my_orders(String email) async {
    List<My_Orders> orders = List<My_Orders>();
    orders = await _store.get_my_orders(email);

    if (orders.length != myorders.length) {
      myorders = orders;
    }
    notifyListeners();
    return orders;
  }

  Future<User_Module> getuser(String email) async {
    if (user == null || user.email == "") {
      user = await _store.getuser(email);
      notifyListeners();

      return user;
    }
  }

  Future<String> get_images() async {
    ImagePicker imagePicker = ImagePicker();
    var data = await imagePicker.getImage(
      source: ImageSource.gallery,
    );
    File file = File(data.path);
    String link = await _store.upload_image(file);

    return link;
  }

  get_orders_byid() async {
    List<Item_Module> orders1 = List<Item_Module>();

    orders1 = await _store.get_iem_byid(myorders);
    if (orders1.length != orders.length) {
      orders = orders1;
    }
    notifyListeners();
    return orders;
  }

  Future<bool> delete_order(String email, String item_id) async {
    await _store.delete_order(email, item_id);

    await get_my_orders(email);
    await get_orders_byid();
  }

  Future<bool> add_item(String cat, Item_Module item) async {
    bool data = await _store.additem(cat, item);
    print(data);
    return data;
  }

  Future<bool> edit_item(String cat, Item_Module item) async {
    bool data = await _store.edit_item(cat, item);
    return data;
  }

  Future<List<Item_Module>> get_item_by_category(String Category) async{

   List<Item_Module> data=await _store.get_items_by_category(Category);
   return data;
  }

  get_all_items() async {
    items = await _store.get_all_items();
  }

  order_one_item(Order_Module order)async {
   await _store.order_one_item(order, user.email);
  }
 Future<bool> order_many_items()async{
    List<Order_Module> orders1=List<Order_Module>();
    for(int i=0;i<orders.length;i++){
      Order_Module order=Order_Module(item_id: orders[i].item_id,quantity: orders[i].quantity,Category: orders[i].category);
      orders1.add(order);
    }
   await _store.order_many_items(orders1, user.email);

    return true;

  }
  Future<List<Item_Module>> get_requests_by_user(String email)async {
    List<Item_Module> data=List<Item_Module>();

    List<Order_Module> result= await _store.get_requests_by_user(email);

    List<Item_Module> data0=await _store.get_iem_by_id(result);
    for(int i=0;i<result.length;i++){
      data0[i].quantity=result[i].quantity;
      data.add(data0[i]);

    }



    return data;
  }
  }
