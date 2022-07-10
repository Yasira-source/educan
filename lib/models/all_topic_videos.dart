class TopicsVideosData {

  final String? id;
  final String? title;
  final String? details;
  final String? link;
  final String? logo;
  final String? forsubscribe;


  TopicsVideosData({ this.id, this.title,this.details,this.link,this.logo,this.forsubscribe});

  factory TopicsVideosData.fromJson(Map<String, dynamic> json) {
    return TopicsVideosData(
      id: json['id'],
      title: json['title'],
      details: json['details'],
      link: json['link'],
      logo: json['logo'],
      forsubscribe: json['forsubscribe'],

    );
  }
}