// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.status,
    required this.message,
    required this.meta,
  });

  String status;
  String message;
  Meta meta;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    status: json["status"],
    message: json["message"],
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "meta": meta.toJson(),
  };
}

class Meta {
  Meta({
    required this.authorization,
  });

  Authorization authorization;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    authorization: Authorization.fromJson(json["authorization"]),
  );

  Map<String, dynamic> toJson() => {
    "authorization": authorization.toJson(),
  };
}

class Authorization {
  Authorization({
    required this.redirect,
    required this.mode,
  });

  String redirect;
  String mode;

  factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
    redirect: json["redirect"],
    mode: json["mode"],
  );

  Map<String, dynamic> toJson() => {
    "redirect": redirect,
    "mode": mode,
  };
}
