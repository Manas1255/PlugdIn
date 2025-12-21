import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/filtered_vendors_response_model.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class CustomerBrowseState extends Equatable {
  const CustomerBrowseState({
    this.filteredVendors = const DataState.initial(),
  });

  final DataState<FilteredVendorsResponseModel> filteredVendors;

  CustomerBrowseState copyWith({
    DataState<FilteredVendorsResponseModel>? filteredVendors,
  }) {
    return CustomerBrowseState(
      filteredVendors: filteredVendors ?? this.filteredVendors,
    );
  }

  @override
  List<Object?> get props => [
    filteredVendors,
  ];
}

