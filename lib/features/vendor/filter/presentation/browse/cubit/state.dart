import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/filtered_vendors_response_model.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class BrowseState extends Equatable {
  const BrowseState({
    this.filteredVendors = const DataState.initial(),
  });

  final DataState<FilteredVendorsResponseModel> filteredVendors;

  BrowseState copyWith({
    DataState<FilteredVendorsResponseModel>? filteredVendors,
  }) {
    return BrowseState(
      filteredVendors: filteredVendors ?? this.filteredVendors,
    );
  }

  @override
  List<Object?> get props => [
    filteredVendors,
  ];
}

