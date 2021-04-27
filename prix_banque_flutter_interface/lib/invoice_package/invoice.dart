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
  final int id;
  final int amount;
  String state;
  final String expirationDate;
  final String fromName;
  final String fromEmail;
  final String fromPhone;
  final String toName;
  final String toEmail;
  final String toPhone;

  Invoice({
    this.id,
    this.amount,
    this.state,
    this.expirationDate,
    this.fromName,
    this.fromEmail,
    this.fromPhone,
    this.toName,
    this.toEmail,
    this.toPhone
  });

  factory Invoice.fromJson(Map<String, dynamic> json){
    return Invoice(
      id : json['id'] as int,
      amount: json['amount'] as int,
      state: json['state'] as String,
      expirationDate: json['expDate'] as String,
      fromName: json['fromName'] as String,
      fromEmail: json['fromEmail'] as String,
      fromPhone: json['fromPhone'] as String,
      toName: json['toName'] as String,
      toEmail: json['toEmail'] as String,
      toPhone: json['toPhone'] as String,
    );
  }

  void setState(String s){
    this.state=s;
  }
}