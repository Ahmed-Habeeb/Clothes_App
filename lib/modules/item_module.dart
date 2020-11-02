

class Item_Module{
  int quantity=1;
  String name,image_link,item_id,category;
  double price,discount,discprice;


  Item_Module({this.name, this.image_link, this.item_id, this.category,
      this.price, this.discount, this.discprice});

  Map<String,dynamic> tomap(){
    Map<String,dynamic> map=Map();
    map['name']=name;
    map['discount']=discount;
    map['price']=price;
    map['discprice']=discprice;
    map['Image_link']=image_link;
    map['Category']=category;

    return map;
  }

  frommap(Map<String,dynamic> map,String id){
   this.name=map['name'];
   this.price=map['price'];
   this.discprice=map['discprice'];
   this.discount=map['discount'];
   this.image_link=map['Image_link'];
   this.category=map['Category'];
   this.quantity=map['Quantity'];

   this.item_id=id;

  }
}