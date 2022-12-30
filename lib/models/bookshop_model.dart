class BookshopData {
  final String? lid;
  final String? Uclass;
  final String? subject;
  final String? userid;
  final String? type;
  final String? state;
  final String? title;
  final double? price;
  final String? link;
  final String? detail;
  final String? rating;
  final String? filelogo;
  final String? filelogo1;
  final String? filelogo2;
  final String? forsubscribe;
  final String? regularPrice;
  final String? available;
  final String? qty;


  BookshopData(
      {this.lid,
      this.Uclass,
      this.subject,
      this.userid,
      this.type,
      this.state,
      this.title,
      this.price,
      this.link,
      this.detail,
      this.rating,
      this.filelogo,
      this.filelogo1,
      this.filelogo2,
      this.forsubscribe,
      this.regularPrice,
      this.available,
      this.qty,
      });

  factory BookshopData.fromJson(Map<String, dynamic> json) {
    return BookshopData(
      lid: json['_lid'],
      Uclass: json['_class'],
      subject: json['_subject'],
      userid: json['_userid'],
      type: json['_type'],
      state: json['_state'],
      title: json['_title'],
      price: double.parse(json['_price']),
      link: json['_link'],
      detail: json['_detail'],
      rating: json['_rating'],
      filelogo: json['_filelogo'],
      filelogo1: json['_filelogo1'],
      filelogo2: json['_filelogo2'],
      forsubscribe: json['forsubscribe'],
      regularPrice: json['_regularPrice'].toString(),
      available: json['available'].toString(),
      qty: json['qty'].toString(),

   
    );
  }
}
