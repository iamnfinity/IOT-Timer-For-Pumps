import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Shared Prefs
import 'package:shared_preferences/shared_preferences.dart';

// Import  Main Screen
import 'main.dart';

// Send Sms
import 'package:sms_maintained/sms.dart';

class RegisterDevice extends StatefulWidget {
  @override
  _RegisterDeviceState createState() => _RegisterDeviceState();
}

class _RegisterDeviceState extends State<RegisterDevice> {

  // Error Message Holder
  String Message = "";


  // Controllers
  TextEditingController _deviceNumberController = new TextEditingController();

  _registerDevice() async{

    // Init Shared Prefrences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Set Number after Verification
    String Pattern = r"^[6-9]\d{9}$";
    RegExp expression = new RegExp(Pattern);
    print(expression.hasMatch(_deviceNumberController.text));
    if(expression.hasMatch(_deviceNumberController.text) == true){
      prefs.setString("mobile", _deviceNumberController.text);
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_)=>new MyApp()));
    }
    else{
      setState(() {
        Message = "Device Number Invalid";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Padding(
      padding: EdgeInsets.all(10.0),
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Device Registration",
              style: TextStyle(
                fontSize: 28.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Device Number",
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold
              ),
              controller: _deviceNumberController,
            ),

            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),

            FractionallySizedBox(
              widthFactor: 0.9,
              child: new SizedBox(
                height: 45.0,
                child: new RaisedButton(
                  color: Colors.blue,
                  onPressed: _registerDevice,
                  child: new Text(
                    "Register",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white
                    ),
                  ),
                ),
              )
            ),

            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),

            Text(
              "${Message}"
            )
          ],
        ),
      ),
    ));
  }
}
