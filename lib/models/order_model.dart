class OrdersData {

  final String? cid;
  final String? oid;
  final String? status;
  final String? orderKey;
  final String? date;
  final String? image;
  final String? name;



  OrdersData({ this.cid, this.oid,this.status,this.orderKey,this.date,this.image,this.name});

  factory OrdersData.fromJson(Map<String, dynamic> json) {
    return OrdersData(
      cid: json['customerId'],
      oid: json['orderId'],
      status: json['status'],
      orderKey: json['order_key'],
      date: json['date_created'],
      image: json['image'],
      name: json['name'],

    );
  }
}