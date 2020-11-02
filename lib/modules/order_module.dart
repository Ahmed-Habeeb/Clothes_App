

class Order_Module{
  String item_id,Category;
  int quantity;


  Order_Module({this.item_id, this.Category, this.quantity});

  Map<String,dynamic> tomap(){
    Map<String,dynamic> map=Map();

    map["Item_ID"]=this.item_id;
    map["Quantity"]=this.quantity;
    map["Category"]=this.Category;


    return map;


  }

  from_map(Map<String,dynamic> map){
    this.quantity=map["Quantity"];
    this.item_id=map["Item_ID"];
    this.Category=map["Category"];
  }
}