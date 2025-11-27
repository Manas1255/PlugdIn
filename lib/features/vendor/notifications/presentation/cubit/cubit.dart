import 'package:bloc/bloc.dart';
import 'package:plugdin/features/vendor/notifications/domain/repositories/vendor_notifications_repository.dart';
import 'package:plugdin/features/vendor/notifications/presentation/cubit/state.dart';

class VendorNotificationsCubit extends Cubit<VendorNotificationsState> {
  VendorNotificationsCubit({required this.repository})
    : super(const VendorNotificationsState());

  final VendorNotificationsRepository repository;
}
