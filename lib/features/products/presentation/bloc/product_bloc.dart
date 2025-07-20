import 'package:product_cart_app/core/imports/app_imports.dart'; // Add this import

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  List<Product> _allProducts = [];

  ProductBloc({required this.getProducts}) : super(ProductInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<FilterProductsEvent>(_onFilterProducts);
    on<SortProductsEvent>(_onSortProducts);
    on<SearchProductsEvent>(_onSearchProducts);
    on<LoadProductDetailEvent>(_onLoadProductDetail);
    on<ShareProductEvent>(_onShareProduct);
    on<AddToWishlistEvent>(_onAddToWishlist);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await getProducts(NoParams());

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) {
        _allProducts = products;
        final categories = products.map((p) => p.category).toSet().toList()
          ..sort();

        emit(ProductLoaded(
          products: products,
          filteredProducts: products,
          categories: categories,
        ));
      },
    );
  }

  void _onFilterProducts(
    FilterProductsEvent event,
    Emitter<ProductState> emit,
  ) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      List<Product> filtered = _allProducts;

      if (event.category.isNotEmpty && event.category != 'All') {
        filtered = filtered.where((p) => p.category == event.category).toList();
      }

      if (event.minPrice != null) {
        filtered = filtered.where((p) => p.price >= event.minPrice!).toList();
      }

      if (event.maxPrice != null) {
        filtered = filtered.where((p) => p.price <= event.maxPrice!).toList();
      }

      emit(ProductLoaded(
        products: currentState.products,
        filteredProducts: filtered,
        categories: currentState.categories,
      ));
    }
  }

  void _onSortProducts(
    SortProductsEvent event,
    Emitter<ProductState> emit,
  ) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final sorted = List<Product>.from(currentState.filteredProducts);

      switch (event.sortBy) {
        case 'price_asc':
          sorted.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'price_desc':
          sorted.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'name':
          sorted.sort((a, b) => a.title.compareTo(b.title));
          break;
      }

      emit(ProductLoaded(
        products: currentState.products,
        filteredProducts: sorted,
        categories: currentState.categories,
      ));
    }
  }

  void _onSearchProducts(
    SearchProductsEvent event,
    Emitter<ProductState> emit,
  ) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      List<Product> filtered = _allProducts;

      if (event.query.isNotEmpty) {
        filtered = filtered
            .where((product) =>
                product.title
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                product.description
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                product.category
                    .toLowerCase()
                    .contains(event.query.toLowerCase()))
            .toList();
      }

      emit(ProductLoaded(
        products: currentState.products,
        filteredProducts: filtered,
        categories: currentState.categories,
      ));
    }
  }

  Future<void> _onLoadProductDetail(
    LoadProductDetailEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    // If you have a get single product use case, use it here
    // Otherwise, find from existing products
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final product = currentState.products.firstWhere(
        (p) => p.id == event.productId,
        orElse: () => throw Exception('Product not found'),
      );

      emit(ProductDetailLoaded(product: product));
    } else {
      emit(const ProductError('Product not found'));
    }
  }

  Future<void> _onShareProduct(
    ShareProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    // Implement share logic here
    emit(const ProductActionSuccess('Share functionality coming soon!'));
  }

  Future<void> _onAddToWishlist(
    AddToWishlistEvent event,
    Emitter<ProductState> emit,
  ) async {
    // Implement wishlist logic here
    emit(const ProductActionSuccess('Wishlist feature coming soon!'));
  }
}
