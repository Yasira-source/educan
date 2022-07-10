// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        this.data,
        this.success,
        this.statusCode,
        this.code,
        this.message,
        this.id,
        this.phone,
        this.email,
        this.roles,
        this.displayName,
    });

    Data? data;
    bool? success;
    String? statusCode;
    String? code;
    String? message;
    String? id;
    String? phone;
    String? email;
    String? roles;
    String? displayName;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        data: Data.fromJson(json["data"]),
        success: json["success"],
        statusCode: json["statusCode"],
        code: json["code"],
        message: json["message"],
        id: json["id"],
        phone: json["phone"],
        email: json["email"],
        roles: json["roles"],
        displayName: json["display_name"],
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "success": success,
        "statusCode": statusCode,
        "code": code,
        "message": message,
        "id": id,
        "phone": phone,
        "email": email,
        "roles": roles,
        "display_name": displayName,
    };
}

class Data {
    Data({
        required this.the0,
    });

    The0 the0;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        the0: The0.fromJson(json["0"]),
    );

    Map<String, dynamic> toJson() => {
        "0": the0.toJson(),
    };
}

class The0 {
    The0({
        this.id,
        this.phone,
        this.email,
        this.roles,
        this.displayName,
    });

    String? id;
    String? phone;
    String? email;
    String? roles;
    String? displayName;

    factory The0.fromJson(Map<String, dynamic> json) => The0(
        id: json["id"],
        phone: json["phone"],
        email: json["email"],
        roles: json["roles"],
        displayName: json["display_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "roles": roles,
        "display_name": displayName,
    };
}
