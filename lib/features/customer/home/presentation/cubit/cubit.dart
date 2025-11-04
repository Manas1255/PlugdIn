import 'package:bloc/bloc.dart';
import 'package:plugdin/features/customer/home/domain/repositories/customer_home_repository.dart';
import 'package:plugdin/features/customer/home/presentation/cubit/state.dart';

class CustomerHomeCubit extends Cubit<CustomerHomeState> {
  CustomerHomeCubit({required this.repository})
    : super(const CustomerHomeState());

  final CustomerHomeRepository repository;
}
