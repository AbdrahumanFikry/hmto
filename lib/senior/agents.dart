import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Agents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Agents',
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
        elevation: 3.0,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (ctx, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text('User'),
                        Spacer(),
                        Text(
                          '20',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'visit',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            'https://specials-images.forbesimg.com/imageserve/5d2893a234a5c400084b2955/1920x0.jpg?cropX1=29&cropX2=569&cropY1=20&cropY2=560',
                        width: 50.0,
                        height: 50.0,
                      ),
                    ),
                  ),
                  Divider(
                    height: 2,
                    indent: 0,
                    endIndent: 50,
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
