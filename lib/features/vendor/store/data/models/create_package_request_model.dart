class CreatePackageRequestModel {
  const CreatePackageRequestModel({
    required this.title,
    required this.description,
    required this.subprice,
    required this.totalPrice,
    this.vendorEmails = const [],
    this.files = const [],
  });

  final String title;
  final String description;
  final int subprice;
  final int totalPrice;
  final List<String> vendorEmails;
  final List<String> files;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'subprice': subprice,
      'totalPrice': totalPrice,
      'vendorEmails': vendorEmails,
      'files': files,
    };
  }
}

