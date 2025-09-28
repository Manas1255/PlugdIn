import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugdin/app/view/app_view.dart';
import 'package:plugdin/core/locale/cubit/locale_cubit.dart';
import 'package:plugdin/features/onboarding/data/repositories/onboarding_flow_repository_impl.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit(context: context)),

        BlocProvider(
          create: (context) => OnboardingCubit(
            repository: OnboardingFlowRepositoryImpl(),
          ),
        ),
      ],
      child: const AppView(),
    );
  }
}
