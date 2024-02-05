import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:waythru/cubits/cubits.dart';

import '../services/services.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  final AuthService authService = AuthService();
  AuthCubit() : super(const AuthState()) {}

  Future<void> LOGIN() async {
    if (authService.loginFormError(email, password) == 'null') {
      // setStatus(Loading());
      debugPrint(email);
      debugPrint(password);
      setStatus(Status.loading);
      try {
        final uid = await authService.login(email, password);
        if (uid == null) {
          setStatus(Status.error);
          setError('Something went wrong');
        }
        setAuthId(uid!);
        setIsLogin(true);
        // setStatus(Loaded());
        setStatus(Status.success);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          // setStatus(const Error("Please provide a valid email"));
          setStatus(Status.error);
          setError('Please provide a valid email');
          return;
        } else if (e.code == 'user-disabled') {
          // setStatus(const Error("The account has been disabled"));
          setStatus(Status.error);
          setError('The account has been disabled');
          return;
        } else if (e.code == 'user-not-found') {
          // setStatus(const Error("Provided user account does not exist"));
          setStatus(Status.error);
          setError('Provided user account does not exist');
          return;
        } else if (e.code == 'wrong-password') {
          // setStatus(const Error("You provided a wrong password"));
          setStatus(Status.error);
          setError('You provided a wrong password');
          return;
        }
      }
    } else {
      // setStatus(Error(authService.loginFormError(email, password)));
      setStatus(Status.error);
      setError(authService.loginFormError(email, password));
      return;
    }
  }

  Future<void> REGISTER() async {
    setRegister(false);
    String formError =
        authService.registerFormError(email, password, rePassword);
    if (formError == 'null') {
      setStatus(Status.loading);
      try {
        final user = await authService.register(email, password);
        if (user != null) {
          try {
            await authService.registerCloud(email, password);
            setAuthId(user.uid);
            setIsLogin(true);
            setStatus(Status.success);
          } catch (e) {
            setStatus(Status.error);
            setError('Unable to Save the Registered Data');
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          setStatus(Status.error);
          setError('Please provide a valid email');
          return;
        } else if (e.code == 'email-already-in-use') {
          setStatus(Status.error);
          setError('The email address is already in use by another account');
          return;
        } else if (e.code == 'operation-not-allowed') {
          setStatus(Status.error);
          setError('Provided operation is not allowed');
          return;
        } else if (e.code == 'weak-password') {
          setStatus(Status.error);
          setError(
              'You provided a very weak password, Please try again with a strong password');
          return;
        }
      }
    } else {
      setStatus(Status.error);
      setError(formError);
      return;
    }
  }

  Future<void> signOut() async {
    setStatus(Status.loading);
    try {
      await FirebaseAuth.instance.signOut();
      setStatus(Status.success);
      setIsLogin(false);
    } catch (e) {
      setStatus(Status.error);
      setError(e.toString());
    }
  }

  void setAuthId(String authId) => emit(state.copyWith(authId: authId));
  void setEmail(String email) => emit(state.copyWith(email: email));
  void setName(String name) => emit(state.copyWith(name: name));
  void setPassword(String password) => emit(state.copyWith(password: password));
  void setRePassword(String rePassword) =>
      emit(state.copyWith(rePassword: rePassword));
  void setRegister(bool register) => emit(state.copyWith(register: register));
  void setIsLogin(bool isLogin) => emit(state.copyWith(isLogin: isLogin));
  void setError(String error) => emit(state.copyWith(error: error));
  void setStatus(Status status) => emit(state.copyWith(status: status));

  String get authId => state.authId;
  String get email => state.email;
  String get name => state.name;
  String get password => state.password;
  String get rePassword => state.rePassword;
  bool get register => state.register;
  bool get isLogin => state.isLogin;
  String get error => state.error;
  Status get status => state.status;

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState(
      authId: json['authId'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      password: json['password'] ?? '',
      rePassword: json['rePassword'] ?? '',
      register: json['register'] ?? false,
      isLogin: json['isLogin'] ?? false,
      error: json['error'] ?? '',
      status: Status.values[json['status'] ?? 0],
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return {
      'authId': state.authId,
      'email': state.email,
      'name': state.name,
      'password': state.password,
      'rePassword': state.rePassword,
      'register': state.register,
      'isLogin': state.isLogin,
      'error': state.error,
      'status': state.status.index,
    };
  }
}

class AuthState extends Equatable {
  @override
  final String authId;
  final String email;
  final String name;
  final String password;

  final String rePassword;
  final bool register;
  final bool isLogin;
  final String error;
  final Status status;

  const AuthState(
      {this.authId = '',
      this.email = '',
      this.name = '',
      this.password = '',
      this.rePassword = '',
      this.register = false,
      this.isLogin = false,
      this.error = '',
      this.status = Status.initial});

  AuthState copyWith(
      {String? authId,
      String? email,
      String? name,
      String? password,
      String? rePassword,
      bool? register,
      bool? isLogin,
      String? error,
      Status? status}) {
    return AuthState(
      authId: authId ?? this.authId,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      register: register ?? this.register,
      isLogin: isLogin ?? this.isLogin,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  List<Object?> get props => [
        authId,
        email,
        name,
        password,
        rePassword,
        register,
        isLogin,
        error,
        status
      ];
}
