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
final String? forsubscribe;
final String? regularPrice;

BookshopData({
  this.lid,this.Uclass,this.subject,this.userid,this.type,this.state,this.title,this.price,this.link,this.detail,this.rating,this.filelogo,this.forsubscribe,this.regularPrice
});

  factory BookshopData.fromJson(Map<String, dynamic> json) {
    return BookshopData(
       lid: json['_lid'],
        Uclass: json['_class'],
        subject: json['_subject'],
        userid: json['_userid'],
        type : json['_type'],
        state: json['_state'],
        title : json['_title'],
        price : double.parse(json['_price']),
        link:json['_link'],
        detail: json['_detail'],
        rating :json['_rating'],
        filelogo:json['_filelogo'],
        forsubscribe:json['forsubscribe'],
        regularPrice:json['_regularPrice'].toString(),
    );
  }
}