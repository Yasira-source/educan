class SubjectsData {

  final String? id;
  final String? name;
  final String? description;


  SubjectsData({ this.id, this.name, this.description});

  factory SubjectsData.fromJson(Map<String, dynamic> json) {
    return SubjectsData(
      id: json['id'],
      name: json['name'],
      description: json['description'],

    );
  }
}