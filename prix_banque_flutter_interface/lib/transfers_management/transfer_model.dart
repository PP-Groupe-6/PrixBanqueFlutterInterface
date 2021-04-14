class Transfer {
  final int transferId;
  final int accountTransferPayerId;
  final int accountTransferReceiverId;
  final int transferAmount;
  final String transferType;
  final String receiverQuestion;
  final String receiverAnswer;
  final String scheduledTransferDate;

  Transfer(
      {this.transferId,
      this.accountTransferPayerId,
      this.accountTransferReceiverId,
      this.transferAmount,
      this.transferType,
      this.receiverQuestion,
      this.receiverAnswer,
      this.scheduledTransferDate});

  factory Transfer.fromJson(Map<String, dynamic> json) {
    return Transfer(
      transferId: json['transferId'] as int,
      accountTransferPayerId: json['accountTransferPayerId'] as int,
      accountTransferReceiverId: json['accountTransferReceiverId'] as int,
      scheduledTransferDate: json['scheduledTransferDate'] as String,
      transferAmount: json['transferAmount'] as int,
      transferType: json['transferType'] as String,
      receiverQuestion: json['receiverQuestion'] as String,
      receiverAnswer: json['receiverAnswer'] as String,
    );
  }
}
