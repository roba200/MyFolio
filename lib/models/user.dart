class User {
  final String name;
  final int age;
  final String email;

  User({required this.name, required this.age, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'email': email,
    };
  }
}
