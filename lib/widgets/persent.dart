import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class PercentChanger extends StatelessWidget {
  final double initValue;

  const PercentChanger({
    Key key,
    @required this.initValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
//        gradient: LinearGradient(
//          colors: [Colors.white, Colors.grey[500]],
//          begin: Alignment.bottomLeft,
//          end: Alignment.topRight,
//          tileMode: TileMode.clamp,
//        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SleekCircularSlider(
            onChangeStart: (double value) {
              print(value.round());
            },
            onChangeEnd: (double value) {
              print(value.round());
            },
//              innerWidget: viewModel.innerWidget,
            appearance: CircularSliderAppearance(),
            min: 0,
            max: 100,
            initialValue: initValue,
          ),
          SizedBox(
            height: 50.0,
          ),
          RaisedButton(
            onPressed: () {},
            color: Colors.green,
            elevation: 5.0,
            padding: EdgeInsets.symmetric(
              horizontal: 50.0,
            ),
            child: Text(
              'Done',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
