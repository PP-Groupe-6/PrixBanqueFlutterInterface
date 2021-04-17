class User {
  final String clientId;
  final String fullName;
  final int phoneNumber;
  final String mailAdress;
  final String password;


  User({
    this.clientId,
    this.fullName,
    this.phoneNumber,
    this.mailAdress,
    this.password
    });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      clientId: json['clientId'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as int,
      mailAdress: json['mailAdress'] as String,
      password: json['password'] as String,
    );
  }
}
