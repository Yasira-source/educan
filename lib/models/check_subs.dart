class SubsData {

  final String? limit;
  final int? plan;




  SubsData({ this.limit, this.plan});

  factory SubsData.fromJson(Map<String, dynamic> json) {
    return SubsData(
      limit: json['limit'],
      plan: json['plan'],


    );
  }
}