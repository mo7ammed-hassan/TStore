class UserEntity {
  final String? userId;
  final String firstName;
  final String lastName;
  final String username;
  final String userEmail;
  final String userPhone;
  final String? profilePicture;

  String get fullName => '$firstName $lastName';

  UserEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.userEmail,
    required this.userPhone,
    required this.profilePicture,
  });

  UserEntity copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    String? username,
    String? userEmail,
    String? userPhone,
    String? profilePicture,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
