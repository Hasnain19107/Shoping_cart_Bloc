import 'dart:ffi';
import 'dart:ui';

import 'package:product_cart_app/core/imports/app_imports.dart';
import 'package:product_cart_app/features/cart/presentation/widgets/cart_app_bar.dart';
import 'package:product_cart_app/features/cart/presentation/widgets/cart_body_widget.dart';
import 'package:product_cart_app/features/cart/presentation/widgets/cart_state_listener.dart';
import 'package:product_cart_app/features/cart/presentation/widgets/cart_actions_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cartBloc = context.read<CartBloc>();
      if (cartBloc.state is CartInitial) {
        cartBloc.add(LoadCartEvent());
      }
    });

    return CartStateListener(
      child: Scaffold(
        appBar: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoaded && state.isNotEmpty) {
              return CartAppBar(
                itemCount: state.totalItems,
                onClearCart: () =>
                    CartActionsWidget.showClearCartDialog(context),
              );
            }
            return const CartAppBar();
          },
        ),
        body: CartBodyWidget(
          onCheckout: () => CartActionsWidget.handleCheckout(context),
        ),
      ),
    );
  }
}
