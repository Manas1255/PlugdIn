import 'package:bloc/bloc.dart';
import 'package:plugdin/features/vendor/search/domain/repositories/vendor_search_repository.dart';
import 'package:plugdin/features/vendor/search/presentation/cubit/state.dart';

class VendorSearchCubit extends Cubit<VendorSearchState> {
  VendorSearchCubit({required this.repository})
    : super(const VendorSearchState());

  final VendorSearchRepository repository;
}
