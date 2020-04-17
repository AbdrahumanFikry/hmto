import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:senior/auth/loginScreen.dart';
import '../providers/authenticationProvider.dart';

class AccountInfo extends StatelessWidget {
  final String name;

  AccountInfo({
    @required this.name,
  });

  void _logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (Route<dynamic> route) => false);
    Provider.of<Auth>(context, listen: false).logout();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: 20.0,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            child: Image.asset(
              'assets/user.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 38.3,
            ),
          ),
        ),
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.3,
            height: 0.08 * MediaQuery.of(context).size.height,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.user,
                      color: Colors.green,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        tr('field_force_profile.type'),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => _logout(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.signOutAlt,
                        color: Colors.green,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          tr('login_screen.logout'),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
