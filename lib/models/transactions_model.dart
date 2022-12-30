class TransactionsData {
  TransactionsData({
    this.did,
 
    this.amount,
    this.reason,
    this.status,
    this.accBalance,
    this.dateCreated,
    this.type,

  });
  String? did;

  String? amount;
  String? reason;
  String? status;
 
  String? accBalance;
  String? pending;
  String? dateCreated;
 
  String? type;
 



  TransactionsData.fromJson(dynamic json){
    did = json['_did'];
    amount = json['_amount'];
    reason = json['_reason'];
    status = json['_status'];
    accBalance = json['balance'];
    dateCreated = json['_date_created'];
    type = json['type'];
  }

}
