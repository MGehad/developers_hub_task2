import 'package:developers_hub_task2/core/utils/functions/show_snack_bar.dart';
import 'package:developers_hub_task2/core/utils/functions/validation_settings.dart';
import 'package:developers_hub_task2/core/widgets/custom_input_field.dart';
import 'package:developers_hub_task2/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:developers_hub_task2/features/auth/presentation/views/forget_password_view.dart';
import 'package:developers_hub_task2/features/auth/presentation/views/sign_up_view.dart';
import 'package:developers_hub_task2/features/auth/presentation/widgets/auth_button.dart';
import 'package:developers_hub_task2/features/auth/presentation/widgets/auth_link_text.dart';
import 'package:developers_hub_task2/features/auth/presentation/widgets/password_field.dart';
import 'package:developers_hub_task2/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.heightOf(context) / 5.5),
          Text(
            "Welcome Back!",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Sign in to continue",
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
                      String error = state.message;

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
                    } else if (state is AuthLoading) {
                      ShowSnackBar.show(
                        context,
                        message: "Signing in...",
                        color: Colors.blue,
                      );
                    }
                  },
                  builder: (context, state) {
                    return AutofillGroup(
                      child: Column(
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
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),

                          const SizedBox(height: 16),

                          // Password Input
                          PasswordField(
                            controller: _passwordController,
                            label: "Password",
                            hintText: "Enter your Password",
                            validator: ValidationSettings.passwordValidator,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),

                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(50, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.centerRight,
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgetPasswordView(),
                                ),
                              ),
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.indigo,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          AuthButton(
                            text: "Sign In",
                            onPressed: _signIn,
                            isLoading: state is AuthLoading,
                          ),

                          const SizedBox(height: 12),

                          // Sign Up
                          AuthLinkText(
                            text: "Don't have an account?",
                            linkText: "Sign Up",
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpView(),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();

      context.read<AuthCubit>().signIn(
        email: email,
        password: _passwordController.text,
      );
    }
  }
}
