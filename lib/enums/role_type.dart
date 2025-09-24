enum RoleType {
  customer,
  vendor;

  String get toName {
    switch (this) {
      case RoleType.customer:
        return 'customer';
      case RoleType.vendor:
        return 'vendor';
    }
  }

  String get toDisplayName {
    switch (this) {
      case RoleType.customer:
        return 'CUSTOMER';
      case RoleType.vendor:
        return 'VENDOR';
    }
  }

  static RoleType toEnum(String value) {
    switch (value.toLowerCase()) {
      case 'customer':
        return RoleType.customer;
      case 'vendor':
        return RoleType.vendor;
      default:
        throw ArgumentError('Invalid RoleType: $value');
    }
  }
}
