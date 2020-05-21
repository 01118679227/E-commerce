import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/screens/cartscreen.dart';
import 'package:ecommerce/screens/product_info.dart';
import 'package:ecommerce/services/store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/services/auth.dart';
class home extends StatefulWidget {
  static String id ="home";
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final _auth = Auth();
  FirebaseUser _LoggedUser;
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  final _store = Store();
  List<Product> _products;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              currentIndex: _bottomBarIndex,
              fixedColor: Colors.amber,
              onTap: (value) {
                setState(() {
                  _bottomBarIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                  title: Text('test'),
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  title: Text('test'),
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  title: Text('test'),
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  title: Text('test'),
                  icon: Icon(Icons.person),
                ),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: Colors.orange,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: <Widget>[
                  Text("Jackets", style: TextStyle(
                      color: _tabBarIndex == 0 ? Colors.black : Colors.grey,
                      fontSize: _tabBarIndex == 0 ? 14 : null),),
                  Text("Trousers", style: TextStyle(
                      color: _tabBarIndex == 1 ? Colors.black : Colors.grey,
                      fontSize: _tabBarIndex == 1 ? 14 : null),),
                  Text("T-shirtd", style: TextStyle(
                      color: _tabBarIndex == 2 ? Colors.black : Colors.grey,
                      fontSize: _tabBarIndex == 2 ? 14 : null),),
                  Text("Shoes", style: TextStyle(
                      color: _tabBarIndex == 3 ? Colors.black : Colors.grey,
                      fontSize: _tabBarIndex == 3 ? 14 : null),),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                JacketView(),
                trouserView(),
                tshirtView(),
                shoesView(),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Discover".toUpperCase(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  GestureDetector(
                      onTap: (){Navigator.pushNamed(context, CartScreen.id);},
                      child: Icon(Icons.shopping_cart)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    _LoggedUser = await _auth.getUser();
  }

  Widget JacketView() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              if (doc['productCategory'] == 'jacket') {
                products.add(Product(
                  pId: doc.documentID,
                  pName: data['productName'],
                  pPrice: data['productPrice'],
                  pDescription: data['productDescription'],
                  pLocation: data['productLocation'],
                  pCategory: data['productCategory'],
                ));
              }
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .8
              ),
              itemBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage(products[index].pLocation),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: .6,
                              child: Container(
                                height: 60,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text(products[index].pName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),),
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
          } else {
            return Center(child: Text('Loading....'));
          }
        }
    );
  }
  Widget trouserView() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              if (doc['productCategory'] == 'trouser') {
                products.add(Product(
                  pId: doc.documentID,
                  pName: data['productName'],
                  pPrice: data['productPrice'],
                  pDescription: data['productDescription'],
                  pLocation: data['productLocation'],
                  pCategory: data['productCategory'],
                ));
              }
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .8
              ),
              itemBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage(products[index].pLocation),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: .6,
                              child: Container(
                                height: 60,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text(products[index].pName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),),
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
          } else {
            return Center(child: Text('Loading....'));
          }
        }
    );
  }
  Widget tshirtView() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              if (doc['productCategory'] == 'tshirt') {
                products.add(Product(
                  pId: doc.documentID,
                  pName: data['productName'],
                  pPrice: data['productPrice'],
                  pDescription: data['productDescription'],
                  pLocation: data['productLocation'],
                  pCategory: data['productCategory'],
                ));
              }
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .8
              ),
              itemBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage(products[index].pLocation),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: .6,
                              child: Container(
                                height: 60,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text(products[index].pName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),),
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
          } else {
            return Center(child: Text('Loading....'));
          }
        }
    );
  }
  Widget shoesView() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              if (doc['productCategory'] == 'shoes') {
                products.add(Product(
                  pId: doc.documentID,
                  pName: data['productName'],
                  pPrice: data['productPrice'],
                  pDescription: data['productDescription'],
                  pLocation: data['productLocation'],
                  pCategory: data['productCategory'],
                ));
              }
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .8
              ),
              itemBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage(products[index].pLocation),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: .6,
                              child: Container(
                                height: 60,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text(products[index].pName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),),
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
          } else {
            return Center(child: Text('Loading....'));
          }
        }
    );
  }
}
