class VendorOnboardingRequestModel {
  VendorOnboardingRequestModel({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    required this.companyName,
    required this.personName,
    required this.address,
    required this.city,
    required this.phoneNumber,
    required this.primaryCategory,
    required this.businessDescription,
    this.companyLogo,
    this.additionalCategories,
    this.links,
  });
  final String name;
  final String username;
  final String email;
  final String password;
  final String companyName;
  final String? companyLogo;
  final String personName;
  final String address;
  final String city;
  final String phoneNumber;
  final String primaryCategory;
  final List<String>? additionalCategories;
  final List<String>? links;
  final String businessDescription;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'companyName': companyName,
      if (companyLogo != null) 'companyLogo': companyLogo,
      'personName': personName,
      'address': address,
      'city': city,
      'phoneNumber': phoneNumber,
      'primaryCategory': primaryCategory,
      if (additionalCategories != null)
        'additionalCategories': additionalCategories,
      if (links != null) 'links': links,
      'businessDescription': businessDescription,
    };
  }
}
