import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/features/auth/domain/use_case/auth_usecase.dart';
import 'package:real_estate_app/features/auth/presentation/state/newstate.dart';

final userVMProvider = StateNotifierProvider<UserVM, NewState>(
  (ref) {
    return UserVM(
      ref.read(authUseCaseProvider),
    );
  },
);

class UserVM extends StateNotifier<NewState> {
  final AuthUseCase _userUseCase;

  UserVM(this._userUseCase) : super(NewState.initial()) {
    getUserData();
  }

  Future<void> getUserData() async {
    state = state.copyWith(isLoading: true);
    var data = await _userUseCase.getUserData();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, user: r),
    );
  }
}
