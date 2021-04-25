class Transactions {
  final String transactionType;
  final String role;
  final String name;
  final double transactionAmount;
  final String transactionDate;

  Transactions(
      {this.transactionType,
      this.role,
      this.name,
      this.transactionAmount,
      this.transactionDate});

  factory Transactions.fromJson(Map<String, dynamic> json) {
    return Transactions(
      transactionType: json['transactionType'] as String,
      role: json['role'] as String,
      name: json['name'] as String,
      transactionAmount: json['transactionAmount'] as double,
      transactionDate: json['transactionDate'] as String,
    );
  }
}
