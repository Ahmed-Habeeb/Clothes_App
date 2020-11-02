
import 'package:flutter/material.dart';
import 'package:shop_app/screens/category_screen.dart';

import 'mydrawer.dart';

class Cat_Screen extends StatelessWidget {
  List<String> _categories = [
    "Summer",
    "Winter",
    "Bags",
    "Shoes",
    "Accessories",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text("Categories",style: TextStyle(fontFamily: "DancingScript",color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,letterSpacing: 1.5),),
        backgroundColor: Colors.transparent,elevation: 0,iconTheme: IconThemeData(color: Colors.black,size: 30),),
      body: Container(
        child:Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*.5,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 5,
                ),
                itemCount: 4, itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Category_Screen(_categories[index]),));
                  },
                  child: Card(
                    color: Colors.deepPurple,
                    elevation: 5,
                    child: Center(
                      child: Text(_categories[index],style: TextStyle(color: Colors.white,fontSize: 25,fontFamily: "SansitaSwashed"),),
                    ),
                  ),
                );
              },),
            ),
            Transform.translate(
              offset: Offset(0,-25),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Category_Screen(_categories[4]),));


                },
                child: Card(

                  color: Colors.deepPurple,
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50,bottom: 50),
                    child: Center(
                      child: Text(_categories[4],style: TextStyle(color: Colors.white,fontSize: 25,fontFamily: "SansitaSwashed"),),
                    ),
                  ),
                ),
              ),
            )
          ],
        ) ,
      ),
    );
  }
}