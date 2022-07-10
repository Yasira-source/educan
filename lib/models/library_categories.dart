class LibraryCategoriesData {

  final String? id;
  final String? image;
  final String? code;
  final String? title;


  LibraryCategoriesData({ this.id, this.image,this.code,this.title});

  factory LibraryCategoriesData.fromJson(Map<String, dynamic> json) {
    return LibraryCategoriesData(
      id: json['id'],
      image: json['image'],
      code: json['code'],
      title: json['title'],

    );
  }
}