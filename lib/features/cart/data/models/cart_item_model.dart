import 'package:product_cart_app/core/imports/app_imports.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.product,
    required super.quantity,
  });

  factory CartItemModel.fromEntity(CartItem cartItem) {
    return CartItemModel(
      product: cartItem.product,
      quantity: cartItem.quantity,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    try {
      return CartItemModel(
        product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
        quantity: json['quantity'] as int,
      );
    } catch (e) {
      throw CacheException(
          message: 'Failed to parse cart item from JSON: ${e.toString()}');
    }
  }

  Map<String, dynamic> toJson() {
    try {
      // Always convert to ProductModel for consistent serialization
      final productModel = product is ProductModel
          ? product as ProductModel
          : ProductModel.fromEntity(product);

      return {
        'product': productModel.toJson(),
        'quantity': quantity,
      };
    } catch (e) {
      throw CacheException(
          message: 'Failed to convert cart item to JSON: ${e.toString()}');
    }
  }

  CartItem toEntity() {
    return CartItem(
      product: product,
      quantity: quantity,
    );
  }
}
