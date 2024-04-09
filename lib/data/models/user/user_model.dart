class UserModel {
  final int id;
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      avatar: json['avatar'] as String,
    );
  }

  factory UserModel.empty() => UserModel(
        id: 0,
        email: '',
        password: '',
        name: '',
        role: '',
        avatar: '',
      );

  UserModel copyWith({
    int? id,
    String? email,
    String? password,
    String? name,
    String? role,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
    );
  }
}

//response
//
// {
// "id": 1,
// "email": "john@mail.com",
// "password": "changeme",
// "name": "Jhon",
// "role": "customer",
// "avatar": "https://api.lorem.space/image/face?w=640&h=480&r=867"
// }
