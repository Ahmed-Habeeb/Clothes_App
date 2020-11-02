import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shop_app/modules/item_module.dart';
import 'package:shop_app/modules/my_orders.dart';
import 'package:shop_app/modules/order_module.dart';
import 'package:shop_app/modules/user_module.dart';
import 'package:shop_app/modules/users_request_module.dart';

class FireStore {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StorageReference _storage = FirebaseStorage.instance.ref().child("Images/");
  String _users = "Users";
  String _categories = "Categories";
  String _Orders = "Orders";
  String _MyOrders = "MyOrders";


  order_one_item(Order_Module order, String email) async {
    await _firestore.collection(_Orders).doc(email).set({"Email": email});
    await _firestore.collection(_Orders).doc(email).collection(_Orders)
        .doc()
        .set(order.tomap());
  }

  order_many_items(List<Order_Module> orders, String email) async {
    for (int i = 0; i < orders.length; i++) {
      await order_one_item(orders[i], email);
    }
    delete_all(email);
  }

  adduser(User_Module user) async {
    await _firestore.collection(_users).doc(user.email).set(user.tomap());
  }

  Future<User_Module> getuser(String email) async {
    var result = await _firestore.collection(_users).doc(email).get();
    var map = result.data();
    User_Module user = User_Module();
    user.frommap(map);
    return user;
  }

  Future<bool> additem(String category, Item_Module item) async {
    await _firestore
        .collection(_categories)
        .doc(category)
        .set({category: category});
    await _firestore
        .collection(_categories)
        .doc(category)
        .collection("Items")
        .doc()
        .set(item.tomap());

    return true;
  }

  Future<bool> edit_item(String category, Item_Module item) async {
    await _firestore
        .collection(_categories)
        .doc(category)
        .set({category: category});
    await _firestore
        .collection(_categories)
        .doc(category)
        .collection("Items")
        .doc(item.item_id)
        .set(item.tomap());

    return true;
  }

  Future<List<Item_Module>> get_iem_byid(List<My_Orders> list) async {
    List<Item_Module> items = List<Item_Module>();

    for (int i = 0; i < list.length; i++) {
      Item_Module order = Item_Module();
      var doc = await _firestore
          .collection(_categories)
          .doc(list[i].Category)
          .collection("Items").doc(list[i].item_id).get();
      var data = doc.data();
      order.frommap(data, doc.id);
      items.add(order);
    }
    return items;
  }
  Future<List<Item_Module>> get_iem_by_id(List<Order_Module> list) async {
    List<Item_Module> items = List<Item_Module>();

    for (int i = 0; i < list.length; i++) {
      Item_Module order = Item_Module();
      var doc = await _firestore
          .collection(_categories)
          .doc(list[i].Category)
          .collection("Items").doc(list[i].item_id).get();
      var data = doc.data();
      order.frommap(data, doc.id);
      items.add(order);
    }
    return items;
  }
  Future<List<User_Request_Module>> get_requests_users()async {
    List<User_Request_Module> return_data = List<User_Request_Module>();
    var result = await _firestore.collection(_Orders).get();
    var data = result.docs;
    try{
    for (QueryDocumentSnapshot snapshot in data) {
      var requests = await get_requests_by_user(snapshot.data()["Email"]);
      User_Request_Module user = User_Request_Module(
          email: snapshot.data()["Email"], lenth: requests.length);
      return_data.add(user);
    }
  }
  catch(e){
      print(e.toString());
  }
    // for (int i=0;i<data.length;i++){
    //
    //   var requests=await get_requests_by_user(data[i].data()["Email"]);
    //   User_Request_Module user=User_Request_Module(email: data[i].data()["Email"],lenth: requests.length);
    //   return_data.add(user);
    // }


    return return_data;




  }
  Future<List<Order_Module>> get_requests_by_user(String email)async{
    List<Order_Module> requests=List<Order_Module>();
    var result= await _firestore.collection(_Orders).doc(email).collection(_Orders).get();
    var data=result.docs;
    for(DocumentSnapshot doc in data){
      Order_Module order=Order_Module();
      order.from_map(doc.data());
      requests.add(order);
    }
    return requests;

  }

  Future<bool> order(String email, String item_id, String category) async {
    await _firestore
        .collection(_Orders)
        .doc()
        .set({"Item_id": item_id,
      "Category": category});
  }

  Future<bool> addorder(String email, String item_id, String category) async {
    await _firestore
        .collection(_users)
        .doc(email).collection(_MyOrders).doc()
        .set({"Item_id": item_id,
      "Category": category});


    return true;
  }

  Future<bool> delete_order(String email, String item_id) async {
    await _firestore
        .collection(_users)
        .doc(email).collection(_MyOrders).doc(item_id).delete();


    return true;
  }

  Future<List<My_Orders>> get_my_orders(String email) async {
    List<My_Orders> items = List<My_Orders>();

    var snapshots = await _firestore
        .collection(_users)
        .doc(email)
        .collection(_MyOrders)
        .get();
    var data = snapshots.docs;
    for (int i = 0; i < data.length; i++) {
      My_Orders item = My_Orders();
      item.frommap(data[i].data(), data[i].id);
      items.add(item);
    }
    return items;
  }


  Future<List<Item_Module>> get_all_items() async {
    List<Item_Module> items = List<Item_Module>();

    var snapshots = await _firestore.collection(_categories).get();
    var data = snapshots.docs;
    for (int i = 0; i < data.length; i++) {
      List<Item_Module> list = await get_items_by_category(data[i].id);
      items..addAll(list);
    }
    return items;
  }

  Future<List<Item_Module>> get_items_by_category(String Category) async {
    List<Item_Module> items = List<Item_Module>();

    var snapshots = await _firestore
        .collection(_categories)
        .doc(Category)
        .collection("Items")
        .get();
    var data = snapshots.docs;
    for (int i = 0; i < data.length; i++) {
      Item_Module item = Item_Module();
      item.frommap(data[i].data(), data[i].id);
      items.add(item);
    }
    return items;
  }

  Future<String> upload_image(File file) async {
    String name = Random().nextInt(500000).toString();
    String link;
    StorageReference ref = _storage.child(name);
    StorageUploadTask upload = ref.putFile(file);
    var d = await upload.onComplete;

    if (upload.isSuccessful || upload.isComplete)
      link = await ref.getDownloadURL();
    return link;
  }

  delete_all(String email) async {
    await _firestore
        .collection(_users)
        .doc(email)
        .collection(_MyOrders).get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}