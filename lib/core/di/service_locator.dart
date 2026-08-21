import 'package:dio/dio.dart';
import 'package:flutter_application_tripmate/features/search/data/datasources/search_api_service.dart';
import 'package:flutter_application_tripmate/features/search/data/repositories/search_repository_impl.dart';
import 'package:flutter_application_tripmate/features/search/domain/repositories/search_repository.dart';
import 'package:flutter_application_tripmate/features/search/logic/search_bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  //external network client
  getIt.registerLazySingleton<Dio>(() => Dio());

  // data source
  getIt.registerLazySingleton<SearchApiService>(
    () => SearchApiService(dio: getIt<Dio>()),
  );

  // repository contract and implementation
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(searchApiService: getIt<SearchApiService>()),
  );
  //bloc(factory create a new instance for per screen)
  getIt.registerFactory<SearchBloc>(
    () => SearchBloc(repository: getIt<SearchRepository>()),
  );
}
