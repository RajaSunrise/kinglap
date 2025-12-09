// Model for User
class User {
  final String id;
  final String name;
  final String email;
  final String password; // Added for auth
  final String role; // 'user' or 'admin'
  final String profilePictureUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.role = 'user',
    required this.profilePictureUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'] ?? '', // Handle existing data without password
      role: json['role'] ?? 'user',
      profilePictureUrl: json['profilePictureUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
