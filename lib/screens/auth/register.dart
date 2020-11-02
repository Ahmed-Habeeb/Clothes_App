import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helper/user_app.dart';
import 'package:shop_app/modules/user_module.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/screens/auth/login.dart';


class Register_Screen extends StatefulWidget {
  @override
  _Register_ScreenState createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {

  TextEditingController _fullnamecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();
  TextEditingController _repasscontroller = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _fullnamecontroller.dispose();
    _emailcontroller.dispose();
    _passcontroller.dispose();
    _repasscontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data=Provider.of<Auth_Provider>(context);
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(

                begin: Alignment(-1, -4.0),
                end: Alignment(0.0, 1.0),
                colors: [
                  Colors.deepPurple,
                  Colors.purple,
                ],
              )),
        ),
        Scaffold(backgroundColor: Colors.transparent,

            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Stack(
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
                          offset: Offset(0, -50),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                            child: Theme(
                              data: Theme.of(context).copyWith(splashColor: Colors.transparent
                              ),
                              child: TextField(


                                controller: _fullnamecontroller,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(

                                    border: InputBorder.none,
                                    filled: true,
                                    labelText: "Full Name",
                                    labelStyle:
                                    TextStyle(color: Colors.white, fontSize: 18),
                                    contentPadding: EdgeInsets.only(left: 10),
                                    icon: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                          height: 20,
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
                        SizedBox(height: 20,),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius:
                              BorderRadiusDirectional.all(Radius.circular(30)),
                              shape: BoxShape.rectangle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextField(
                                controller: _repasscontroller,
                                obscureText: true,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    filled: true,
                                    labelText: "Re-Password",
                                    labelStyle:
                                    TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    contentPadding: EdgeInsets.only(left: 10),
                                    icon: Icon(
                                      Icons.vpn_key,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Flexible(
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            child: RaisedButton(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.deepPurple.shade500,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.5),
                              ),
                              disabledColor: Colors.white,
                              color: Colors.white,
                              shape: StadiumBorder(),
                              onPressed: () {
                                String fullname = _fullnamecontroller.text;
                                String email = _emailcontroller.text;
                                String pass = _passcontroller.text;
                                String repass = _repasscontroller.text;
                                if (email.contains("@") && pass.length > 7 &&
                                    pass == repass) {
                                  User_Module user=User_Module(fullname: fullname,email: email,password: pass,admin: 0);
                                  data.register(user).then((value) {
                                    if(value){

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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Screen(),));
                            },
                            child: Text("I Already have an account?",style: TextStyle(color: Colors.grey.shade200,fontSize: 18),)),

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

}