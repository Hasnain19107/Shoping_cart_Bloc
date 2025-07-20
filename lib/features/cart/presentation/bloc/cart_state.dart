import 'package:equatable/equatable.dart';
import 'package:product_cart_app/features/cart/domain/entities/cart_item.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;
  final bool isTimeoutReached;

  const CartLoaded({
    required this.items,
    this.isTimeoutReached = false,
  });

  // Calculated getters
  double get totalAmount {
    return items.fold(
        0.0, (total, item) => total + (item.product.price * item.quantity));
  }

  int get totalItems {
    return items.fold(0, (total, item) => total + item.quantity);
  }

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  CartLoaded copyWith({
    List<CartItem>? items,
    bool? isTimeoutReached,
  }) {
    return CartLoaded(
      items: items ?? this.items,
      isTimeoutReached: isTimeoutReached ?? this.isTimeoutReached,
    );
  }

  @override
  List<Object> get props => [items, isTimeoutReached];
}

class CartError extends CartState {
  final String message;
  final bool shouldShowDialog;

  const CartError(
    this.message, {
    this.shouldShowDialog = false,
  });

  @override
  List<Object> get props => [message, shouldShowDialog];
}

class CartOperationSuccess extends CartState {
  final String message;
  final CartLoaded updatedCart;

  const CartOperationSuccess(
    this.message,
    this.updatedCart,
  );

  @override
  List<Object> get props => [message, updatedCart];
}
