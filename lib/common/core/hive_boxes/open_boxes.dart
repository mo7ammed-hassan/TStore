import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class OpenBoxes {
  Future<Box> openUserWishlistBox({required String userID}) async {
    // Open the user's main box
    Box userBox = await Hive.openBox(userID);

    if (!Hive.isBoxOpen(userID)) {
      await Hive.openBox(userID);
    }

    // Get or create the wishlist box name
    String wishlistBoxName =
        userBox.get('WISHLIST', defaultValue: 'wishlist_$userID');
    await userBox.put('WISHLIST', wishlistBoxName);

    if (!Hive.isBoxOpen(wishlistBoxName)) {
      await Hive.openBox(wishlistBoxName);
    }

    return Hive.box(wishlistBoxName);
    // //Ensure the user has a wishlist
    // if (!userBox.containsKey('WISHLIST')) {
    //   userBox.put('WISHLIST', 'wishlist_$userID');
    //   await Hive.openBox('wishlist_$userID');
    // }
    // return await Hive.openBox('wishlist_$userID');
  }

  // colse Boxes:
  Future<void> closeUserWishlistBox({required String userID}) async {
    await Hive.box(userID).close();
    await Hive.box('wishlist_$userID').close();
  }

  Future<void> initializeUserBox() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await openUserWishlistBox(userID: FirebaseAuth.instance.currentUser!.uid);
    }
  }
}
