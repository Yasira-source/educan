class SubData {

  final String? id;
  final String? name;
  final String? amount;
final String? access_limit_value;
  final String? access_limit;

  // "store_id" => $category_id,
  // "store_name" => $category_name,
  // "store_location" => $category_slag

  SubData({ this.id, this.name,this.amount,this.access_limit,this.access_limit_value});

  factory SubData.fromJson(Map<String, dynamic> json) {
    return SubData(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      access_limit: json['access_limit'],
      access_limit_value: json['access_limit_value'],

    );
  }
}