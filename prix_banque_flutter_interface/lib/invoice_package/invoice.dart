import 'dart:convert';


InvoiceList invoiceListFromJson(String str) => InvoiceList.fromJson(json.decode(str));

class InvoiceList {
  List<Invoice> invoicesToPay;
  List<Invoice> invoicesPaid;
  List<Invoice> invoicesExpired;

  InvoiceList(List<Invoice> invoices){
    this.invoicesToPay = invoices.where((element) => element.state=="waiting").toList();
    this.invoicesPaid = invoices.where((element) => element.state=="paid").toList();
    this.invoicesExpired = invoices.where((element) => element.state=="expired").toList();
  }

  factory InvoiceList.fromJson(Map<String, dynamic> json) => InvoiceList(
    List<Invoice>.from(json["invoices"].map((x) => Invoice.fromJson(x))),
  );

  updateListToPay(Invoice invoice){
    if(invoice.state=="waiting") {
      invoicesToPay.remove(invoice);
      invoicesPaid.add(invoice);
      invoice.setState("paid");
    }
  }

  removeExpiredInvoice(Invoice invoice){
    if(invoice.state=="expired") {
      invoicesExpired.remove(invoice);
    }
  }

}

class Invoice {
  final String id;
  final double amount;
  String state;
  final String expirationDate;
  final String withClientName;
  final String withClientEmail;
  final String withClientPhone;

  Invoice({
    this.id,
    this.amount,
    this.state,
    this.expirationDate,
    this.withClientName,
    this.withClientEmail,
    this.withClientPhone
  });

  factory Invoice.fromJson(Map<String, dynamic> json){
    return Invoice(
      id : json['id'] as String,
      amount: json['amount'] as double,
      state: json['state'] as String,
      expirationDate: json['expDate'] as String,
      withClientName: json['withClientName'] as String,
      withClientEmail: json['withClientEmail'] as String,
      withClientPhone: json['withClientPhone'] as String,
    );
  }

  void setState(String s){
    this.state=s;
  }
}