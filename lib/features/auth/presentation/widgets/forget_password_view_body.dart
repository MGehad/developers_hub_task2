import 'package:developers_hub_task2/core/utils/functions/show_snack_bar.dart';
import 'package:developers_hub_task2/core/utils/functions/validation_settings.dart';
import 'package:developers_hub_task2/core/widgets/custom_input_field.dart';
import 'package:developers_hub_task2/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:developers_hub_task2/features/auth/presentation/widgets/auth_button.dart';
import 'package:developers_hub_task2/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.heightOf(context) / 6),
          Text(
            "Reset Password",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),
          Text(
            "Enter your email to receive a reset link",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),

          const SizedBox(height: 24),
          Card(
            margin: EdgeInsets.all(16.0),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      String error = "";

                      error = state.message;

                      ShowSnackBar.show(
                        context,
                        message: error,
                        color: Colors.red,
                      );
                    } else if (state is AuthSuccess) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomInputField(
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
                          controller: _emailController,
                          label: "Email",
                          hintText: "Enter your Email",
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: ValidationSettings.emailValidator,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                        ),

                        const SizedBox(height: 20),

                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          builder: (context, state) => AuthButton(
                            text: "Send reset link",
                            onPressed: _forgetPassword,
                            isLoading: state is AuthLoading,
                          ),
                        ),

                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Row(
                            spacing: 6,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_back, color: Colors.grey),
                              Text(
                                "Back to Login",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _forgetPassword() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();

      context.read<AuthCubit>().forgetPassword(email: email);
    }
  }
}
