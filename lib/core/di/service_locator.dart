import 'package:dio/dio.dart';
import 'package:flutter_application_tripmate/core/network/dio_client.dart';
import 'package:flutter_application_tripmate/features/bookings/data/datasources/bookings_api_service.dart';
import 'package:flutter_application_tripmate/features/bookings/data/repositories/bookings_repository_impl.dart';
import 'package:flutter_application_tripmate/features/bookings/domain/repositories/bookings_repository.dart';
import 'package:flutter_application_tripmate/features/bookings/logic/bookings_bloc/bookings_bloc.dart';
import 'package:flutter_application_tripmate/features/explore/data/datasources/explore_api_service.dart';
import 'package:flutter_application_tripmate/features/explore/data/repositories/explore_repository_impl.dart';
import 'package:flutter_application_tripmate/features/explore/domain/repositories/explore_repository.dart';
import 'package:flutter_application_tripmate/features/explore/logic/explore_bloc/explore_bloc.dart';
import 'package:flutter_application_tripmate/features/favorites/data/datasources/favorites_api_service.dart';
import 'package:flutter_application_tripmate/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:flutter_application_tripmate/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:flutter_application_tripmate/features/favorites/logic/favorites_bloc/favorites_bloc.dart';
import 'package:flutter_application_tripmate/features/hotels/data/datasources/hotels_api_service.dart';
import 'package:flutter_application_tripmate/features/hotels/data/repositories/hotels_repository_impl.dart';
import 'package:flutter_application_tripmate/features/hotels/domain/repositories/hotels_repository.dart';
import 'package:flutter_application_tripmate/features/hotels/logic/hotels_bloc/hotels_bloc.dart';
import 'package:flutter_application_tripmate/features/profile/data/datasources/profile_api_service.dart';
import 'package:flutter_application_tripmate/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:flutter_application_tripmate/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter_application_tripmate/features/profile/logic/profile_bloc/profile_bloc.dart';
import 'package:flutter_application_tripmate/features/search/data/datasources/search_api_service.dart';
import 'package:flutter_application_tripmate/features/search/data/repositories/search_repository_impl.dart';
import 'package:flutter_application_tripmate/features/search/domain/repositories/search_repository.dart';
import 'package:flutter_application_tripmate/features/search/logic/search_bloc/search_bloc.dart';
import 'package:flutter_application_tripmate/view/auth/data/datasources/auth_api_service.dart';
import 'package:flutter_application_tripmate/view/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_application_tripmate/view/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_application_tripmate/view/auth/logic/auth_bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  // 1. External Network Client (Dio)
  getIt.registerLazySingleton<Dio>(() => DioClient().dio);

  // 2. Data Sources (Dio API Services)
  getIt.registerLazySingleton<SearchApiService>(
    () => SearchApiService(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<ExploreApiService>(
    () => ExploreApiService(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<HotelsApiService>(
    () => HotelsApiService(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<BookingsApiService>(
    () => BookingsApiService(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<FavoritesApiService>(
    () => FavoritesApiService(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<ProfileApiService>(
    () => ProfileApiService(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<AuthApiService>(
    () => AuthApiService(dio: getIt<Dio>()),
  );

  // 3. Repositories (Domain Contracts & Implementations)
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(searchApiService: getIt<SearchApiService>()),
  );
  getIt.registerLazySingleton<ExploreRepository>(
    () => ExploreRepositoryImpl(apiService: getIt<ExploreApiService>()),
  );
  getIt.registerLazySingleton<HotelsRepository>(
    () => HotelsRepositoryImpl(apiService: getIt<HotelsApiService>()),
  );
  getIt.registerLazySingleton<BookingsRepository>(
    () => BookingsRepositoryImpl(apiService: getIt<BookingsApiService>()),
  );
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(apiService: getIt<FavoritesApiService>()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(apiService: getIt<ProfileApiService>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(apiService: getIt<AuthApiService>()),
  );

  // 4. BLoCs (Factory instances for UI State Management)
  getIt.registerFactory<SearchBloc>(
    () => SearchBloc(repository: getIt<SearchRepository>()),
  );
  getIt.registerFactory<ExploreBloc>(
    () => ExploreBloc(repository: getIt<ExploreRepository>()),
  );
  getIt.registerFactory<HotelsBloc>(
    () => HotelsBloc(repository: getIt<HotelsRepository>()),
  );
  getIt.registerFactory<BookingsBloc>(
    () => BookingsBloc(repository: getIt<BookingsRepository>()),
  );
  getIt.registerFactory<FavoritesBloc>(
    () => FavoritesBloc(repository: getIt<FavoritesRepository>()),
  );
  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(repository: getIt<ProfileRepository>()),
  );
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(repository: getIt<AuthRepository>()),
  );
}
