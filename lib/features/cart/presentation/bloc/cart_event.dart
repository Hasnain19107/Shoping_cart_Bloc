import 'package:equatable/equatable.dart';
import 'package:product_cart_app/core/imports/app_imports.dart';
import 'package:product_cart_app/features/products/domain/entities/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final Product product;
  final int quantity;

  const AddToCartEvent(this.product, {this.quantity = 1});

  @override
  List<Object> get props => [product, quantity];
}

class RemoveFromCartEvent extends CartEvent {
  final int productId;
  final String? productTitle;

  const RemoveFromCartEvent(this.productId, {this.productTitle});

  @override
  List<Object> get props => [productId, productTitle ?? ''];
}

class UpdateQuantityEvent extends CartEvent {
  final int productId;
  final int quantity;

  const UpdateQuantityEvent(this.productId, this.quantity);

  @override
  List<Object> get props => [productId, quantity];
}

class ClearCartEvent extends CartEvent {
  final bool showSuccessMessage;

  const ClearCartEvent({this.showSuccessMessage = true});

  @override
  List<Object> get props => [showSuccessMessage];
}

class CartTimeoutEvent extends CartEvent {}

class ResetCartErrorEvent extends CartEvent {}
