import 'package:developers_hub_task2/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:developers_hub_task2/features/auth/presentation/widgets/forget_password_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: const SafeArea(child: ForgetPasswordViewBody()),
      ),
    );
  }
}
