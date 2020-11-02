class My_Orders{
  String Category,item_id,id;

  My_Orders({this.Category, this.item_id});
  frommap(Map<String,dynamic> map,String id){

    this.Category=map['Category'];
    this.item_id=map['Item_id'];
    this.id=id;

  }
}