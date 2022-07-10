class AdvertsData {

  final String? id;
  final String? image;
  final String? link;


  // "store_id" => $category_id,
  // "store_name" => $category_name,
  // "store_location" => $category_slag

  AdvertsData({ this.id, this.image,this.link});

  factory AdvertsData.fromJson(Map<String, dynamic> json) {
    return AdvertsData(
      id: json['id'],
      image: json['image'],
      link: json['link'],

    );
  }
}