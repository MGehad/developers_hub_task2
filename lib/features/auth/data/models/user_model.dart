class UserModel {
  final String email;
  final String name;
  final String password;

  const UserModel({
    required this.email,
    required this.name,
    required this.password,
  });

  Map<String, dynamic> toJson() => {'email': email, 'name': name};

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(email: json['email'], name: json['name'], password: '');
}
