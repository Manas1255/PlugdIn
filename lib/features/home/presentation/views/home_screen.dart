import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugdin/features/profile/presentation/cubit/cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ProfileCubit>().fetchProfileInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        'Home Screen',
      ),
    );
  }
}
