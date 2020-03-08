import 'package:flutter/material.dart';
import 'package:senior/auth/select.dart';
import 'package:senior/senior/SeniorNavigator.dart';
import 'package:senior/seniorAds/seniorAdsNavigator.dart';
import '../widgets/alertDialog.dart';
import 'package:provider/provider.dart';
import '../providers/authenticationProvider.dart';

class LoginScreen extends StatefulWidget {
  final Color backgroundColor1;
  final Color backgroundColor2;
  final Color highlightColor;
  final Color foregroundColor;
  final AssetImage logo;

  LoginScreen({
    Key k,
    this.backgroundColor1 = Colors.white,
    this.backgroundColor2 = Colors.white,
    this.highlightColor = Colors.green,
    this.foregroundColor = Colors.teal,
    this.logo,
  });

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email, _password;
  bool _isLoading = false;

  Future<void> _login() async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      setState(() {
        _isLoading = true;
      });
      try {
//        await Provider.of<Auth>(context, listen: false)
//            .logIn(email: _email, password: _password);
        setState(() {
          _isLoading = false;
        });
//        Provider.of<Auth>(context, listen: false).type == 'Ads'
//            ? Navigator.of(context).pushReplacement(
//                MaterialPageRoute(
//                  builder: (context) => SeniorAdsNavigator(),
//                ),
//              )
//            :
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Select(),
          ),
        );
      } catch (error) {
        GlobalAlertDialog().showErrorDialog(error.toString(), context);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.centerLeft,
                end: new Alignment(1.0, 0.0),
                // 10% of the width, so there are ten blinds.
                colors: [
                  this.widget.backgroundColor1,
                  this.widget.backgroundColor2
                ],
                // whitish to gray
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 80.0, bottom: 50.0),
                  child: Center(
                    child: Container(
                      height: 200.0,
                      width: 200.0,
                      child: Image.asset('assets/appLogo.jpg'),
                    ),
                  ),
                ),
                new Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: this.widget.foregroundColor,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, right: 00.0),
                        child: Icon(
                          Icons.alternate_email,
                          color: this.widget.foregroundColor,
                        ),
                      ),
                      new Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            _email = value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'hnto@hnto.com',
                            hintStyle:
                                TextStyle(color: this.widget.foregroundColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: this.widget.foregroundColor,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, right: 00.0),
                        child: Icon(
                          Icons.lock_open,
                          color: this.widget.foregroundColor,
                        ),
                      ),
                      new Expanded(
                        child: TextField(
                          obscureText: true,
                          onChanged: (value) {
                            _password = value;
                          },
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '*********',
                            hintStyle:
                                TextStyle(color: this.widget.foregroundColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _isLoading
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(
                            left: 40.0, right: 40.0, top: 30.0),
                        alignment: Alignment.center,
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new FlatButton(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                color: this.widget.highlightColor,
                                onPressed: _login,
                                child: Text("Log In",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
