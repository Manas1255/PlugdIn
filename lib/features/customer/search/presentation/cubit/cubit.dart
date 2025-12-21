import 'package:bloc/bloc.dart';
import 'package:plugdin/features/customer/search/domain/repositories/customer_search_repository.dart';
import 'package:plugdin/features/customer/search/presentation/cubit/state.dart';

class CustomerSearchCubit extends Cubit<CustomerSearchState> {
  CustomerSearchCubit({required this.repository})
    : super(const CustomerSearchState());

  final CustomerSearchRepository repository;
}

