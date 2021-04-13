import 'dart:convert';

import 'package:tuple/tuple.dart';

InvoiceList invoiceListFromJson(String str) => InvoiceList.fromJson(json.decode(str));

class InvoiceList {
  List<Invoice> invoicesToPay;
  List<Invoice> invoicesPaid;

  InvoiceList(List<Invoice> invoices){
    this.invoicesToPay = invoices.where((element) => element.state=="waiting").toList();
    this.invoicesPaid = invoices.where((element) => element.state=="paid").toList();
  }

  factory InvoiceList.fromJson(Map<String, dynamic> json) => InvoiceList(
    List<Invoice>.from(json["invoices"].map((x) => Invoice.fromJson(x))),
  );
}

class Invoice {
  final int id;
  final int amount;
  final String state;
  final String expirationDate;
  final String clientToPay;
  final String email;
  final String phoneNumber;

  Invoice({this.id, this.amount, this.state, this.expirationDate, this.clientToPay, this.email, this.phoneNumber});

  factory Invoice.fromJson(Map<String, dynamic> json){
    return Invoice(
      id : json['id'] as int,
      amount: json['amount'] as int,
      state: json['state'] as String,
      expirationDate: json['expDate'] as String,
      clientToPay: json['payto'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone'] as String,
    );
  }
}