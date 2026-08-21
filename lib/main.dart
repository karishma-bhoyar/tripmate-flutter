import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.dart';
import 'package:flutter_application_tripmate/core/di/service_locator.dart';
import 'package:flutter_application_tripmate/features/bookings/data/booking_store.dart';
import 'package:flutter_application_tripmate/features/favorites/data/favorite_store.dart';
import 'package:flutter_application_tripmate/firebase_options.dart';
import 'package:flutter_application_tripmate/features/search/logic/search_bloc/search_bloc.dart';
import 'package:flutter_application_tripmate/features/search/logic/search_bloc/search_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Initialize Hive
  await Hive.initFlutter();
  await BookingStore.init();
  await FavoriteStore.init();
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
        BlocProvider<SearchBloc>(
          create: (_) => getIt<SearchBloc>()..add(PerformSearchEvent('')),
        ),
      ],
      child: MaterialApp.router(routerConfig: _appRouter.config()),
    );
  }
}
