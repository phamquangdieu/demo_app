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
      emit(UsersLoaded(users));
    } catch (e) {
      emit(UsersError(e.toString()));
    }
  }
}
