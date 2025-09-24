import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store/features/authentication/data/models/user_creation_model.dart';

class SaveUserDataToFirestore {
  static Future<void> saveUserRecord(UserCredential userCredential) async {
    try {
      if (FirebaseAuth.instance.currentUser!.uid.isEmpty) {
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

        final nameParts = userCredential.user!.displayName!.split(' ');
        final userName =
            generateUsername(userCredential.user!.displayName ?? '');

        final userData = UserCreationModel(
          userID: userCredential.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: userName,
          userEmail: userCredential.user!.email ?? '',
          userPhone: userCredential.user!.phoneNumber ?? '',
          profilePicture: userCredential.user!.photoURL ?? '',
        );

        await firebaseFirestore
            .collection('Users')
            .doc(userCredential.user!.uid)
            .set(userData.toMap());
      }
    } on TFirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    }
  }

  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(' ');

    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';

    String username = '${firstName}_$lastName';

    return username;
  }
}
