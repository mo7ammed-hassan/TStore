import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:t_store/features/personalization/pages/address/data/models/address_model.dart';
import 'package:t_store/features/shop/features/all_brands/data/models/brand_model.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_attribute_model.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_model.dart';
import 'package:t_store/features/shop/features/all_products/data/models/product_variation_model.dart';
import 'package:t_store/features/shop/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/features/shop/features/cart/data/models/product_cart_item_model.dart';
import 'package:t_store/features/shop/features/home/domain/entites/category_entity.dart';
import 'package:t_store/features/shop/features/wishlist/data/model/wishlist_model.dart';

void rgisterAdapters() {
  if (!Hive.isAdapterRegistered(ProductModelAdapter().typeId)) {
    Hive.registerAdapter(ProductModelAdapter());
  }
  if (!Hive.isAdapterRegistered(BrandModelAdapter().typeId)) {
    Hive.registerAdapter(BrandModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ProductAttributeModelAdapter().typeId)) {
    Hive.registerAdapter(ProductAttributeModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ProductVariationModelAdapter().typeId)) {
    Hive.registerAdapter(ProductVariationModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ProductCartItemModelAdapter().typeId)) {
    Hive.registerAdapter(ProductCartItemModelAdapter());
  }

  // Register Adapters with duplicate check
  if (!Hive.isAdapterRegistered(CategoryEntityAdapter().typeId)) {
    Hive.registerAdapter(CategoryEntityAdapter());
  }
  if (!Hive.isAdapterRegistered(WishlistModelAdapter().typeId)) {
    Hive.registerAdapter(WishlistModelAdapter());
  }

  if (!Hive.isAdapterRegistered(CartItemModelAdapter().typeId)) {
    Hive.registerAdapter(CartItemModelAdapter());
  }

  if (!Hive.isAdapterRegistered(AddressModelAdapter().typeId)) {
    Hive.registerAdapter(AddressModelAdapter());
  }
}
