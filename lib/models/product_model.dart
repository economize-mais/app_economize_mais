class ProductModel {
  final String id;
  final String name;
  final String? description;
  final String priceOriginal;
  final String priceOffer;
  final String discountPercent;
  final String? imageUrl;
  final String? offerExpiration;

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        priceOriginal = json['priceOriginal'],
        priceOffer = json['priceOffer'],
        discountPercent = json['discountPercent'],
        imageUrl = json['imageUrl'],
        offerExpiration = json['offerExpiration'];
}
