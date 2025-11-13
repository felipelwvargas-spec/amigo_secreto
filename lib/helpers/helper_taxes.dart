import 'package:amigo_secreto/models/account.dart';

double calculateTaxesByAccount({
  required Account sender,
  required double amount,
}) {
  if (amount < 5000) return 0;
  if (sender.accountType != null) {
    if (sender.accountType!.toUpperCase() == 'AMBROSIA') {
      // tipo de conta Ambrosia
      return amount * 0.005; // 0.5% de taxa
    } else if (sender.accountType!.toUpperCase() == 'CANJICA') {
      return amount * 0.0033; // tipo de conta Canjica // 0.33% de taxa
    } else if (sender.accountType!.toUpperCase() == 'PUDIM') {
      // tipo de conta Pudim // 0.25% de taxa
      return amount * 0.0025;
    } else {
      return amount * 0.0001; // Brigadeiro 0.01% de taxa
    }
  }else{
    return  0.0001; // sem tipo de conta, sem taxa
  }
}
