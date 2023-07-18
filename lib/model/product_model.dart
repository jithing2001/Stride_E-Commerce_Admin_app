class ProductModel {
  final String productName;
  final String productPrice;
  final String productDes;
  final String ProductCategory;
  final String discountPrice;

  final String productImg;

  ProductModel(
      {required this.productName,
      required this.productPrice,
      required this.discountPrice,
      required this.productDes,
      required this.productImg,
      required this.ProductCategory});

  Map<String, dynamic> toJson() => {
        'productName': productName,
        'productPrice': productPrice,
        'discountPrice':discountPrice,
        'productDes': productDes,
        'productImg': productImg,
        'productCategory': ProductCategory,
      };
}
