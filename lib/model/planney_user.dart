class PlanneyUser {
  String fullName = "";
  String email = "";

  bool get isValid => fullName.isNotEmpty;

  PlanneyUser({
    this.fullName = "",
    this.email = "",
  });

  Map<String, dynamic> toMap() {
    return {
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
