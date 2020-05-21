import 'package:ecommerce/provider/modalhud.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id='signUpScreen';
  String _email , _password;
  final _auth = Auth();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.amber,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoading,
          child: Form(
            key: _globalKey,
            child: new ListView(   
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
                              controller: _nameController,
                              cursorColor:  Colors.white70,
                              decoration: InputDecoration(
                                  hintText: "Enter your Name",
                                  prefixIcon: Icon(
                                    Icons.perm_identity,
                                    color: Colors.amber,
                                  ),
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
                                  filled: true,
                                  fillColor: Colors.white70
                              ),
                             validator: (value){
                                if(value.isEmpty){
                                  return "Enter your Name ";
                                }
                             },
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
                              obscureText: true,
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
                                  final modelHud = Provider.of<ModelHud>(context,listen :false);
                                  modelHud.ChangeIsLoading(true);
                                  if(_globalKey.currentState.validate()){
                                    _email = _emailController.text.trim();
                                    _password = _passwordController.text;
                                    _globalKey.currentState.save();
                                     try {
                                       final authResult = await _auth.signUp(_email, _password);
                                       modelHud.ChangeIsLoading(false);
                                       if(authResult != null){
                                         Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
                                       }
                                       //print(authResult.user.uid);
                                     }catch(e){
                                       modelHud.ChangeIsLoading(false);
                                       Scaffold.of(context).showSnackBar(SnackBar(
                                         content: Text(e.message),
                                       ));
                                     }
                                  }
                                  modelHud.ChangeIsLoading(false);
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 23.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Do have an account ? ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: (){Navigator.pushNamed(context, LoginScreen.id);},
                                child: Text('Login',
                                  style: TextStyle(
                                    //color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.0),
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
}
