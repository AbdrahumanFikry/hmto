import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior/models/reternedProduct.dart';
import 'package:senior/models/startDaySalles.dart';
import 'package:senior/providers/sellsProvider.dart';

class InvoiceBody {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  sample({
    String storeCode,
    String storeName,
    String sellsName,
    String debit,
    List<CarProduct> bill,
    String sale = '0.0',
    String tax = '0.0',
    String total = '0.0',
    String totalAfterTax = '0.0',
    String transactionId = 'id',
  }) async {
    int normalSize = 0;
    int bold = 1;
    int boldMedium = 2;
    int boldLarge = 3;
    int alignLeft = 0;
    int alignCenter = 1;
    int alignRight = 2;
    totalAfterTax =
        double.tryParse(totalAfterTax).toStringAsFixed(2).toString();
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.printNewLine();
        bluetooth.printCustom("HMTO", boldLarge, alignCenter);
        bluetooth.printNewLine();
        bluetooth.printCustom("$transactionId", boldLarge, alignCenter);
        bluetooth.printNewLine();
        bluetooth.printCustom(
            'StoreCode :' + storeCode ?? '', normalSize, alignCenter);
        bluetooth.printNewLine();

        bluetooth.printCustom("By :   $sellsName", normalSize, alignLeft);
        bluetooth.printNewLine();
        bluetooth.printCustom("*** Products ***", boldLarge, alignCenter);
        bill.forEach((item) {
          double itemTotal = item.quantity * item.priceForEach;
          bluetooth.printNewLine();
          bluetooth.printCustom("${item.quantity} * ${item.priceForEach} ",
              normalSize, alignRight);
          bluetooth.printCustom(
              ">${item.productName}  ${itemTotal.toStringAsFixed(2).toString()} ",
              normalSize,
              alignLeft);
          bluetooth.printCustom("-----------------", normalSize, alignCenter);
          itemTotal = 0.0;
        });
        bluetooth.printNewLine();
        bluetooth.printCustom("Total : $total", normalSize, alignLeft);
        bluetooth.printCustom("Sale : $sale", normalSize, alignLeft);
        bluetooth.printCustom("Tax : $tax %", normalSize, alignLeft);
        bluetooth.printCustom(
            "FinalTotal:$totalAfterTax", normalSize, alignLeft);
        debit == 'noDebit'
            ? bluetooth.printCustom(
                "Cash : $totalAfterTax ", normalSize, alignLeft)
            : bluetooth.printCustom("Cash : $debit", normalSize, alignLeft);
        print(
            "Debit :::: ${double.tryParse(totalAfterTax)} ${double.tryParse(debit)}");
        debit == 'noDebit'
            ? bluetooth.printCustom("Debit :  -------", normalSize, alignLeft)
            : bluetooth.printCustom(
                "Debit :" +
                    (double.tryParse(totalAfterTax) - double.tryParse(debit))
                        .toStringAsFixed(2)
                        .toString(),
                normalSize,
                alignLeft);
        bluetooth.printNewLine();
        bluetooth.printCustom("DateTime : ", normalSize, alignLeft);
        bluetooth.printCustom(
            "${DateTime.now().toIso8601String().split('.')[0]}",
            normalSize,
            alignLeft);
        bluetooth.printNewLine();
        bluetooth.printCustom("Thank you", boldLarge, alignCenter);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }

  sample2({
    String storeCode,
    String storeName,
    String sellsName,
    String paid,
    String oldTotal,
    String total,
    String rest,
    String transactionId = 'id',
  }) async {
    //SIZE
    // 0- normal size text
    // 1- only bold text
    // 2- bold with medium text
    // 3- bold with large text
    //ALIGN
    // 0- ESC_ALIGN_LEFT
    // 1- ESC_ALIGN_CENTER
    // 2- ESC_ALIGN_RIGHT

    int normalSize = 0;
    int bold = 1;
    int boldMedium = 2;
    int boldLarge = 3;
    int alignLeft = 0;
    int alignCenter = 1;
    int alignRight = 2;
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.printNewLine();
        bluetooth.printCustom("HMTO", boldLarge, alignCenter);
        bluetooth.printNewLine();
        bluetooth.printCustom("$transactionId", boldLarge, alignCenter);
        bluetooth.printNewLine();
        bluetooth.printCustom(
            'StoreCode :' + storeCode ?? '', normalSize, alignCenter);
        bluetooth.printNewLine();
        bluetooth.printCustom("By : $sellsName", normalSize, alignLeft);
        bluetooth.printNewLine();
        bluetooth.printCustom("Total: $total", normalSize, alignLeft);
        bluetooth.printCustom("AlreadyPaid: $oldTotal", normalSize, alignLeft);
        bluetooth.printCustom("NewPaid: $paid", normalSize, alignLeft);
        bluetooth.printCustom("Rest: $rest ", normalSize, alignLeft);
        bluetooth.printNewLine();
        bluetooth.printCustom("DateTime : ", normalSize, alignLeft);
        bluetooth.printCustom(
            "${DateTime.now().toIso8601String().split('.')[0]}",
            normalSize,
            alignLeft);
        bluetooth.printNewLine();
        bluetooth.printCustom("Thank you", boldLarge, alignCenter);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }

  cartSample({
    String sellsName,
    List<CarProduct> cart,
  }) async {
    int normalSize = 0;
    int bold = 1;
    int boldMedium = 2;
    int boldLarge = 3;
    int alignLeft = 0;
    int alignCenter = 1;
    int alignRight = 2;
    bluetooth.isConnected.then((isConnected) async {
      if (isConnected) {
        bluetooth.printNewLine();
        bluetooth.printCustom("HMTO", boldLarge, alignCenter);
        bluetooth.printNewLine();
        bluetooth.printCustom("By :   $sellsName", normalSize, alignLeft);
        bluetooth.printNewLine();
        bluetooth.printCustom("*** Cart Products ***", boldLarge, alignCenter);
        cart.forEach((item) {
          double itemTotal = item.quantity * item.priceForEach;
          bluetooth.printNewLine();
          for (var unit in item.units) {
            String name = 'Piece';
            if (unit.actualName.contains('كرتون')) {
              name = 'Cartoon';
            } else if (unit.actualName.contains('علب')) {
              name = 'Box';
            } else {
              name = 'Piece';
            }
            bluetooth.printCustom("${item.quantity ~/ unit.unitCount} ($name) ",
                normalSize, alignRight);
            print(item.quantity % unit.unitCount);
            if (item.quantity % unit.unitCount != 0)
              bluetooth.printCustom(
                  "${item.quantity % unit.unitCount} (Piece) ",
                  normalSize,
                  alignRight);
            break;
          }
          bluetooth.printCustom(
              ">${item.productName}  ${itemTotal.toStringAsFixed(2).toString()} ",
              normalSize,
              alignLeft);
          bluetooth.printCustom("-----------------", normalSize, alignCenter);
//          bluetooth.printCustom("$total", alignLeft, normalSize);
          itemTotal = 0.0;
        });
        bluetooth.printNewLine();
        bluetooth.printCustom("DateTime : ", normalSize, alignLeft);
        bluetooth.printCustom(
            "${DateTime.now().toIso8601String().split('.')[0]}",
            normalSize,
            alignLeft);
        bluetooth.printNewLine();
        bluetooth.printCustom("Thank you", boldLarge, alignCenter);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }

  returnSample({
    String storeCode,
    String sellsName,
    String storeName,
    List<ReturnedProduct> bill,
    BuildContext context,
  }) async {
    int normalSize = 0;
    int boldLarge = 3;
    int alignLeft = 0;
    int alignCenter = 1;
    int alignRight = 2;
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.printNewLine();
        bluetooth.printCustom("HMTO", boldLarge, alignCenter);
        bluetooth.printNewLine();
        bluetooth.printCustom(
            'StoreCode :' + storeCode ?? '', normalSize, alignCenter);
        bluetooth.printNewLine();
        bluetooth.printCustom("By :   $sellsName", normalSize, alignLeft);
        // bluetooth.printCustom("$sellsName", normalSize, alignLeft);
        bluetooth.printNewLine();
        bluetooth.printCustom("*** Products ***", boldLarge, alignCenter);
        bill.forEach((item) {
          bluetooth.printNewLine();
          String name = Provider.of<SellsData>(context, listen: false)
              .getName(id: item.productId);
          bluetooth.printCustom(
              "${item.quantity} * $name ", normalSize, alignRight);
        });
        bluetooth.printNewLine();
        bluetooth.printCustom("DateTime : ", normalSize, alignLeft);
        bluetooth.printCustom(
            "${DateTime.now().toIso8601String().split('.')[0]}",
            normalSize,
            alignLeft);
        bluetooth.printNewLine();
        bluetooth.printCustom("Thank you", boldLarge, alignCenter);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
}
