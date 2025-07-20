import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_cart_app/core/imports/app_imports.dart';
import 'package:product_cart_app/features/cart/domain/entities/cart_item.dart';
import 'package:product_cart_app/features/cart/domain/usecases/clear_cart.dart';
import 'package:product_cart_app/features/cart/domain/usecases/get_cart_items.dart';
import 'package:product_cart_app/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:product_cart_app/features/cart/domain/usecases/update_quantity.dart';
import 'package:product_cart_app/features/cart/domain/usecases/add_to_cart.dart';
import 'package:product_cart_app/features/cart/presentation/bloc/cart_event.dart';
import 'package:product_cart_app/features/cart/presentation/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItems getCartItems;
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final UpdateQuantity updateQuantity;
  final ClearCart clearCart;

  Timer? _loadingTimer;

  CartBloc({
    required this.getCartItems,
    required this.addToCart,
    required this.removeFromCart,
    required this.updateQuantity,
    required this.clearCart,
  }) : super(CartInitial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateQuantityEvent>(_onUpdateQuantity);
    on<ClearCartEvent>(_onClearCart);
    on<CartTimeoutEvent>(_onCartTimeout);
    on<ResetCartErrorEvent>(_onResetCartError);
  }

  @override
  Future<void> close() {
    _loadingTimer?.cancel();
    return super.close();
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    if (state is! CartLoaded) {
      emit(CartLoading());

      // Start timeout timer
      _loadingTimer?.cancel();
      _loadingTimer = Timer(const Duration(seconds: 8), () {
        if (!isClosed && state is CartLoading) {
          add(CartTimeoutEvent());
        }
      });
    }

    final result = await getCartItems(NoParams());

    _loadingTimer?.cancel();

    result.fold(
      (failure) {
        emit(CartError('Failed to load cart: ${failure.message}'));
        // Auto recover to empty cart after error
        Timer(const Duration(seconds: 2), () {
          if (!isClosed) {
            emit(const CartLoaded(items: []));
          }
        });
      },
      (items) => emit(CartLoaded(items: items)),
    );
  }

  Future<void> _onAddToCart(
      AddToCartEvent event, Emitter<CartState> emit) async {
    final cartItem = CartItem(product: event.product, quantity: event.quantity);

    final result = await addToCart(cartItem);

    result.fold(
      (failure) {
        emit(CartError('Failed to add item to cart: ${failure.message}'));
        add(LoadCartEvent());
      },
      (_) {
        emit(CartOperationSuccess(
          '${event.product.title} added to cart',
          state is CartLoaded
              ? (state as CartLoaded)
              : const CartLoaded(items: []),
        ));
        add(LoadCartEvent());
      },
    );
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    final result = await removeFromCart(event.productId);

    result.fold(
      (failure) {
        emit(CartError('Failed to remove item: ${failure.message}'));
        add(LoadCartEvent());
      },
      (_) {
        final productTitle = event.productTitle ?? 'Item';
        emit(CartOperationSuccess(
          '$productTitle removed from cart',
          state is CartLoaded
              ? (state as CartLoaded)
              : const CartLoaded(items: []),
        ));
        add(LoadCartEvent());
      },
    );
  }

  Future<void> _onUpdateQuantity(
      UpdateQuantityEvent event, Emitter<CartState> emit) async {
    final params = UpdateQuantityParams(
      productId: event.productId,
      quantity: event.quantity,
    );

    final result = await updateQuantity(params);

    result.fold(
      (failure) {
        emit(CartError('Failed to update quantity: ${failure.message}'));
        add(LoadCartEvent());
      },
      (_) {
        add(LoadCartEvent());
      },
    );
  }

  Future<void> _onClearCart(
      ClearCartEvent event, Emitter<CartState> emit) async {
    final result = await clearCart(NoParams());

    result.fold(
      (failure) {
        emit(CartError('Failed to clear cart: ${failure.message}'));
      },
      (_) {
        if (event.showSuccessMessage) {
          emit(const CartOperationSuccess(
            'Cart cleared successfully',
            CartLoaded(items: []),
          ));
        } else {
          emit(const CartLoaded(items: []));
        }
      },
    );
  }

  Future<void> _onCartTimeout(
      CartTimeoutEvent event, Emitter<CartState> emit) async {
    emit(const CartLoaded(items: [], isTimeoutReached: true));
  }

  Future<void> _onResetCartError(
      ResetCartErrorEvent event, Emitter<CartState> emit) async {
    if (state is CartError) {
      emit(const CartLoaded(items: []));
    }
  }
}
