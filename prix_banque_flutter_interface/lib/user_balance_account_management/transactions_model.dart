class Transactions {
  final String transactionType;
  final String role;
  final String name;
  final String transactionAmount;
  final String transactionDate;

  Transactions(
      {this.transactionType,
      this.role,
      this.name,
      this.transactionAmount,
      this.transactionDate});

  factory Transactions.fromJson(Map<String, dynamic> json) {
    return Transactions(
      transactionType: json['type'] as String,
      role: json['role'] as String,
      name: json['name'] as String,
      transactionAmount: json['transactionAmount'] as String,
      transactionDate: json['transactionDate'] as String,
    );
  }
}
