class LibraryTopicItems {

  final String? id;
  final String? title;
  final String? description;
  final String? link;
  final String? logo;
  final String? forsubscribe;
  final String? chargeAmount;



  LibraryTopicItems({ this.id, this.title,this.description,this.link,this.logo,this.forsubscribe,this.chargeAmount});

  factory LibraryTopicItems.fromJson(Map<String, dynamic> json) {
    return LibraryTopicItems(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      link: json['link'],
      logo: json['logo'],
      forsubscribe: json['forsubscribe'],
      chargeAmount: json['charge'],

    );
  }
}