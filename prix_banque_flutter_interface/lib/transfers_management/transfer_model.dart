
class Transfer {
  final int transferId;
  final String mailAdressTransferPayer;
  final String mailAdressTransferReceiver;
  final String transferAmount;
  final String transferType;
  final String receiverQuestion;
  final String receiverAnswer;
  final String executionTransferDate;

  Transfer(
      {this.transferId,
      this.mailAdressTransferPayer,
      this.mailAdressTransferReceiver,
      this.transferAmount,
      this.transferType,
      this.receiverQuestion,
      this.receiverAnswer,
      this.executionTransferDate});

  factory Transfer.fromJson(Map<String, dynamic> json) {
    return Transfer(
      transferId: json['transferId'] as int,
      mailAdressTransferPayer: json['mailAdressTransferPayer'] as String,
      mailAdressTransferReceiver: json['mailAdressTransferReceiver'] as String,
      transferAmount: json['transferAmount'] as String,
      transferType: json['transferType'] as String,
      receiverQuestion: json['receiverQuestion'] as String,
      receiverAnswer: json['receiverAnswer'] as String,
      executionTransferDate: json['executionTransferDate'] as String,
    );
  }
}
