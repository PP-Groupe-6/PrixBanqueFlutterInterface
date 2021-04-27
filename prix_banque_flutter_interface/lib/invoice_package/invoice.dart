import 'dart:convert';


InvoiceList invoiceListFromJson(String str) => InvoiceList.fromJson(json.decode(str));

class InvoiceList {
  List<Invoice> invoicesToPay;
  List<Invoice> invoicesPaid;
  List<Invoice> invoicesExpired;

  InvoiceList(List<Invoice> invoices){
    this.invoicesToPay = invoices.where((element) => element.state=="Pending").toList();
    this.invoicesPaid = invoices.where((element) => element.state=="Paid").toList();
    this.invoicesExpired = invoices.where((element) => element.state=="Expired").toList();
  }

  factory InvoiceList.fromJson(Map<String, dynamic> json) => InvoiceList(
    List<Invoice>.from(json["invoices"].map((x) => Invoice.fromJson(x))),
  );

  updateListToPay(Invoice invoice){
    if(invoice.state=="Pending") {
      invoicesToPay.remove(invoice);
      invoicesPaid.add(invoice);
      invoice.setState("Paid");
    }
  }

  removeExpiredInvoice(Invoice invoice){
    if(invoice.state=="Expired") {
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
      id : json['InvoiceID'] as String,
      amount: double.parse(json['amount'] as String),
      state: json['state'] as String,
      expirationDate: json['expDate'] as String,
      withClientName: json['name'] as String,
      withClientEmail: json['mail'] as String,
      withClientPhone: json['phone'] as String,
    );
  }

  void setState(String s){
    this.state=s;
  }
}