class StoresData {

  final String? id;
  final String? image;


  // "store_id" => $category_id,
  // "store_name" => $category_name,
  // "store_location" => $category_slag

  StoresData({ this.id, this.image});

  factory StoresData.fromJson(Map<String, dynamic> json) {
    return StoresData(
      id: json['id'],
      image: json['image'],

    );
  }
}