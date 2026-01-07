class ProductModel {
  final String id;
  final String name;
  final String? weight;
  final String? unitOfMeasure;
  final String? description;
  final String priceOriginal;
  final String priceOffer;
  final String discountPercent;
  final String? offerStartDate;
  final String? offerExpiration;
  final bool productHasExpirationDate;
  final String? productExpirationDate;
  final String? imageUrl;

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        weight = (json['weight'] is String)
            ? json['weight']
            : json['weight'].toString(),
        unitOfMeasure = json['unitOfMeasure'],
        description = json['description'],
        priceOriginal = (json['priceOriginal'] is String)
            ? json['priceOriginal']
            : json['priceOriginal'].toString(),
        priceOffer = (json['priceOffer'] is String)
            ? json['priceOffer']
            : json['priceOffer'].toString(),
        discountPercent = (json['discountPercent'] is String)
            ? json['discountPercent']
            : json['discountPercent'].toString(),
        offerStartDate = json['offerStartDate'],
        offerExpiration = json['offerExpiration'],
        productHasExpirationDate = json['productHasExpirationDate'] ??
            (json['productExpirationDate'] != null ||
                json['productExpirationDate'] != ''),
        productExpirationDate = json['productExpirationDate'],
        imageUrl = json['imageUrl'];
}
