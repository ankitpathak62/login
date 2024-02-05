import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/cubits.dart';
import '../widgets/widgets.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isLogin == true) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const Loader();
        }
        if (state.status == Status.error) {
          return Erroror(
            error: state.error,
            onTap: () => context.read<AuthCubit>().setStatus(Status.initial),
          );
        }
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VGap(height: 140.h),
                Text('Login to Convo',
                    style: TextStyle(
                        fontSize: 40.sp, fontWeight: FontWeight.bold)),
                VGap(height: 10.h),
                const PaddedBox(label: 'Email Verification'),
                VGap(height: 40.h),
                Text(
                  'Email Address',
                  style: TextStyle(
                      color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                      fontWeight: FontWeight.bold),
                ),
                VGap(height: 10.h),
                AuthField(
                    hintText: 'Enter your email address',
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    onChanged: (x) {
                      context.read<AuthCubit>().setEmail(x);
                      debugPrint(context.read<AuthCubit>().email);
                    },
                    initialValue: context.read<AuthCubit>().email,
                    eye: false),
                VGap(height: 15.h),
                Text(
                  'Password',
                  style: TextStyle(
                      color: Theme.of(context).iconTheme.color!.withOpacity(.5),
                      fontWeight: FontWeight.bold),
                ),
                VGap(height: 10.h),
                AuthField(
                    hintText: 'Enter your password',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onChanged: (x) {
                      context.read<AuthCubit>().setPassword(x);
                      context.read<AuthCubit>().setRePassword(x);

                      debugPrint(context.read<AuthCubit>().password);
                    },
                    initialValue: context.read<AuthCubit>().password,
                    eye: true),
                VGap(height: 20.h),
                const Text(
                  'Forget Password',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                VGap(height: 20.h),
                AuthButton(
                    label: 'Sign in',
                    onTap: () {
                      context.read<AuthCubit>().LOGIN();
                    },
                    outlined: false),
                VGap(height: 30.h),
                Center(
                    child: Text(
                  '⎯⎯⎯⎯⎯⎯⎯⎯⎯     OR    ⎯⎯⎯⎯⎯⎯⎯⎯⎯',
                  style: TextStyle(
                      color:
                          Theme.of(context).iconTheme.color!.withOpacity(.5)),
                )),
                VGap(height: 30.h),
                AuthButton(
                    label: 'Register',
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/register'),
                    outlined: true),
              ],
            ),
          ),
        );
      },
    );
  }
}
