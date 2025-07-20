import 'package:dartz/dartz.dart';
import 'package:product_cart_app/core/imports/app_imports.dart';
import 'package:product_cart_app/features/cart/domain/repositories/cart_repository.dart';

class UpdateQuantity implements UseCase<void, UpdateQuantityParams> {
  final CartRepository repository;

  UpdateQuantity(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateQuantityParams params) async {
    return await repository.updateQuantity(params.productId, params.quantity);
  }
}

class UpdateQuantityParams extends Equatable {
  final int productId;
  final int quantity;

  const UpdateQuantityParams({
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object> get props => [productId, quantity];
}
