import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior/models/answers.dart';
import 'package:senior/providers/fieldForceProvider.dart';

class TrueAndFalse extends StatefulWidget {
  final int index;
  final int qId;
  final String question;
  final List options;

  TrueAndFalse({
    this.index,
    this.qId,
    this.options,
    this.question,
  });

  @override
  _TrueAndFalseState createState() => _TrueAndFalseState();
}

class _TrueAndFalseState extends State<TrueAndFalse> {
  String answer = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            '${widget.index} - ' + widget.question,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: widget.options.length > 2 ? null : 80,
          child: ListView.builder(
            shrinkWrap: widget.options.length > 2 ? true : false,
            physics: widget.options.length > 2
                ? NeverScrollableScrollPhysics()
                : null,
            scrollDirection:
                widget.options.length > 2 ? Axis.vertical : Axis.horizontal,
            itemCount: widget.options.length,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    answer = widget.options[index];
                  });
                  Provider.of<FieldForceData>(context, listen: false).addAnswer(
                    Answer(
                      questionId: widget.qId,
                      answer: widget.options[index],
                    ),
                  );
                },
                child: Container(
                  height: widget.options.length > 2 ? null : 50.0,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20.0),
                  decoration: BoxDecoration(
                    //boxShadow: [BoxShadow()],
                    shape: widget.options.length > 2
                        ? BoxShape.rectangle
                        : BoxShape.circle,
                    color: answer == widget.options[index]
                        ? Colors.blue
                        : Colors.green,
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.options[index],
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // Row(
        //   children: <Widget>[
        //     Spacer(
        //       flex: 16,
        //     ),
        //     InkWell(
        //       splashColor: Colors.transparent,
        //       onTap: () {
        //         widget.onSavedTrue();
        //         setState(() {
        //           answer = 'True';
        //         });
        //       },
        //       child: Container(
        //         height: 50,
        //         width: 50,
        //         decoration: BoxDecoration(
        //           //boxShadow: [BoxShadow()],
        //           shape: BoxShape.circle,
        //           color: answer == 'True' ? Colors.blue : Colors.green,
        //           border: Border.all(
        //             color: Colors.black12,
        //           ),
        //         ),
        //         child: Icon(
        //           Icons.check,
        //           size: 20,
        //           color: Colors.black,
        //         ),
        //       ),
        //     ),
        //     Spacer(
        //       flex: 1,
        //     ),
        //     InkWell(
        //       splashColor: Colors.transparent,
        //       onTap: () {
        //         widget.onSavedFalse();
        //         setState(() {
        //           answer = 'False';
        //         });
        //       },
        //       child: Container(
        //         height: 50,
        //         width: 50,
        //         decoration: BoxDecoration(
        //           //boxShadow: [BoxShadow()],
        //           shape: BoxShape.circle,
        //           color: answer == 'False' ? Colors.blue : Colors.green,
        //           border: Border.all(color: Colors.black12),
        //         ),
        //         child: Icon(
        //           Icons.close,
        //           size: 20,
        //           color: Colors.black,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        Divider(
          endIndent: 30,
          indent: 30,
          height: 40,
        ),
      ],
    );
  }
}
