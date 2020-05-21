import 'package:ecommerce/provider/adminmode.dart';
import 'package:ecommerce/provider/modalhud.dart';
import 'package:ecommerce/screens/adminhome.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final adminPassword = 'admin1234';
  bool isAdmin = false;
  static String id ="LoginScreen";
  String _email , _password ;
  final _auth = Auth();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
           children: <Widget>[
             Stack(
               children: <Widget>[
                 Align(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Padding(padding:EdgeInsets.only(top: 70.0)),
                         Image(image: AssetImage('images/buy.png'),
                         height: 80.0,
                           width: 80.0,
                         ),
                         SizedBox(height: 0.0,),
                         Text('Buy it',
                           style: TextStyle(
                               fontFamily: 'Pacifico',
                               fontSize: 26
                           ),
                         ),
                         SizedBox(height: 30.0),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 30),
                           child: TextFormField(
                             controller: _emailController,
                             cursorColor:  Colors.white70,
                             decoration: InputDecoration(
                               hintText: "Enter your Email",
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
                                 return "Enter your Email ";
                               }
                             },
                           ),
                         ),
                         SizedBox(height: 30.0),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 30),
                           child: TextFormField(
                             controller: _passwordController,
                             cursorColor:  Colors.white70,
                             decoration: InputDecoration(
                                 hintText: "Enter your Password",
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
                                 return "Enter your Password ";
                               }
                             },
                             obscureText: true,
                           ),
                         ),
                         SizedBox(height: 20.0),
                         Padding(padding: EdgeInsets.symmetric(horizontal: 120.0),
                         child: Builder(
                           builder:(context)=> FlatButton(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(20),
                             ),
                             color: Colors.black,
                               onPressed: () async{
                                 _validate(context);
                               },
                               child: Text(
                                 'Login',
                                 style: TextStyle(color: Colors.white),
                               ),
                           ),
                         ),
                         ),
                         SizedBox(height: 23.0),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             Text('Don\'t have an account ? ',
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 16.0,
                             ),
                             ),
                             GestureDetector(
                               onTap: (){Navigator.pushNamed(context, SignUpScreen.id);},
                               child: Text('Sign up',
                                 style: TextStyle(
                                   //color: Colors.white,
                                   fontSize: 16.0,
                                 ),
                               ),
                             ),
                           ],
                         ),
                         SizedBox(height: 30.0),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                           child: Row(
                             children: <Widget>[
                               Expanded(
                                 child: GestureDetector(
                                   onTap: (){
                                     Provider.of<AdminMode>(context,listen: false).ChangeIsAdmin(true);
                                   },
                                   child: Text(
                                     'i\'m an admin',
                                      textAlign: TextAlign.center,
                                     style: TextStyle(
                                       color: Provider.of<AdminMode>(context).isAdmin ? Colors.amber : Colors.white
                                     ),
                                   ),
                                 ),
                               ),
                               Expanded(
                                 child: GestureDetector(
                                   onTap: (){
                                     Provider.of<AdminMode>(context,listen: false).ChangeIsAdmin(false);
                                   },
                                   child: Text(
                                       'i\'m an user',
                                        textAlign: TextAlign.center,
                                     style: TextStyle(
                                         color: Provider.of<AdminMode>(context).isAdmin ? Colors.white : Colors.amber
                                     ),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ],
                     ),
                 ),
               ],
             ),
           ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async{
    final modelHud = Provider.of<ModelHud>(context,listen: false);
    modelHud.ChangeIsLoading(true);
    if(_globalKey.currentState.validate()){
      _email    = _emailController.text.trim();
      _password = _passwordController.text;
      _globalKey.currentState.save();
      if(Provider.of<AdminMode>(context,listen: false).isAdmin){
        if(_password == adminPassword){
          try{
            await _auth.signIn(_email, _password);
            Navigator.pushNamed(context, AdminHome.id);
          }catch(e){
            modelHud.ChangeIsLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        }else{
          modelHud.ChangeIsLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Somthing is wrong !'),
          ));
        }
      }else{
        try{
          await _auth.signIn(_email, _password);
          Navigator.pushNamed(context, home.id);
        }catch(e){
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modelHud.ChangeIsLoading(false);
  }
}
