// Flutter Core Imports
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter/foundation.dart';

// State Management
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:equatable/equatable.dart';

// Network & Data

export 'package:http/http.dart';
export 'package:shared_preferences/shared_preferences.dart';

// UI Components
export 'package:cached_network_image/cached_network_image.dart';
export 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// Dependency Injection
export 'package:get_it/get_it.dart';

// Core - Constants
export 'package:product_cart_app/core/constants/app_constants.dart';

// Core - Routes
export 'package:product_cart_app/core/routes/app_routes.dart';

// Core - Theme
export 'package:product_cart_app/core/theme/app_theme.dart';

// Core - Error
export 'package:product_cart_app/core/error/failures.dart';
export 'package:product_cart_app/core/error/exceptions.dart';

// Core - Network
export 'package:product_cart_app/core/network/network_info.dart';

// Core - Use Cases
export 'package:product_cart_app/core/usecases/usecase.dart';

// Core - Widgets
export 'package:product_cart_app/core/widgets/exit_confirmation_wrapper.dart';
export 'package:product_cart_app/core/widgets/exit_dialog.dart';

// Core - DI
export 'package:product_cart_app/core/di/injection_container.dart';

// Auth Domain
export 'package:product_cart_app/features/auth/domain/entities/user.dart';
export 'package:product_cart_app/features/auth/domain/repositories/auth_repository.dart';
export 'package:product_cart_app/features/auth/domain/usecases/sign_in.dart';
export 'package:product_cart_app/features/auth/domain/usecases/sign_up.dart';
export 'package:product_cart_app/features/auth/domain/usecases/sign_out.dart';
export 'package:product_cart_app/features/auth/domain/usecases/get_current_user.dart';
export 'package:product_cart_app/features/auth/domain/usecases/check_auth_status.dart';

// Auth Data
export 'package:product_cart_app/features/auth/data/models/user_model.dart';
export 'package:product_cart_app/features/auth/data/repositories/auth_repository_impl.dart';
export 'package:product_cart_app/features/auth/data/datasources/auth_remote_data_source.dart';
export 'package:product_cart_app/features/auth/data/datasources/auth_local_data_source.dart';

// Auth Presentation
export 'package:product_cart_app/features/auth/presentation/bloc/auth_bloc.dart';
export 'package:product_cart_app/features/auth/presentation/bloc/auth_event.dart';
export 'package:product_cart_app/features/auth/presentation/bloc/auth_state.dart';
export 'package:product_cart_app/features/auth/presentation/pages/login_page.dart';
export 'package:product_cart_app/features/auth/presentation/pages/register_page.dart';
export 'package:product_cart_app/features/auth/presentation/widgets/auth_header.dart';
export 'package:product_cart_app/features/auth/presentation/widgets/auth_text_field.dart';
export 'package:product_cart_app/features/auth/presentation/widgets/password_field.dart';
export 'package:product_cart_app/features/auth/presentation/widgets/auth_button.dart';
export 'package:product_cart_app/features/auth/presentation/widgets/auth_text_button.dart';
export 'package:product_cart_app/features/auth/presentation/widgets/guest_button.dart';

// Products Domain
export 'package:product_cart_app/features/products/domain/entities/product.dart';

export 'package:product_cart_app/features/products/domain/repositories/product_repository.dart';
export 'package:product_cart_app/features/products/domain/usecases/get_products.dart';

// Products Data
export 'package:product_cart_app/features/products/data/models/product_model.dart';
export 'package:product_cart_app/features/products/data/repositories/product_repository_impl.dart';
export 'package:product_cart_app/features/products/data/datasources/product_remote_data_source.dart';

// Products Presentation
export 'package:product_cart_app/features/products/presentation/bloc/product_bloc.dart';
export 'package:product_cart_app/features/products/presentation/bloc/product_event.dart';
export 'package:product_cart_app/features/products/presentation/bloc/product_state.dart';
export 'package:product_cart_app/features/products/presentation/pages/product_list_page.dart';
export 'package:product_cart_app/features/products/presentation/pages/product_detail_page.dart';
export 'package:product_cart_app/features/products/presentation/widgets/product_card.dart';
export 'package:product_cart_app/features/products/presentation/widgets/filter_bottom_sheet.dart';
export 'package:product_cart_app/features/products/presentation/widgets/product_image_carousel.dart';
export 'package:product_cart_app/features/products/presentation/widgets/product_header.dart';
export 'package:product_cart_app/features/products/presentation/widgets/product_tags.dart';
export 'package:product_cart_app/features/products/presentation/widgets/stock_status.dart';
export 'package:product_cart_app/features/products/presentation/widgets/product_description.dart';
export 'package:product_cart_app/features/products/presentation/widgets/quantity_selector.dart';
export 'package:product_cart_app/features/products/presentation/widgets/product_action_buttons.dart';

// Cart Domain
export 'package:product_cart_app/features/cart/domain/entities/cart_item.dart';
export 'package:product_cart_app/features/cart/domain/repositories/cart_repository.dart';
export 'package:product_cart_app/features/cart/domain/usecases/get_cart_items.dart';
export 'package:product_cart_app/features/cart/domain/usecases/add_to_cart.dart';
export 'package:product_cart_app/features/cart/domain/usecases/remove_from_cart.dart';
export 'package:product_cart_app/features/cart/domain/usecases/update_quantity.dart';
export 'package:product_cart_app/features/cart/domain/usecases/clear_cart.dart';

// Cart Data
export 'package:product_cart_app/features/cart/data/models/cart_item_model.dart';
export 'package:product_cart_app/features/cart/data/repositories/cart_repository_impl.dart';
export 'package:product_cart_app/features/cart/data/datasources/cart_local_data_source.dart';

// Cart Presentation
export 'package:product_cart_app/features/cart/presentation/bloc/cart_bloc.dart';
export 'package:product_cart_app/features/cart/presentation/bloc/cart_event.dart';
export 'package:product_cart_app/features/cart/presentation/bloc/cart_state.dart';
export 'package:product_cart_app/features/cart/presentation/pages/cart_page.dart';

export 'package:product_cart_app/features/cart/presentation/widgets/cart_state_listener.dart';

export 'package:product_cart_app/features/cart/presentation/widgets/cart_timeout_widget.dart';
export 'package:product_cart_app/features/cart/presentation/widgets/empty_cart_widget.dart';
export 'package:product_cart_app/features/cart/presentation/widgets/guest_notification_banner.dart';
export 'package:product_cart_app/features/cart/presentation/widgets/cart_summary.dart';
export 'package:product_cart_app/features/cart/presentation/widgets/clear_cart_dialog.dart';
export 'package:product_cart_app/features/cart/presentation/widgets/checkout_success_dialog.dart';
export 'package:product_cart_app/features/cart/presentation/widgets/cart_item_widget.dart';
export 'package:product_cart_app/features/cart/presentation/widgets/guest_checkout_dialog.dart';

// Splash Presentation

export 'package:product_cart_app/features/splash/presentation/pages/splash_page.dart';
export 'package:product_cart_app/features/splash/presentation/pages/splash_page.dart';
