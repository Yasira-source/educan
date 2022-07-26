class ReferralsData {

  final String? fname;
  final String? phone;
  final String? amount;
  final String? date;


  // "store_id" => $category_id,
  // "store_name" => $category_name,
  // "store_location" => $category_slag

  ReferralsData({ this.fname, this.phone,this.amount,this.date});

  factory ReferralsData.fromJson(Map<String, dynamic> json) {
    return ReferralsData(
      fname: json['fname'],
      phone: json['phone'],
      amount: json['amount'],
      date: json['date'],

    );
  }
}