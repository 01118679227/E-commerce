import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/screens/EditeProduct.dart';
import 'package:ecommerce/services/store.dart';
import 'package:flutter/material.dart';
class ManageProducts extends StatefulWidget {
  static String id ='ManageProducts';
  @override
  _ManageProductsState createState() => _ManageProductsState();
}
class _ManageProductsState extends State<ManageProducts> {
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder:(context,snapshot){
          if(snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents){
              var data = doc.data;
              products.add(Product(
                pId: doc.documentID,
                pName: data['productName'],
                pPrice: data['productPrice'],
                pDescription: data['productDescription'],
                pLocation: data['productLocation'],
                pCategory: data['productCategory'],
              ));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              childAspectRatio: .8
              ),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: GestureDetector(
                  onTapUp: (details){
                    double dx = details.globalPosition.dx;
                    double dy = details.globalPosition.dy;
                    double dx2 = MediaQuery.of(context).size.width - dx;
                    double dy2 = MediaQuery.of(context).size.width - dy;
                    showMenu(context: context,
                        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                        items: [
                          MyPopupMenuItem(
                            onClick: (){
                              Navigator.pushNamed(context, EditeProduct.id,arguments: products[index]);
                            },
                            child: Text('Edit'),
                          ),
                          MyPopupMenuItem(
                            onClick: (){
                              _store.deleteProduct(products[index].pId);
                              Navigator.of(context).pop();
                            },
                            child: Text('Delete'),
                          ),
                        ]);
                  },
                  child: Stack(
                    children: <Widget>[
                     Positioned.fill(
                       child: Image(
                         fit:BoxFit.fill,
                         image: AssetImage(products[index].pLocation),
                       ),
                     ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(products[index].pName,style: TextStyle(fontWeight: FontWeight.bold), ),
                                  Text("\$${products[index].pPrice}"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            );
          }else{
            return Center(child: Text('Loading....'));
          }
        }
      ),
    );
  }
}
class MyPopupMenuItem<T> extends PopupMenuItem<T>{
  final Widget child;
  final Function onClick;
  MyPopupMenuItem({@required this.child,@required this.onClick}) : super(child:child);
  @override
  PopupMenuItemState<T,PopupMenuItem<T>> createState(){
    return MyPopupMenuItemState();
  }
}
class MyPopupMenuItemState<T,PopupMenuItem> extends PopupMenuItemState<T,MyPopupMenuItem<T>>{

  @override
  void handleTap() {
    widget.onClick();

  }
}