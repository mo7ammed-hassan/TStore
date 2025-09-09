import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/features/shop/features/all_products/domain/entity/product_entity.dart';

class SortableProductCubit extends Cubit<List<ProductEntity>> {
  SortableProductCubit() : super(const []);

  String sortOption = 'Name';
  String searchQuery = '';
  List<ProductEntity> originalProducts = [];

  void resetProducts(List<ProductEntity> products) {
    if (isClosed) return;
    originalProducts = List.from(products);
    _applyFilters(); 
  }

  void sortProducts(String sortBy) {
    sortOption = sortBy;
    _applyFilters();
  }

  void searchProducts(String query) {
    searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    if (isClosed) return;
    List<ProductEntity> filteredList = List.from(originalProducts);

    if (searchQuery.isNotEmpty) {
      filteredList = filteredList.where((product) {
        return product.title.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    switch (sortOption) {
      case 'Name':
        filteredList.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        filteredList.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        filteredList.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Sale':
        filteredList.sort((a, b) {
          if (a.salePrice != null && b.salePrice != null) {
            return a.salePrice!.compareTo(b.salePrice!);
          } else {
            return a.price.compareTo(b.price);
          }
        });
        break;
      case 'Newest':
        filteredList.sort((a, b) => b.date!.compareTo(a.date!));
        break;
      default:
        filteredList.sort((a, b) => a.title.compareTo(b.title));
    }

    emit(filteredList);
  }
}
