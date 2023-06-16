import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String name;
  final String Lname;
  final String email;
  final String Pass;
  final int? Score;
  final String? id;

  const UserModel({
    this.id,
    this.Score,
    required this.name,
    required this.Lname,
    required this.email,
    required this.Pass,
  });

  toJson() {
    return {
      'Name': name,
      'Last Name': Lname,
      'Email': email,
      'Password': Pass,
      'Score': 0,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      name: data["Name"],
      Lname: data["Last Name"],
      email: data["Email"],
      Pass: data["Password"],
      Score: data["Score"],
    );
  }
}
