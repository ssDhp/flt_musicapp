import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/features/auth/models/user_model.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart' as fpd;

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late final AuthRemoteRepository _authRemoteRepository;
  late final AuthLocalRepository _authLocalRepository;
  late final CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future<void> initSharedPrefrences() async {
    await _authLocalRepository.init();
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final response = await _authRemoteRepository.signup(
      name: name,
      email: email,
      password: password,
    );

    final extractedValue = switch (response) {
      fpd.Left(value: final l) => state =
          AsyncValue.error(l.errorMessage, StackTrace.current),
      fpd.Right(value: final r) => state = AsyncValue.data(r),
    };

    print('SignUp: $extractedValue');
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final response = await _authRemoteRepository.login(
      email: email,
      password: password,
    );

    final extractedValue = switch (response) {
      fpd.Left(value: final l) => state =
          AsyncValue.error(l.errorMessage, StackTrace.current),
      fpd.Right(value: final r) => _loginSucess(r),
    };

    print('Login: $extractedValue');
  }

  AsyncValue<UserModel>? _loginSucess(UserModel user) {
    _authLocalRepository.setToken(user.token);
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

  Future<UserModel?> getData() async {
    state = const AsyncValue.loading();

    final token = _authLocalRepository.getToken();

    if (token != null) {
      final response = await _authRemoteRepository.getCurrentUser(token: token);
      final extractedValue = switch (response) {
        fpd.Left(value: final l) => state =
            AsyncValue.error(l.errorMessage, StackTrace.current),
        fpd.Right(value: final r) => _getDataSuccess(r),
      };

      return extractedValue.value;
    }

    return null;
  }

  AsyncValue<UserModel> _getDataSuccess(UserModel user) {
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }
}
