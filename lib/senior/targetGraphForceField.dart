import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior/providers/seniorProvider.dart';
import 'package:senior/senior/targetGraphSells.dart';
import 'package:senior/widgets/errorWidget.dart';
import 'package:easy_localization/easy_localization.dart';

class TargetGraphForceField extends StatefulWidget {
  @override
  _TargetGraphForceFieldState createState() => _TargetGraphForceFieldState();
}

class _TargetGraphForceFieldState extends State<TargetGraphForceField> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<SeniorData>(context, listen: false)
                  .fieldForceSeniorTarget ==
              null
          ? Provider.of<SeniorData>(context, listen: false).fetchTargetSenior()
          : null,
      builder: (context, dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (dataSnapShot.hasError) {
            return ErrorHandler(
              toDO: () {
                setState(() {
                  Provider.of<SeniorData>(context, listen: false)
                      .fieldForceSeniorTarget = null;
                });
              },
            );
          } else {
            return Consumer<SeniorData>(
              builder: (context, data, child) =>
                  data.fieldForceSeniorTarget.data == null
                      ? Center(
                          child: Text(
                            tr('extra.noTarget'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          ),
                        )
                      : TargetGraphSenior(
                          isFieldForce: true,
                          cash: 0.0,
                          newStores: double.tryParse(
                            data.fieldForceSeniorTarget.data.totalnewStorePer,
                          ),
                          target: 0.0,
                          visits: double.tryParse(
                            data.fieldForceSeniorTarget.data.totalVisitedPer,
                          ),
                          onTab: () async {
                            await Provider.of<SeniorData>(context,
                                    listen: false)
                                .fetchTargetSenior();
                          },
                        ),
            );
          }
        }
      },
    );
  }
}
