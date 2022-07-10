class ConsultantsData {

  final String? id;
  final String? name;
  final String? description;
  final String? phone;
  final String? image;


  // "store_id" => $category_id,
  // "store_name" => $category_name,
  // "store_location" => $category_slag

  ConsultantsData({ this.id, this.name,this.description,this.phone,this.image});

  factory ConsultantsData.fromJson(Map<String, dynamic> json) {
    return ConsultantsData(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      phone: json['phone'],
      image: json['image'],

    );
  }
}