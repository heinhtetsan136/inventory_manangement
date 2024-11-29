import 'package:inventory_management_app/core/db/interface/crud_model.dart';
import 'package:inventory_management_app/repo/product_repo/product_entity.dart';
import 'package:inventory_management_app/repo/product_repo/product_repo.dart';
import 'package:inventory_management_app/repo/variant_repo/variant_entity.dart';
import 'package:inventory_management_app/repo/variant_repo/variant_repo.dart';

abstract class ProductRelatedUseCase<T extends DatabaseModel> {
  const ProductRelatedUseCase();
  Future<Result<T>> createNonVariantProduct(
      ProductParams product, VariantParams variant);
  Future<Result<Product>> getProductDetails(int id);
  Future<Result<Product>> getOneProduct(int id);
  Future<Result<List<Product>>> getProduct();
}

class SqlProductRelatedUseCase extends ProductRelatedUseCase<Product> {
  final SqlProductRepo sqlProductRepo;
  final SqlVariantRepo sqlVariantRepo;

  const SqlProductRelatedUseCase(
      {required this.sqlProductRepo, required this.sqlVariantRepo});

  @override
  Future<Result<Product>> createNonVariantProduct(
      ProductParams product, VariantParams variant) async {
    final productCreateResult = await sqlProductRepo.create(product);
    if (productCreateResult.hasError) {
      return productCreateResult;
    }
    final id = productCreateResult.result!.id;
    variant.productID = id;

    final variantCreateResult = await sqlVariantRepo.create(variant);
    if (variantCreateResult.hasError) {
      final deleteResult = await sqlProductRepo.delete(id);
      if (deleteResult.hasError) {
        return Result(exception: deleteResult.exception);
      }
      return Result(exception: variantCreateResult.exception);
    }
    final productFetchResult = await sqlProductRepo.getOne(id, true);
    if (productFetchResult.hasError) return productFetchResult;
    productFetchResult.result!.variants.add(variantCreateResult.result!);
    return productFetchResult;
  }

  @override
  Future<Result<List<Product>>> getProduct(
      {String? where, int limit = 20, int offset = 0}) {
    return sqlProductRepo.findModel(
        useRef: true, where: where, limit: limit, offset: offset);
  }

  @override
  Future<Result<Product>> getOneProduct(int id) {
    return sqlProductRepo.getOne(id, true);
  }

  @override
  Future<Result<Product>> getProductDetails(int id) async {
    final productResult = await getOneProduct(id);
    if (productResult.hasError) {
      return productResult;
    }
    final variantResult =
        await sqlVariantRepo.findModel(where: '"product_id"=\'$id\'');
    if (variantResult.hasError) {
      return Result(exception: variantResult.exception);
    }
    productResult.result!.variants.addAll(variantResult.result!);
    return productResult;
  }
}
