import 'package:demo_app/features/users/domain/entities/user.dart';
import 'package:demo_app/features/users/domain/usecases/get_users_usecase.dart';
import 'package:demo_app/features/users/presentation/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UsersState> {
  final GetUsersUseCase getUsersUseCase;
  static const int pageSize = 20;

  UserCubit(this.getUsersUseCase) : super(UsersInitial());

  /// Fetch a page of users
  Future<List<User>> fetchPage(int page, String query) async {
    if (query.isEmpty) {
      emit(UsersInitial());
      return [];
    }

    // Show loading only for first page
    if (page == 1) {
      emit(UsersLoading(searchQuery: query));
    }

    try {
      final users = await getUsersUseCase({
        'q': query,
        'page': page,
        'per_page': pageSize,
      });

      final currentState = state;
      final existingUsers = (page > 1 && currentState is UsersLoaded)
          ? currentState.users
          : <User>[];

      emit(
        UsersLoaded(
          users: [...existingUsers, ...users],
          searchQuery: query,
          currentPage: page,
          hasReachedMax: users.length < pageSize,
        ),
      );

      return users;
    } catch (e) {
      emit(UsersError(e.toString(), searchQuery: query));
      rethrow;
    }
  }
}
