import 'package:developers_hub_task2/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:developers_hub_task2/features/auth/presentation/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: const SafeArea(child: LoginViewBody()),
      ),
    );
  }
}
