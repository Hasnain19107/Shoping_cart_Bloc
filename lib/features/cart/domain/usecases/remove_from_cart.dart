import 'package:dartz/dartz.dart';
import 'package:product_cart_app/core/imports/app_imports.dart';
import 'package:product_cart_app/features/cart/domain/repositories/cart_repository.dart';

class RemoveFromCart implements UseCase<void, int> {
  final CartRepository repository;

  RemoveFromCart(this.repository);

  @override
  Future<Either<Failure, void>> call(int productId) async {
    return await repository.removeItem(productId);
  }
}
