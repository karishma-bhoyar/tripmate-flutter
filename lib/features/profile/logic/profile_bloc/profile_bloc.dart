import 'package:flutter_application_tripmate/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter_application_tripmate/features/profile/logic/profile_bloc/profile_event.dart';
import 'package:flutter_application_tripmate/features/profile/logic/profile_bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<FetchProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await repository.fetchUserProfile();
        emit(ProfileLoaded(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<UpdateProfileEvent>((event, emit) async {
      try {
        await repository.updateUserProfile(event.name, event.phone);
        final profile = await repository.fetchUserProfile();
        emit(ProfileLoaded(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
