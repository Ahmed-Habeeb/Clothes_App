import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/user_module.dart';
import 'package:shop_app/network/auth.dart';
import 'package:shop_app/network/firestore.dart';
import 'package:shop_app/providers/store_provider.dart';



class Auth_Provider with ChangeNotifier{
  Auth _auth=Auth();
  FireStore _store=FireStore();
  Store_Provider _provider=Store_Provider();

signout(){
  _auth.Signout();
  _provider.user==null;

  notifyListeners();
}
  Future<bool> register(User_Module user)async{
    User _user= await _auth.register(user.email, user.password);
    if(user.email==_user.email)
      await _store.adduser(user);
    _provider.getuser(user.email);

    return true;

  }
   // ignore: missing_return
   Future<int> login(String email,String pass)async{
    String _user= await _auth.login(email, pass);

    if(_user!=null&&email==_user) {
      User_Module user = await _store.getuser(email);
      _provider.getuser(email);
      return user.admin;
    }

  }


}