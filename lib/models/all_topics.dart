class TopicsData {

  final String? id;
  final String? name;


  TopicsData({ this.id, this.name});

  factory TopicsData.fromJson(Map<String, dynamic> json) {
    return TopicsData(
      id: json['id'],
      name: json['name'],

    );
  }
}