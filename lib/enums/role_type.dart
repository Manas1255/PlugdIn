enum RoleType {
  none,
  customer,
  vendor;

  String get toName {
    switch (this) {
      case RoleType.none:
        return 'none';
      case RoleType.customer:
        return 'customer';
      case RoleType.vendor:
        return 'vendor';
    }
  }

  String get toDisplayName {
    switch (this) {
      case RoleType.none:
        return 'NONE';
      case RoleType.customer:
        return 'CUSTOMER';
      case RoleType.vendor:
        return 'VENDOR';
    }
  }

  static RoleType toEnum(String value) {
    switch (value.toLowerCase()) {
      case 'none':
        return RoleType.none;
      case 'customer':
        return RoleType.customer;
      case 'vendor':
        return RoleType.vendor;
      default:
        throw ArgumentError('Invalid RoleType: $value');
    }
  }
}
