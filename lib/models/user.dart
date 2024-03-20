class UserModel {
  final String name;
  final String role;
  final String email;
  late bool? isPresenter;

  UserModel(
      {required this.name,
      required this.email,
      required this.role,
      this.isPresenter});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      role: json['role'],
      isPresenter: json['isPresenter'] ?? false,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      role: map['role'],
      isPresenter: map['isPresenter'] ?? false,
    );
  }
}
