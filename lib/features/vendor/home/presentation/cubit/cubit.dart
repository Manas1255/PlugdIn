import 'package:bloc/bloc.dart';
import 'package:plugdin/features/vendor/home/domain/repositories/vendor_home_repository.dart';
import 'package:plugdin/features/vendor/home/presentation/cubit/state.dart';

class VendorHomeCubit extends Cubit<VendorHomeState> {
  VendorHomeCubit({required this.repository}) : super(const VendorHomeState());

  final VendorHomeRepository repository;
}
