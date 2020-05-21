import 'package:ecommerce/screens/manageProducts.dart';
import 'package:ecommerce/screens/addproduct.dart';
import 'package:flutter/material.dart';
class AdminHome extends StatelessWidget {
  static String id ="AdminHome";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: double.infinity,),
          RaisedButton(
              onPressed: (){
                Navigator.pushNamed(context, AddProduct.id);
              },
            child: Text('Add Prouduct'),
          ),
          RaisedButton(
            onPressed: (){
              Navigator.pushNamed(context, ManageProducts.id);
            },
            child: Text('Edit Prouduct'),
          ),
          RaisedButton(
            onPressed: (){

            },
            child: Text('View Orders'),
          ),
        ],
      ),
    );
  }
}
