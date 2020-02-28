import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Pages
import 'sendCode.dart';
import 'RegisterDevice.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Redirect(),
    );
  }
}



class Redirect extends StatefulWidget {
  @override
  _RedirectState createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {


  _checkSet(context) async{
    SharedPreferences pres = await SharedPreferences.getInstance();
    if(pres.containsKey("mobile")){
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_)=> sendCode()));
    }
    else{
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_)=> RegisterDevice()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkSet(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

