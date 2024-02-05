// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel extends Equatable {
  String? authId;
  String? email;
  String? name;
  String? password;

  AuthModel({
    this.authId,
    this.email,
    this.name,
    this.password,
  });

  AuthModel copyWith({
    String? authId,
    String? email,
    String? name,
    String? password,
  }) =>
      AuthModel(
        authId: authId ?? this.authId,
        email: email ?? this.email,
        name: name ?? this.name,
        password: password ?? this.password,
      );

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        authId: json["authId"],
        email: json["email"],
        name: json["name"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "authId": authId,
        "email": email,
        "name": name,
        "password": password,
      };

  @override
  List<Object?> get props => [];
}
