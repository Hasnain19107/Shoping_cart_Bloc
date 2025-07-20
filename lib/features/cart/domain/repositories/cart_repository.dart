import 'package:dartz/dartz.dart';
import 'package:product_cart_app/core/imports/app_imports.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItem>>> getCartItems();
  Future<Either<Failure, void>> saveCartItems(List<CartItem> items);
  Future<Either<Failure, void>> addItem(CartItem item);
  Future<Either<Failure, void>> removeItem(int productId);
  Future<Either<Failure, void>> updateQuantity(int productId, int quantity);
  Future<Either<Failure, void>> clearCart();
}
