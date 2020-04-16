import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior/forceField/forceFieldNavigator.dart';
import 'package:senior/providers/authenticationProvider.dart';
import 'package:senior/sells/sellsNavigator.dart';
import 'package:senior/senior/tabBarForceField.dart';
import 'package:senior/senior/tabBarSells.dart';
import '../widgets/alertDialog.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatefulWidget {
  final Color foregroundColor;

  LoginScreen({
    this.foregroundColor = Colors.teal,
  });

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email, _password;
  bool _isLoading = false;

  Future<void> _login() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false)
            .logIn(email: _email, password: _password);
        switch (Provider.of<Auth>(context, listen: false).type) {
          case 'driver':
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => SellsNavigator(
                  isDriver: true,
                ),
              ),
            );
            break;
          case 'salles_man':
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => SellsNavigator(
                  isDriver: false,
                ),
              ),
            );
            break;
          case 'filed_force_man':
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ForceFieldNavigator(),
              ),
            );
            break;
          case 'sales_senior':
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TabBarScreenSells(),
              ),
            );
            break;
          case 'field_force_senior':
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TabBarForceFieldScreen(),
              ),
            );
            break;
          default:
            GlobalAlertDialog.showErrorDialog('Unknown user!', context);
            break;
        }
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalAlertDialog.showErrorDialog(tr('extra.loginError'), context);
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
                  Colors.white,
                  Colors.white,
                ],
                // whitish to gray
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: ListView(
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
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {
                            _email = value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'hmto@hmto.com',
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
                        child: TextFormField(
                          obscureText: true,
                          onSaved: (value) {
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
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                color: Colors.green,
                                onPressed: _login,
                                child: Text(
                                  tr('login_screen.login_button'),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                //Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 20.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      RaisedButton(
                        child: Text(
                          "عربى",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        color: Colors.green,
                        onPressed: () {
                          EasyLocalization.of(context).locale =
                              Locale("ar", "DZ");
                        },
                      ),
                      Spacer(),
                      RaisedButton(
                        child: Text(
                          "English",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        color: Colors.green,
                        onPressed: () {
                          EasyLocalization.of(context).locale =
                              Locale("en", "US");
                        },
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
