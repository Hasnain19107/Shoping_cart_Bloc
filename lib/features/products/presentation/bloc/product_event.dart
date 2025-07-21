import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends ProductEvent {}

class FilterProductsEvent extends ProductEvent {
  final String category;
  final double? minPrice;
  final double? maxPrice;

  const FilterProductsEvent({
    required this.category,
    this.minPrice,
    this.maxPrice,
  });

  @override
  List<Object> get props =>
      [category, minPrice ?? Object(), maxPrice ?? Object()];
}

class SortProductsEvent extends ProductEvent {
  final String sortBy;

  const SortProductsEvent({required this.sortBy}); // Named parameter

  @override
  List<Object> get props => [sortBy];
}

class SearchProductsEvent extends ProductEvent {
  final String query;

  const SearchProductsEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class LoadProductDetailEvent extends ProductEvent {
  final int productId;

  const LoadProductDetailEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
