class TransactionsData {
  TransactionsData({
    this.did,
    this.accountNo,
    this.accountName,
    this.paidbyName,
    this.paidbyPhone,
    this.amount,
    this.reason,
    this.status,
    this.accBalance,
    this.dateCreated,
    this.type,
    this.activity,
    this.wallet,
  });
  String? did;
  String? accountNo;
  String? accountName;
  String? authorisedby;
  String? paidbyName;
  String? paidbyPhone;
  String? amount;
  String? reason;
  String? status;
  String? branchName;
  String? accBalance;
  String? pending;
  String? dateCreated;
  String? address;
  String? type;
  String? mdate;
  String? role;
  String? activity;
  String? wallet;


  TransactionsData.fromJson(dynamic json){
    did = json['_did'];
    accountNo = json['_account_no'];
    accountName = json['account_name'];
    paidbyName = json['_paidby_name'];
    paidbyPhone = json['_paidby_phone'];
    amount = json['_amount'];
    reason = json['_reason'];
    status = json['_status'];
    accBalance = json['acc_balance'];
    dateCreated = json['_date_created'];
    wallet = json['wallet'];
    type = json['type'];
    activity = json['activity'];
  }

}
