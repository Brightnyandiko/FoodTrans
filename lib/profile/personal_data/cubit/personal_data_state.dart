// lib/personal_data/cubit/personal_data_state.dart
part of 'personal_data_cubit.dart';

abstract class PersonalDataState extends Equatable {
  const PersonalDataState();

  @override
  List<Object?> get props => [];
}

class PersonalDataInitial extends PersonalDataState {}

class PersonalDataLoading extends PersonalDataState {}

class PersonalDataLoaded extends PersonalDataState {
  const PersonalDataLoaded({
    required this.user,
    this.isEdited = false,
  });

  final UserProfile user;
  final bool isEdited;

  PersonalDataLoaded copyWith({
    UserProfile? user,
    bool? isEdited,
  }) {
    return PersonalDataLoaded(
      user: user ?? this.user,
      isEdited: isEdited ?? this.isEdited,
    );
  }

  @override
  List<Object> get props => [user, isEdited];
}

class PersonalDataSaving extends PersonalDataState {
  const PersonalDataSaving(this.user);

  final UserProfile user;

  @override
  List<Object> get props => [user];
}

class PersonalDataSaved extends PersonalDataState {
  const PersonalDataSaved(this.user);

  final UserProfile user;

  @override
  List<Object> get props => [user];
}

class PersonalDataImageUploading extends PersonalDataState {
  const PersonalDataImageUploading(this.user);

  final UserProfile user;

  @override
  List<Object> get props => [user];
}

class PersonalDataError extends PersonalDataState {
  const PersonalDataError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}