import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/di/service_locator.dart';
import 'package:flutter_application_tripmate/core/theme/theme_cubit.dart';
import 'package:flutter_application_tripmate/features/bookings/data/booking_store.dart';
import 'package:flutter_application_tripmate/features/bookings/logic/bookings_bloc/bookings_bloc.dart';
import 'package:flutter_application_tripmate/features/bookings/logic/bookings_bloc/bookings_event.dart';
import 'package:flutter_application_tripmate/features/explore/logic/explore_bloc/explore_bloc.dart';
import 'package:flutter_application_tripmate/features/explore/logic/explore_bloc/explore_event.dart';
import 'package:flutter_application_tripmate/features/favorites/data/favorite_store.dart';
import 'package:flutter_application_tripmate/features/favorites/logic/favorites_bloc/favorites_bloc.dart';
import 'package:flutter_application_tripmate/features/favorites/logic/favorites_bloc/favorites_event.dart';
import 'package:flutter_application_tripmate/features/hotels/logic/hotels_bloc/hotels_bloc.dart';
import 'package:flutter_application_tripmate/features/profile/logic/profile_bloc/profile_bloc.dart';
import 'package:flutter_application_tripmate/features/profile/logic/profile_bloc/profile_event.dart';
import 'package:flutter_application_tripmate/features/search/logic/search_bloc/search_bloc.dart';
import 'package:flutter_application_tripmate/features/search/logic/search_bloc/search_event.dart';
import 'package:flutter_application_tripmate/firebase_options.dart';
import 'package:flutter_application_tripmate/view/auth/logic/auth_bloc/auth_bloc.dart';
import 'package:flutter_application_tripmate/view/auth/logic/auth_bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Initialize Hive Stores
  await Hive.initFlutter();
  await Hive.openBox('settings_box');
  await BookingStore.init();
  await FavoriteStore.init();

  // Setup Dependency Injection (GetIt: Dio, DataSources, Repositories, BLoCs)
  setUpServiceLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider<SearchBloc>(
          create: (_) => getIt<SearchBloc>()..add(PerformSearchEvent('')),
        ),
        BlocProvider<ExploreBloc>(
          create: (_) =>
              getIt<ExploreBloc>()..add(const FetchExploreDestinationsEvent()),
        ),
        BlocProvider<HotelsBloc>(
          create: (_) => getIt<HotelsBloc>(),
        ),
        BlocProvider<BookingsBloc>(
          create: (_) => getIt<BookingsBloc>()..add(const FetchBookingsEvent()),
        ),
        BlocProvider<FavoritesBloc>(
          create: (_) =>
              getIt<FavoritesBloc>()..add(const FetchFavoritesEvent()),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) =>
              getIt<ProfileBloc>()..add(const FetchProfileEvent()),
        ),
        BlocProvider<AuthBloc>(
          create: (_) =>
              getIt<AuthBloc>()..add(const AuthCheckRequestedEvent()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: AppColors.backgroundColor,
              primaryColor: AppColors.primaryColor,
              colorScheme: const ColorScheme.light(
                primary: AppColors.primaryColor,
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: const Color(0xFF121212),
              primaryColor: AppColors.primaryColor,
              colorScheme: const ColorScheme.dark(
                primary: AppColors.primaryColor,
                surface: Color(0xFF1E1E1E),
              ),
            ),
            routerConfig: _appRouter.config(),
          );
        },
      ),
    );
  }
}
