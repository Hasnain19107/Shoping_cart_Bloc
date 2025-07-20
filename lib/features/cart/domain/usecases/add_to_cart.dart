import 'package:dartz/dartz.dart';
import 'package:product_cart_app/core/imports/app_imports.dart';
import 'package:product_cart_app/features/cart/domain/repositories/cart_repository.dart';

class AddToCart implements UseCase<void, CartItem> {
  final CartRepository repository;

  AddToCart(this.repository);

  @override
  Future<Either<Failure, void>> call(CartItem cartItem) async {
    return await repository.addItem(cartItem);
  }
}
