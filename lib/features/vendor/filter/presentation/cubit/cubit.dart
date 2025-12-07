import 'package:bloc/bloc.dart';
import 'package:plugdin/core/enums/filter_view_type.dart';
import 'package:plugdin/features/vendor/filter/domain/repositories/vendor_filter_repository.dart';
import 'package:plugdin/features/vendor/filter/presentation/cubit/state.dart';

class VendorFilterCubit extends Cubit<VendorFilterState> {
  VendorFilterCubit({required this.repository})
    : super(const VendorFilterState());

  final VendorFilterRepository repository;

  void updateViewType(FilterViewType viewType) {
    emit(
      state.copyWith(
        viewType: viewType,
      ),
    );
  }
}
