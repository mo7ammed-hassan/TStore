class UserModel {
  String? userID;
  final String firstName;
  final String lastName;
  final String userEmail;
  final String username;
  final String userPhone;
  final String? profilePicture;
  final String? stripeCustomerId;

  String get fullName => firstName + lastName;

  UserModel({
    this.userID,
    required this.firstName,
    required this.lastName,
    required this.userEmail,
    required this.username,
    required this.userPhone,
    required this.profilePicture,
    this.stripeCustomerId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userID,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': userEmail,
      'phone': userPhone,
      'profilePicture': profilePicture,
      'stripeCustomerId': stripeCustomerId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userId'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      username: map['username'] as String,
      userEmail: map['email'] as String,
      userPhone: map['phone'] as String,
      stripeCustomerId: map.containsKey('stripeCustomerId')
          ? map['stripeCustomerId'] as String
          : null,
      profilePicture:
          map['profilePicture'] != null ? map['profilePicture'] as String : '',
    );
  }
}
