class CartData {

  final String? product_id;
  final String? product_name;
  final String? product_regular_price;
  final String? product_sale_price;
  final String? thumbnail;
  final String? qty;
  final String? line_sub_total;
  final String? line_total;


  CartData({ this.product_id, this.product_name,this.product_regular_price,this.product_sale_price,this.thumbnail,this.qty,this.line_sub_total,this.line_total});

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      product_id: json['product_id'],
      product_name: json['product_name'],
      product_regular_price: json['product_regular_price'],
      product_sale_price: json['product_sale_price'],
      thumbnail: json['thumbnail'],
      qty: json['qty'],
      line_sub_total: json['line_sub_total'],
      line_total: json['line_total'],

    );
  }
}