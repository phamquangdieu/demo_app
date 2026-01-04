import 'package:demo_app/features/users/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class UsersState extends Equatable {
  const UsersState();
  @override
  List<Object?> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> allUsers;
  final List<User> filteredUsers;
  final String searchQuery;

  const UsersLoaded({
    required this.allUsers,
    required this.filteredUsers,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [allUsers, filteredUsers, searchQuery];
}

class UsersError extends UsersState {
  final String message;

  const UsersError(this.message);
  @override
  List<Object?> get props => [message];
}

extension UsersLoadedCopy on UsersLoaded {
  UsersLoaded copyWith({
    List<User>? allUsers,
    List<User>? filteredUsers,
    String? searchQuery,
  }) {
    return UsersLoaded(
      allUsers: allUsers ?? this.allUsers,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
