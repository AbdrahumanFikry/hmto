import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:senior/models/startDaySalles.dart';

class InvoiceBody {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  sample({
    String storeName,
    String sellsName,
    String debit,
    List<CarProduct> bill,
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
    double sum = 0.0;
    bill.forEach((item) {
      double itemTotal = item.quantity * item.priceForEach;
      sum = sum + itemTotal;
    });
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.printNewLine();
        bluetooth.printCustom("HMTO", boldLarge, alignCenter);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom("$storeName", normalSize, alignLeft);
        bluetooth.printCustom("By : ", normalSize, alignLeft);
        bluetooth.printCustom("$sellsName", normalSize, alignLeft);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom("*** المنتجات ***", alignCenter, boldLarge);
        bill.forEach((item) {
          double total = item.quantity * item.priceForEach;
          bluetooth.printNewLine();
          bluetooth.printNewLine();

          bluetooth.printCustom(
              ">${item.productName}  $total ", normalSize, alignCenter);
          bluetooth.printCustom("${item.quantity} * ${item.priceForEach} ",
              normalSize, alignRight);
//          bluetooth.printCustom("$total", alignLeft, normalSize);
          total = 0.0;
        });
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom("Total : $sum", normalSize, alignLeft);
        bluetooth.printCustom("Cash  : $sum", normalSize, alignLeft);
        debit == 'noDebit'
            ? bluetooth.printCustom("Debit :  -------", normalSize, alignLeft)
            : bluetooth.printCustom(
                "Debit : ${sum - int.tryParse(debit)}", normalSize, alignLeft);
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
