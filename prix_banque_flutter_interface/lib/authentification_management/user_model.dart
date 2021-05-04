class User {
  final String clientId;
  final String fullName;
  final String phoneNumber;
  final String mailAdress;


  User({
    this.clientId,
    this.fullName,
    this.phoneNumber,
    this.mailAdress,
    });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'] as String,
      mailAdress: json['mailAdress'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }
}
