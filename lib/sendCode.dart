import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Register Device Page
import 'RegisterDevice.dart';

// Sms Manager
import 'package:sms_maintained/sms.dart';

class sendCode extends StatefulWidget {
  @override
  _sendCodeState createState() => _sendCodeState();
}

class _sendCodeState extends State<sendCode> {

  String Update = "";

  _getDevice() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("mobile");
  }


  // Send Sms Logic
  _sendSms(String Data) async{
    // Init Sms Sender Object
    SmsSender smsSender = new SmsSender();

    // Get Device Number
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String address = prefs.getString("mobile");

    // Send Sms Logic
    // Prepare Message
    SmsMessage smsMessage = new SmsMessage(address, Data);

    // Prepare Listeners
    smsMessage.onStateChanged.listen((state){
      if(state == SmsMessageState.Sent){
        print("Sms Sent");
        Update = "Timer Sent";
        setState(() {

        });
      }
      else{
        print(state);
      }
    });

    // Send Sms
    smsSender.sendSms(smsMessage);

  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Set Timer",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomButton(
                  callback: (){
                    _sendSms("A");
                  },
                  headNumber: "30",
                  suffixString: "Mins",
                ),
                CustomButton(
                  callback: (){
                    _sendSms("B");
                  },
                  headNumber: "1",
                  suffixString: "Hrs",
                )
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 30.0),
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomButton(
                  callback: (){
                    _sendSms("C");
                  },
                  headNumber: "1.5",
                  suffixString: "Hrs",
                ),
                CustomButton(
                  callback: (){
                    _sendSms("D");
                  },
                  headNumber: "2",
                  suffixString: "Hrs",
                )
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            FutureBuilder(
              future: _getDevice(),
              builder: (BuildContext cnxt, AsyncSnapshot snap){
                if(snap.hasData){
                  return Text(
                    "Registered Device : ${snap.data}",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                  );
                }
                else{
                  return Text(
                    "No Data"
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            new FlatButton(
              onPressed: (){
                Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_)=> new RegisterDevice()));
              },
              child: Text(
                "De-Link Device",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),
              color: Colors.redAccent,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            new Text(
              "${Update}",
              style: TextStyle(
                color: Colors.green,
                fontSize: 20.0,
                fontWeight: FontWeight.w600
              ),
            )
          ],
        )
      ),
    );
  }
}


class CustomButton extends StatelessWidget {

  Function callback;
  String headNumber;
  String suffixString;

  CustomButton({this.headNumber,this.suffixString,this.callback});

  @override
  Widget build(BuildContext context) {
    return  new SizedBox(
      height: 100.0,
      width: 100.0,
      child: new RaisedButton(
        onPressed: callback,
        child: new Column(
          children: <Widget>[
            new Text(
              "${headNumber}",
              style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white
              ),
            ),
            new Text(
              "${suffixString}",
              style: TextStyle(
                  color: Colors.white
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        color: Colors.blue,
      ),
    );
  }
}

