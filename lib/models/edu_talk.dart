class EduTalkData {

  final String? id;
  final String? title;
  final String? details;
  final String? link;
  final String? logo;
  final String? forsubscribe;


  EduTalkData({ this.id, this.title,this.details,this.link,this.logo,this.forsubscribe});

  factory EduTalkData.fromJson(Map<String, dynamic> json) {
    return EduTalkData(
      id: json['id'],
      title: json['title'],
      details: json['details'],
      link: json['link'],
      logo: json['logo'],
      forsubscribe: json['forsubscribe'],

    );
  }
}