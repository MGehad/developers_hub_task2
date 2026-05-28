import 'package:developers_hub_task2/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:developers_hub_task2/features/home/presentation/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => AuthCubit()..getUserData(),
          child: HomeViewBody(),
        ),
      ),
    );
  }
}
