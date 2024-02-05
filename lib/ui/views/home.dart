import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waythru/cubits/auth.dart';
import 'package:waythru/ui/widgets/auth.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isLogin == false) {
          Navigator.pushReplacementNamed(context, '/');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: AuthButton(
                label: 'Sign Out',
                onTap: () => context.read<AuthCubit>().signOut(),
                outlined: false),
          ),
        );
      },
    );
  }
}
