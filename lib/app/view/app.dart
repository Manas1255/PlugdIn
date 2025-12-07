import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugdin/app/view/app_view.dart';
import 'package:plugdin/core/locale/cubit/locale_cubit.dart';
import 'package:plugdin/features/customer/home/data/repositories/customer_home_repository_impl.dart';
import 'package:plugdin/features/customer/home/presentation/cubit/cubit.dart';
import 'package:plugdin/features/customer/profile/data/repositories/profile_repository_impl.dart';
import 'package:plugdin/features/customer/profile/presentation/cubit/cubit.dart';
import 'package:plugdin/features/onboarding/data/repositories/onboarding_flow_repository_impl.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/filter/data/repositories/vendor_filter_repository_impl.dart';
import 'package:plugdin/features/vendor/filter/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/home/data/repositories/vendor_home_repository_impl.dart';
import 'package:plugdin/features/vendor/home/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/notifications/data/repositories/vendor_notifications_repository_impl.dart';
import 'package:plugdin/features/vendor/notifications/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/profile/data/repositories/profile_repository_impl.dart';
import 'package:plugdin/features/vendor/profile/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/search/data/repositories/vendor_search_repository_impl.dart';
import 'package:plugdin/features/vendor/search/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/data/repositories/vendor_store_repository_impl.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';

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

        BlocProvider(
          create: (context) => CustomerHomeCubit(
            repository: CustomerHomeRepositoryImpl(),
          ),
        ),

        BlocProvider(
          create: (context) => VendorHomeCubit(
            repository: VendorHomeRepositoryImpl(),
          ),
        ),

        BlocProvider(
          create: (context) => CustomerProfileCubit(
            repository: CustomerProfileRepositoryImpl(),
          ),
        ),

        BlocProvider(
          create: (context) => VendorProfileCubit(
            repository: VendorProfileRepositoryImpl(),
          ),
        ),

        BlocProvider(
          create: (context) => VendorStoreCubit(
            repository: VendorStoreRepositoryImpl(),
          ),
        ),

        BlocProvider(
          create: (context) => VendorNotificationsCubit(
            repository: VendorNotificationsRepositoryImpl(),
          ),
        ),

        BlocProvider(
          create: (context) => VendorSearchCubit(
            repository: VendorSearchRepositoryImpl(),
          ),
        ),

        BlocProvider(
          create: (context) => VendorFilterCubit(
            repository: VendorFilterRepositoryImpl(),
          ),
        ),
      ],
      child: const AppView(),
    );
  }
}
