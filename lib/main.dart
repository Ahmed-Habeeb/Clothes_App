
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/providers/store_provider.dart';
import 'helper/admin_app.dart';
import 'helper/user_app.dart';
import 'network/firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  int admin = await getproviderdata();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.white
  ));
  if (admin != null && admin == 1) {
    runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => Auth_Provider(),

          ),
          ChangeNotifierProvider(
            create: (_) => Store_Provider(),

          )

        ],
        child: Admin_App()),);
  }
  else {
    runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => Auth_Provider(),

          ),
          ChangeNotifierProvider(
            create: (_) => Store_Provider(),

          )

        ],
        child: User_App()),);

  }
}

getproviderdata() async {
  var user = FirebaseAuth.instance.currentUser;
  FireStore _store = FireStore();
  if (user != null) {
    var l = await _store.getuser(user.email);

    return l.admin;
  }  return 0;
}

