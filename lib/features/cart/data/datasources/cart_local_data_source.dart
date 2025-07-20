import 'dart:convert';
import 'package:product_cart_app/core/imports/app_imports.dart';
import 'package:product_cart_app/features/cart/data/models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<void> saveCartItems(List<CartItemModel> items);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String cartKey = 'CART_ITEMS';

  CartLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CartItemModel>> getCartItems() async {
    try {
      final jsonString = sharedPreferences.getString(cartKey);

      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      final List<CartItemModel> cartItems = [];

      for (var jsonItem in jsonList) {
        try {
          final cartItem =
              CartItemModel.fromJson(jsonItem as Map<String, dynamic>);
          cartItems.add(cartItem);
        } catch (e) {
          // Skip corrupted items but continue processing
          print('Warning: Skipping corrupted cart item: $e');
        }
      }

      return cartItems;
    } catch (e) {
      // If data is completely corrupted, clear it and return empty cart
      print('Cart data corrupted, clearing cart: $e');
      await clearCart();
      return [];
    }
  }

  @override
  Future<void> saveCartItems(List<CartItemModel> items) async {
    try {
      final List<Map<String, dynamic>> jsonList = [];

      for (var item in items) {
        try {
          jsonList.add(item.toJson());
        } catch (e) {
          // Skip items that can't be serialized
          print('Warning: Skipping item that cannot be serialized: $e');
        }
      }

      final jsonString = json.encode(jsonList);
      await sharedPreferences.setString(cartKey, jsonString);
    } catch (e) {
      throw CacheException(
          message: 'Failed to save cart items to cache: ${e.toString()}');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await sharedPreferences.remove(cartKey);
    } catch (e) {
      throw CacheException(
          message: 'Failed to clear cart from cache: ${e.toString()}');
    }
  }
}
