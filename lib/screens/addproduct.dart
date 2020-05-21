import 'package:ecommerce/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/services/store.dart';
class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  final _store = Store();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _imageLocationController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: ListView(
        children: <Widget>[
           Form(
             key: _globalKey,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: _nameController,
                    cursorColor:  Colors.white70,
                    decoration: InputDecoration(
                        hintText: "Proudect name",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.amber,
                        ),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        fillColor: Colors.white70
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return "Enter your Name ";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: _priceController,
                    cursorColor:  Colors.white70,
                    decoration: InputDecoration(
                        hintText: "Proudect Price",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.amber,
                        ),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        fillColor: Colors.white70
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return "Enter your Price ";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: _descriptionController,
                    cursorColor:  Colors.white70,
                    decoration: InputDecoration(
                        hintText: "Proudect description",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.amber,
                        ),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        fillColor: Colors.white70
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return "Enter your description ";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: _categoryController,
                    cursorColor:  Colors.white70,
                    decoration: InputDecoration(
                        hintText: "Proudect category",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.amber,
                        ),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        fillColor: Colors.white70
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return "Enter your Category ";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: _imageLocationController,
                    cursorColor:  Colors.white70,
                    decoration: InputDecoration(
                        hintText: "Proudect Location",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.amber,
                        ),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        fillColor: Colors.white70
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return "Enter your Location";
                      }
                    },
                  ),
                ),
                RaisedButton(onPressed: (){
                  if(_globalKey.currentState.validate()){
                    _globalKey.currentState.save();
                    _store.addProduct(Product(
                      pName: _nameController.text,
                      pPrice: _priceController.text,
                      pCategory: _categoryController.text,
                      pLocation: _imageLocationController.text,
                      pDescription: _descriptionController.text,
                    ));
                  }
                },
                child: Text('Add Product'),
                ),
              ],
          ),
           ),
        ],
      ),
    );
  }
}
