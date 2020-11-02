import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helper/admin_app.dart';
import 'package:shop_app/helper/user_app.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/screens/auth/register.dart';

class Login_Screen extends StatefulWidget {
  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  TextEditingController _emailcontroller=TextEditingController();
  TextEditingController _passcontroller=TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data=Provider.of<Auth_Provider>(context);

    return Stack(
      children: <Widget>[
        Container( decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.0, -4.0),
              end: Alignment(1.0, 4.0),
              colors: [
                Colors.deepPurple,
                Colors.purple,
              ],
            )),),
        Scaffold(
            backgroundColor: Colors.transparent,

            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body:Stack(

              children: <Widget>[
                Container(
                  width: double.infinity,

                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Transform.translate(
                          offset: Offset(0,-50),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius:
                            BorderRadiusDirectional.all(Radius.circular(30)),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextField(
                              controller: _emailcontroller,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  labelText: "Email",
                                  labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 18),
                                  contentPadding: EdgeInsets.only(left: 10),
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius:
                            BorderRadiusDirectional.all(Radius.circular(30)),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextField(
                              controller: _passcontroller,
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  labelText: "Password",
                                  labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 18),
                                  contentPadding: EdgeInsets.only(left: 10),
                                  icon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 50,
                        ),
                        Flexible(
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            child: RaisedButton(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1),
                              ),
                              disabledColor: Colors.white,
                              color: Colors.white,
                              shape: StadiumBorder(),
                              onPressed: () async {
                                String email=_emailcontroller.text;
                                String pass=_passcontroller.text;
                                if(email.contains("@")&&pass.length>7) {
                                  _showMyDialog();
                                  data.login(email, pass).then((value) {
                                    if(value==1) {
                                      Navigator.pop(context);
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => Admin_App(),));
                                    }
                                    else{
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => User_App(),));

                                    }

                                  });

                                }

                              },

                            ),

                          ),
                        ),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Register_Screen(),));
                          },
                            child: Text("Create a new account",style: TextStyle(color: Colors.grey.shade200,fontSize: 18),)),

                      ],
                    ),
                  ),
                ),

              ],
            )
        ),
      ],
    );
  }
   _showMyDialog()  {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(child: SizedBox(
                  height: 50,
                    width: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ))),
                Center(child: Text('Logging In...')),
              ],
            ),
          ),

        );
      },
    );
  }
}