import 'package:bloc/bloc.dart';
import 'package:plugdin/features/vendor/store/domain/repositories/vendor_store_repository.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';

class VendorStoreCubit extends Cubit<VendorStoreState> {
  VendorStoreCubit({required this.repository})
    : super(const VendorStoreState());

  final VendorStoreRepository repository;
}
