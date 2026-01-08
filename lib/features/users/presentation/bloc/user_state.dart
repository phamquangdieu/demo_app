import 'package:demo_app/features/users/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class UsersState extends Equatable {
  const UsersState();
  @override
  List<Object?> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {
  final String searchQuery;
  const UsersLoading({this.searchQuery = ''});
  @override
  List<Object?> get props => [searchQuery];
}

class UsersLoaded extends UsersState {
  final List<User> users;
  final String searchQuery;
  final int currentPage;
  final bool hasReachedMax;
  final String? errorMsg;

  const UsersLoaded({
    required this.users,
    this.searchQuery = '',
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.errorMsg,
  });

  @override
  List<Object?> get props => [
    users,
    searchQuery,
    currentPage,
    hasReachedMax,
    errorMsg,
  ];

  UsersLoaded copyWith({
    List<User>? users,
    String? searchQuery,
    int? currentPage,
    bool? hasReachedMax,
    String? errorMsg,
  }) {
    return UsersLoaded(
      users: users ?? this.users,
      searchQuery: searchQuery ?? this.searchQuery,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMsg: errorMsg,
    );
  }
}

class UsersError extends UsersState {
  final String message;
  final String searchQuery;

  const UsersError(this.message, {this.searchQuery = ''});
  @override
  List<Object?> get props => [message, searchQuery];
}
