import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/provider/cartitem.dart';
import 'package:ecommerce/screens/cartscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id = "ProductInfo";
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    Product product= ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(
              image: AssetImage(product.pLocation),
              fit: BoxFit.fill,
            ),
          ),
           Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                        onTap: (){Navigator.pop(context);},
                        child: Icon(Icons.arrow_back_ios)),
                    GestureDetector(
                      onTap: (){Navigator.pushNamed(context, CartScreen.id);},
                        child: Icon(Icons.shopping_cart)),
                  ],
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            child: Column(
              children: <Widget>[
               Opacity(
                 child: Container(
                   color: Colors.white,
                   height: MediaQuery.of(context).size.height * .4,
                   width: MediaQuery.of(context).size.width,
                   child: Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text(product.pName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                         SizedBox(height: 10,),
                         Text(product.pCategory,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),),
                         SizedBox(height: 10,),
                         Text('\$${product.pPrice}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                         SizedBox(height: 10,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             ClipOval(
                               child: Material(
                                 color: Colors.orange,
                                 child: GestureDetector(
                                   onTap: add,
                                   child: SizedBox(
                                     height: 20,
                                     width: 20,
                                     child: Icon(Icons.add),
                                   ),
                                 ),
                               ),
                             ),
                             Text(_quantity.toString(),
                             style: TextStyle(fontSize: 60),
                             ),
                             ClipOval(
                               child: Material(
                                 color: Colors.orange,
                                 child: GestureDetector(
                                   onTap: subtract,
                                   child: SizedBox(
                                     height: 20,
                                     width: 20,
                                     child: Icon(Icons.remove),
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
                 opacity: .5,
               ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .12,
                  child: Builder(
                    builder:(context)=> RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                      ),
                      color: Colors.amber,
                        onPressed: (){
                         addToCart(context,product);
                        },
                      child: Text('Add to Cart'.toUpperCase(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  subtract() {
    if(_quantity > 1){
      setState(() {
        _quantity--;
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
    });
  }

  void addToCart(context,product)
  {
    CartItem carItem =Provider.of<CartItem>(context,listen: false);
    product.pQuantity = _quantity;
    carItem.addProduct(product);
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Added to cart")));
  }
}
