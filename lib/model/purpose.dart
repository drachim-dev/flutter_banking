enum Purpose { BankTransfer, DirectDebit, StandingOrder, CashWithdrawal }

class PurposeHelper {
  static String getValue(Purpose purpose) {
    switch (purpose) {
      case Purpose.BankTransfer:
        return 'Überweisung';
      case Purpose.DirectDebit:
        return 'Lastschrift';
      case Purpose.StandingOrder:
        return 'Dauerauftrag';
      case Purpose.CashWithdrawal:
        return 'Geldautomat';
      default:
        return '';
    }
  }

  static Purpose fromValue(String value) {
    switch (value) {
      case 'Überweisung':
        return Purpose.BankTransfer;
      case 'Lastschrift':
        return Purpose.DirectDebit;
      case 'Dauerauftrag':
        return Purpose.StandingOrder;
      case 'Geldautomat':
        return Purpose.CashWithdrawal;
      default:
        return Purpose.BankTransfer;
    }
  }
}
