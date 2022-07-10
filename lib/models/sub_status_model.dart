class SubStatusData {

  final String? id;
  final String? names;
  final String? start;
  final String? end;
  final String? status;
  final String? plan;
  final String? planId;
  final String? planLevel;
  final String? left;

  // "store_id" => $category_id,
  // "store_name" => $category_name,
  // "store_location" => $category_slag

  SubStatusData({ this.id, this.names,this.start,this.end,this.status,this.plan,this.planId,this.planLevel,this.left});

  factory SubStatusData.fromJson(Map<String, dynamic> json) {
    return SubStatusData(
      id: json['id'],
      names: json['names'],
      start: json['start'],
      end: json['end'],
      status: json['status'],
      plan: json['plan'],
      planId: json['planId'],
      planLevel: json['planLevel'],
      left: json['left'],

    );
  }
}