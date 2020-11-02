

import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  FirebaseAuth _auth=FirebaseAuth.instance;


Future Signout()async{
  await _auth.signOut();
}

  Future<User> register(String email,String pass)async{
    var data= await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    return data.user;

  }
  Future<String> login(String email,String pass)async{
  String error;
    var data=await _auth.signInWithEmailAndPassword(email: email, password: pass).catchError((a){
      print(a.toString());
      error=a.toString();
    });

    return (error==null)?data.user.email:error;
  }
}