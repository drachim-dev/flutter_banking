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
}
