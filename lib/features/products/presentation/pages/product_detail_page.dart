import 'package:product_cart_app/core/imports/app_imports.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.title.isNotEmpty
              ? widget.product.title
              : 'Product Details',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageCarousel(
              images: widget.product.images,
              fallbackImage: widget.product.thumbnail,
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductHeader(
                    title: widget.product.title,
                    price: widget.product.price,
                    rating: 4.5, // Replace with actual rating if available
                  ),
                  const SizedBox(height: 16),
                  ProductTags(
                    category: widget.product.category,
                    brand: widget.product.brand,
                  ),
                  const SizedBox(height: 16),
                  StockStatus(stock: widget.product.stock),
                  const SizedBox(height: 24),
                  ProductDescription(description: widget.product.description),
                  const SizedBox(height: 24),
                  QuantitySelector(
                    quantity: quantity,
                    maxQuantity: widget.product.stock,
                    onQuantityChanged: (newQuantity) {
                      setState(() {
                        quantity = newQuantity;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ProductActionButtons(
        isInStock: widget.product.stock > 0,
        onAddToCart: () => _addToCart(context),
      ),
    );
  }

  void _addToCart(BuildContext context) {
    for (int i = 0; i < quantity; i++) {
      context.read<CartBloc>().add(AddToCartEvent(widget.product));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$quantity x ${widget.product.title} added to cart'),
        backgroundColor:
            Theme.of(context).colorScheme.primary, // Use theme color
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showWishlistMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Wishlist feature coming soon!'),
        backgroundColor:
            Theme.of(context).colorScheme.secondary, // Use theme color
      ),
    );
  }

  void _showShareMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality coming soon!')),
    );
  }
}
