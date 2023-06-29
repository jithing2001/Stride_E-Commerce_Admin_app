class ProductModel {
  final String ProductName;
  final String ProductPrice;
  final String ProductDes;
  final String ProductCategory;

  final String productImg;

  ProductModel(
      {required this.ProductName,
      required this.ProductPrice,
      required this.ProductDes,
      required this.productImg,
      required this.ProductCategory});

  Map<String, dynamic> toJson() => {
        'productName': ProductName,
        'ProductPrice': ProductPrice,
        'ProductDes': ProductDes,
        'productImg': productImg,
        'productCategory': ProductCategory,
      };
}
