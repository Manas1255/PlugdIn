import 'package:hive_flutter/adapters.dart';

part 'role_type.g.dart';

@HiveType(typeId: 2)
enum RoleType {
  @HiveField(0)
  none,
  @HiveField(1)
  customer,
  @HiveField(2)
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
