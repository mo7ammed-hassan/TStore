import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/core/firebase_collections/collections.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    bool? isFeatured,
    bool? isPopular,
    String? categoryId,
    String? brandId,
    List<String>? productIds,
    int limit = 10,
    DocumentSnapshot? startAfter,
  });
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<ProductModel>> getProducts({
    bool? isFeatured,
    bool? isPopular,
    String? categoryId,
    String? brandId,
    List<String>? productIds,
    int limit = 10,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      if (productIds != null && productIds.isEmpty) {
        return [];
      }

      Query<Map<String, dynamic>> query =
          firestore.collection(FirebaseCollections.PRODUCTS_COLLECTION);

      //  apply filters
      if (isFeatured != null) {
        query = query.where('isFeatured', isEqualTo: isFeatured);
      }

      if (isPopular != null) {
        // query = query.where('isPopular', isEqualTo: isPopular);
      }
      if (categoryId != null) {
        var categorySnapshot = await firestore
            .collection(FirebaseCollections.PRODUCTS_CATEGORY_COLLECTION)
            .where('categoryId', isEqualTo: categoryId)
            .get();

        var ids = categorySnapshot.docs
            .map((doc) => doc['productId'] as String)
            .toList();

        if (ids.isEmpty) return [];
        query = query.where(FieldPath.documentId, whereIn: ids);
      }

      if (brandId != null) {
        query = query.where('brand.id', isEqualTo: brandId);
      }

      if (productIds != null && productIds.isNotEmpty) {
        query = query.where(FieldPath.documentId, whereIn: productIds);
      }

      // pagination
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final snapshot = await query.limit(limit).get();

      return snapshot.docs.map((doc) => ProductModel.fromJson(doc)).toList();
    } catch (e) {
      throw Exception('Firestore error: $e');
    }
  }
}
