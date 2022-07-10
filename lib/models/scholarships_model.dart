class ScholarshipData {


  final String? id;
  final String? title;
  final String? description;
  final String? phone;
  final String? address;
  final String? image;
  final String? email;
  final String? website;

  ScholarshipData({ this.id, this.title, this.description,this.phone,this.address,this.image,this.email,this.website});

  factory ScholarshipData.fromJson(Map<String, dynamic> json) {
    return ScholarshipData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      phone: json['phone'],
      address : json['address'],
      image: json['image'],
      email : json['email'],
      website : json['website'],

    );
  }
}