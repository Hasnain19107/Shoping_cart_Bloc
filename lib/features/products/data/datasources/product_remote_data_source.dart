import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:product_cart_app/core/constants/app_constants.dart';
import 'package:product_cart_app/features/products/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await client.get(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.productsEndpoint}'),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');
      print(
          'Response body: ${response.body.substring(0, response.body.length > 500 ? 500 : response.body.length)}...');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Check if the response has the expected structure
        if (jsonData is Map<String, dynamic> &&
            jsonData.containsKey('products')) {
          final List<dynamic> productsJson = jsonData['products'];

          return productsJson
              .map((json) {
                try {
                  return ProductModel.fromJson(json);
                } catch (e) {
                  print('Error parsing product: $e');
                  print('Product JSON: $json');
                  // Return a default product or skip this item
                  return null;
                }
              })
              .where((product) => product != null)
              .cast<ProductModel>()
              .toList();
        } else {
          throw Exception('Invalid response format: Expected products array');
        }
      } else {
        throw Exception(
            'Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getProducts: $e');
      throw Exception('Failed to fetch products: $e');
    }
  }
}
