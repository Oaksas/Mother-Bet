import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mother_bet/models/user.dart';
import 'package:mother_bet/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;

  AuthBloc(this.authRepo) : super(LoggedOut());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LogInEvent) {
      yield AuthInProgress();
      final email = event.email;
      final password = event.password;

      final user = User("id", email, "username", "phone", password, "token");
      // print(user);
      try {
        final result = await authRepo.login(user);
        // print("ttttttttttttttttttttttttttttttttttttttttt");

        print(user);
        yield AuthSuccess(result);
        // } on SocketException catch (e) {
        //   print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
        //   print(e);
        yield AuthError("Check your internet connection");
      } catch (e) {
        yield AuthError(e.toString());
        await Future.delayed(const Duration(seconds: 2));
        yield LoggedOut();
      }
    }
    if (event is SignUp) {
      yield AuthInProgress();

      final email = event.email;
      final username = event.username;
      final phone = event.phone;
      final password = event.password;

      final user = User("0", email, username, phone, password, "token");
      print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
      print(user.phone);
      print(user.email);
      print(user.username);
      print(user.phone);
      try {
        final result = await authRepo.signup(user);
        yield AuthSuccess(result);
      } on SocketException catch (_) {
        yield AuthError("Check your internet connection");
      } catch (e) {
        yield AuthError(e.toString());
        await Future.delayed(const Duration(seconds: 2));
        yield LoggedOut();
      }
    }
  }
}
