
import 'package:ecommerce/provider/adminmode.dart';
import 'package:ecommerce/provider/cartitem.dart';
import 'package:ecommerce/provider/modalhud.dart';
import 'package:ecommerce/screens/EditeProduct.dart';
import 'package:ecommerce/screens/cartscreen.dart';
import 'package:ecommerce/screens/manageProducts.dart';
import 'package:ecommerce/screens/addproduct.dart';
import 'package:ecommerce/screens/adminhome.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/screens/loginscreen.dart';
import 'package:ecommerce/screens/product_info.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/screens/signup.dart';
import 'package:provider/provider.dart';
void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context)=>ModelHud(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context)=>CartItem(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context)=>AdminMode(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: LoginScreen.id,
          routes: {
            CartScreen.id : (context)=> CartScreen(),
            ProductInfo.id : (context)=> ProductInfo(),
            EditeProduct.id:(context)=>EditeProduct(),
            LoginScreen.id : (context)=> LoginScreen(),
            SignUpScreen.id :(context)=> SignUpScreen(),
            AdminHome.id :(context)=> AdminHome(),
            home.id :(context)=> home(),
            AddProduct.id :(context)=> AddProduct(),
            ManageProducts.id :(context)=> ManageProducts(),
          },
        ),
    );
  }
}
