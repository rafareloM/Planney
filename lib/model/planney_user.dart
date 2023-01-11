class PlanneyUser {
  final String fullName;
  final String email;

  PlanneyUser({
    required this.fullName,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
    };
  }

  factory PlanneyUser.fromFirestore(Map<String, dynamic> map) {
    return PlanneyUser(
      fullName: map['full_name'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
