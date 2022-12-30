class ProductsData {

final String? pid;
final String? pname;
final double? pprice;
final String? prprice;
final String? category_id;
final String? pdiscount;
final String? pdesc;
final String? prating;
final String? pimage1;
final String? pimage2;
final String? pimage3;
final String? pimage4;
final String? store_id;
final String? pavailability;
final String? qty;

  ProductsData({ this.pid, this.pname, this.pprice,this.prprice,this.category_id,this.pdiscount,this.pdesc,this.prating,this.pimage1,this.pimage2,this.pimage3,this.pimage4,this.store_id,this.pavailability,this.qty});

  factory ProductsData.fromJson(Map<String, dynamic> json) {
    return ProductsData(
       pid: json['pid'],
        pname: json['pname'],
        pprice: double.parse(json['pprice']),
        prprice: json['prprice'],
        category_id : json['category_id'],
        pdiscount: json['pdiscount'],
        pdesc : json['pdesc'],
        prating : json['prating'],
        pimage1:json['pimage1'],
        pimage2: json['pimage2'],
        pimage3 :json['pimage3'],
        pimage4:json['pimage4'],
        store_id:json['store_id'],
        pavailability:json['pavailability'],
        qty:json['qty'],
    );
  }
}