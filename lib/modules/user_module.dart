

class User_Module{

  String fullname,email,password;
  int admin;

  User_Module({this.fullname, this.email, this.password, this.admin});

  Map<String,dynamic> tomap(){
    Map<String,dynamic> map=Map();
    map['FullName']=fullname;
    map['Email']=email;
    map['Password']=password;
    map['Admin']=admin;

    return map;


  }
  frommap(Map<String,dynamic> map){
   this.fullname=map['FullName'];
   this.email=map['Email'];
   this.password=map['Password'];
   this.admin=map['Admin'];

  }
}