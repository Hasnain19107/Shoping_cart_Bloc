import 'package:dartz/dartz.dart';
import 'package:product_cart_app/core/imports/app_imports.dart';
import 'package:product_cart_app/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:product_cart_app/features/cart/data/models/cart_item_model.dart';
import 'package:product_cart_app/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<CartItem>>> getCartItems() async {
    try {
      final cartItemModels = await localDataSource.getCartItems();
      final cartItems =
          cartItemModels.map((model) => model.toEntity()).toList();
      return Right(cartItems);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: 'Unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> saveCartItems(List<CartItem> items) async {
    try {
      final cartItemModels =
          items.map((item) => CartItemModel.fromEntity(item)).toList();
      await localDataSource.saveCartItems(cartItemModels);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: 'Unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> addItem(CartItem item) async {
    try {
      final currentItems = await localDataSource.getCartItems();
      final currentCartItems =
          currentItems.map((model) => model.toEntity()).toList();

      // Check if item already exists
      final existingIndex = currentCartItems.indexWhere(
        (cartItem) => cartItem.product.id == item.product.id,
      );

      if (existingIndex != -1) {
        // Update quantity if item exists
        currentCartItems[existingIndex] =
            currentCartItems[existingIndex].copyWith(
          quantity: currentCartItems[existingIndex].quantity + item.quantity,
        );
      } else {
        // Add new item
        currentCartItems.add(item);
      }

      return await saveCartItems(currentCartItems);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: 'Unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> removeItem(int productId) async {
    try {
      final currentItems = await localDataSource.getCartItems();
      final currentCartItems =
          currentItems.map((model) => model.toEntity()).toList();

      currentCartItems.removeWhere((item) => item.product.id == productId);

      return await saveCartItems(currentCartItems);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: 'Unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> updateQuantity(
      int productId, int quantity) async {
    try {
      final currentItems = await localDataSource.getCartItems();
      final currentCartItems =
          currentItems.map((model) => model.toEntity()).toList();

      final itemIndex = currentCartItems.indexWhere(
        (item) => item.product.id == productId,
      );

      if (itemIndex != -1) {
        if (quantity <= 0) {
          currentCartItems.removeAt(itemIndex);
        } else {
          currentCartItems[itemIndex] = currentCartItems[itemIndex].copyWith(
            quantity: quantity,
          );
        }

        return await saveCartItems(currentCartItems);
      }

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: 'Unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try {
      await localDataSource.clearCart();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(CacheFailure(message: 'Unknown error occurred'));
    }
  }
}
