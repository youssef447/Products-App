import 'package:meal_tracking/core/assets/app_assets.dart';

class UserModel {
  int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String username;
  final UserGender gender;
  final String? image;
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.gender = UserGender.male,
    required this.username,
    this.image,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      username: map['username'] as String,
      gender: UserGender.fromString(map['gender'] as String),
      email: map['email'] as String,
      phone: map['phone'] as String,
      image: map['image'] as String?,
    );
  }
  String get getGenderProfile {
    switch (gender) {
      case UserGender.male:
        return AppAssets.male;
      case UserGender.female:
        return AppAssets.female;
    }
  }
}

enum UserGender {
  male,
  female;

  //admin
  static UserGender fromString(String role) {
    switch (role.toLowerCase()) {
      case 'male':
        return UserGender.male;
      case 'female':
        return UserGender.female;
      default:
        return UserGender.male;
    }
  }
}

extension UserGenderExtension on UserGender {
  String get getName {
    switch (this) {
      case UserGender.male:
        return 'Male';
      case UserGender.female:
        return 'Female';
    }
  }
}
