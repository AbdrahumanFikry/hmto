import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:senior/models/startDaySalles.dart';

class InvoiceBody {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  sample({
    String storeName,
    String sellsName,
    String debit,
    List<CarProduct> bill,
    String sale,
    String tax,
    String total,
    String totalAfterTax,
    String transactionId,
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
        bluetooth.printNewLine();
        bluetooth.printCustom("$transactionId", boldLarge, alignCenter);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom("$storeName", normalSize, alignLeft);
        bluetooth.printCustom("By : ", normalSize, alignLeft);
        bluetooth.printCustom("$sellsName", normalSize, alignLeft);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom("*** المنتجات ***", alignCenter, boldLarge);
        bill.forEach((item) {
          double itemTotal = item.quantity * item.priceForEach;
          bluetooth.printNewLine();
          bluetooth.printNewLine();
          bluetooth.printCustom(
              ">${item.productName}  $itemTotal ", normalSize, alignCenter);
          bluetooth.printCustom("${item.quantity} * ${item.priceForEach} ",
              normalSize, alignRight);
//          bluetooth.printCustom("$total", alignLeft, normalSize);
          itemTotal = 0.0;
        });
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom("Sale : $sale", normalSize, alignLeft);
        bluetooth.printCustom("Total : $total", normalSize, alignLeft);
        bluetooth.printCustom("Tax : $tax", normalSize, alignLeft);
        bluetooth.printCustom(
            "AfterTax : $totalAfterTax", normalSize, alignLeft);
        debit == 'noDebit'
            ? bluetooth.printCustom("Cash : $total", normalSize, alignLeft)
            : bluetooth.printCustom("Cash : $debit", normalSize, alignLeft);
        print(
            "Debit :::: ${double.tryParse(totalAfterTax)} ${double.tryParse(debit)}");
        debit == 'noDebit'
            ? bluetooth.printCustom("Debit :  -------", normalSize, alignLeft)
            : bluetooth.printCustom(
                "Debit : ${double.tryParse(totalAfterTax)} ${double.tryParse(debit)}",
                normalSize,
                alignLeft);
        bluetooth.printNewLine();
        bluetooth.printCustom("DateTime : ", normalSize, alignLeft);
        bluetooth.printCustom(
            "${DateTime.now().toIso8601String().split('.')[0]}",
            normalSize,
            alignLeft);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom("Thank you", boldLarge, alignCenter);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
}
