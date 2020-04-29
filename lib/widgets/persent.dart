import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/fieldForceProvider.dart';

class PercentChanger extends StatefulWidget {
  final int id;
  final double initValue;

  const PercentChanger({
    Key key,
    @required this.id,
    @required this.initValue,
  }) : super(key: key);

  @override
  _PercentChangerState createState() => _PercentChangerState();
}

class _PercentChangerState extends State<PercentChanger> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String amount = '0';
  int percent = 0;

  void done({
    BuildContext context,
  }) {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      print('::::::' + amount);
      print('::::::' + percent.toString());
      Provider.of<FieldForceData>(context, listen: false).changePercent(
        id: widget.id,
        amount: amount,
        percent: percent.toString(),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
//    Provider.of<FieldForceData>(context, listen: false).maxValue = 100.0;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 50.0,
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                right: 50.0,
                left: 50.0,
                bottom: 20.0,
              ),
              child: TextFormField(
                validator: (value) {
                  if (value != null) {
                    return null;
                  }
                  return 'this field is requred!';
                },
                onSaved: (value) {
                  setState(() {
                    amount = value;
                  });
                },
                focusNode: FocusNode(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: tr('senior_profile.egp'),
                ),
              ),
            ),
            Provider.of<FieldForceData>(context, listen: false).maxValue == 0.0
                ? Center(
                    child: Text(
                      '100 %',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : SleekCircularSlider(
                    onChangeStart: (double value) {
                      print(value.round());
                    },
                    onChangeEnd: (double value) {
                      print(value.round());
                      setState(() {
                        percent = value.round();
                      });
                    },
//              innerWidget: viewModel.innerWidget,
                    appearance: CircularSliderAppearance(),
                    min: 0,
                    max: Provider.of<FieldForceData>(context, listen: false)
                                .maxValue ==
                            0.0
                        ? 1.0
                        : Provider.of<FieldForceData>(context, listen: false)
                            .maxValue,
                    initialValue: widget.initValue,
                  ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 10.0,
              ),
              child: RaisedButton(
                onPressed: () => done(
                  context: context,
                ),
                color: Colors.green,
                elevation: 5.0,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Text(
                  tr('sells_profile.status'),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
