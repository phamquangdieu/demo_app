import 'package:demo_app/features/users/domain/usecases/get_users_usecase.dart';
import 'package:demo_app/features/users/presentation/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UsersState> {
  final GetUsersUseCase getUsersUseCase;

  UserCubit(this.getUsersUseCase) : super(UsersInitial());

  Future<void> fetchUsers() async {
    emit(UsersLoading());
    try {
      final users = await getUsersUseCase();
      emit(UsersLoaded(allUsers: users, filteredUsers: users));
    } catch (e) {
      emit(UsersError(e.toString()));
    }
  }

  void searchUsers(String keyword) {
    final currentState = state;
    if (currentState is UsersLoaded) {
      if (keyword.isEmpty) {
        emit(
          currentState.copyWith(
            filteredUsers: currentState.allUsers,
            searchQuery: '',
          ),
        );
        return;
      }
      final filteredUsers = currentState.allUsers.where((user) {
        return user.login.toLowerCase().contains(keyword.toLowerCase());
      }).toList();

      emit(
        UsersLoaded(
          allUsers: currentState.allUsers,
          filteredUsers: filteredUsers,
          searchQuery: keyword,
        ),
      );
    }
  }
}
