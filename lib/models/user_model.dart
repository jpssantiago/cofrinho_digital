class UserModel {
  String name;

  UserModel({
    required this.name,
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
    );
  }

  static Map<String, dynamic> toMap(UserModel user) {
    return {
      'name': user.name,
    };
  }
}
