import 'package:bloc/bloc.dart';
import 'package:plugdin/features/home/domain/repositories/home_repository.dart';
import 'package:plugdin/features/home/presentation/cubit/state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.repository}) : super(const HomeState());

  final HomeRepository repository;
}
