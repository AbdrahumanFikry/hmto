import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior/sells/debitInvoices.dart';
import 'package:senior/widgets/alertDialog.dart';
import 'package:senior/widgets/errorWidget.dart';
import 'package:senior/widgets/invoices.dart';
import 'package:senior/widgets/properties.dart';
import '../providers/sellsProvider.dart';

class SellsStore extends StatefulWidget {
  final int id;
  final String storeName;
  final String customerName;
  final String mobile;
  final String landmark;
  final int rate;
  final String imageIn;
  final String imageOut;
  final String imageStoreAds;
  final String imageStoreFront;

  SellsStore({
    this.id,
    this.storeName = 'NULL',
    this.customerName = 'NULL',
    this.mobile = 'NULL',
    this.landmark = 'NULL',
    this.rate = 0,
    this.imageIn = 'NULL',
    this.imageOut = 'NULL',
    this.imageStoreAds = 'NULL',
    this.imageStoreFront = 'NULL',
  });

  @override
  _SellsStoreState createState() => _SellsStoreState();
}

class _SellsStoreState extends State<SellsStore> {
  bool isCash = true;
  int _radioValue = 0;
  bool isLoading = false;

  void _handleRadioValueChange(int value) {
    _radioValue = value;
    setState(() {
      switch (_radioValue) {
        case 0:
          isCash = true;
          break;
        case 1:
          isCash = false;
          break;
      }
    });
    print(':::::' + isCash.toString());
  }

  Future<void> fetchOldInvoices() async {
    try {
      isLoading = true;
      await Provider.of<SellsData>(context, listen: false)
          .fetchOldInvoices(storeId: widget.id);
      isLoading = false;
    } catch (error) {
      GlobalAlertDialog.showErrorDialog(error.toString(), context);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final oldInvoices = Provider.of<SellsData>(context, listen: false);
//    Provider.of<SellsData>(context, listen: false).debitInvoices = null;
    var screenSize = MediaQuery.of(context).size;
    List<String> images = [
      widget.imageIn,
      widget.imageOut,
      widget.imageStoreAds,
      widget.imageStoreFront,
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.storeName,
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
        elevation: 3.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.cashRegister,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OldInvoicesScreen(
                    storeId: widget.id,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          CarouselSlider(
            autoPlay: true,
            scrollPhysics: BouncingScrollPhysics(),
            height: 384 * screenSize.aspectRatio,
            items: images.map((image) {
              return Padding(
                padding: EdgeInsets.all(13 * screenSize.aspectRatio),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    height: 0.3 * screenSize.height,
                    width: screenSize.width,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
            enlargeCenterPage: true,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 33 * screenSize.aspectRatio,
              vertical: 16 * screenSize.aspectRatio,
            ),
            child: ExpandablePanel(
              theme: ExpandableThemeData(
                animationDuration: Duration(
                  milliseconds: 200,
                ),
              ),
              header: Text(
                tr('sells_store.check_out'),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                  fontSize: 33 * screenSize.aspectRatio,
                ),
              ),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio(
                        value: 0,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      Text(
                        tr('sells_store.cash'),
                        style: new TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      Text(
                        tr('sells_store.debit'),
                        style: new TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  Properties(
                    storeId: widget.id,
                    isCash: isCash,
                    isDebit: !isCash,
                    storeName: widget.storeName,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 33 * screenSize.aspectRatio,
              vertical: 16 * screenSize.aspectRatio,
            ),
            child: ExpandablePanel(
              theme: ExpandableThemeData(
                animationDuration: Duration(
                  milliseconds: 200,
                ),
              ),
              header: Text(
                tr('sells_store.return'),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                  fontSize: 33 * screenSize.aspectRatio,
                ),
              ),
              expanded: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  oldInvoices.invoiceError
                      ? ErrorHandler(
                          toDO: () => fetchOldInvoices(),
                        )
                      : oldInvoices.oldInvoices == null
                          ? isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Row(
                                  children: <Widget>[
                                    OutlineButton.icon(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 7.0,
                                        horizontal: 50.0,
                                      ),
                                      onPressed: fetchOldInvoices,
                                      icon: Icon(
                                        FontAwesomeIcons.fileInvoiceDollar,
                                        size: 24.0,
                                        color: Colors.green,
                                      ),
                                      label: Text(
                                        tr('extra.oldInvoice'),
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                )
                          : Invoices(
                              data: oldInvoices.oldInvoices.data,
                            ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
