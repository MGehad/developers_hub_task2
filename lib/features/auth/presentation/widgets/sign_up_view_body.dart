import 'package:developers_hub_task2/core/utils/functions/show_snack_bar.dart';
import 'package:developers_hub_task2/core/utils/functions/validation_settings.dart';
import 'package:developers_hub_task2/core/widgets/custom_input_field.dart';
import 'package:developers_hub_task2/features/auth/data/models/user_model.dart';
import 'package:developers_hub_task2/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:developers_hub_task2/features/auth/presentation/widgets/auth_button.dart';
import 'package:developers_hub_task2/features/auth/presentation/widgets/auth_link_text.dart';
import 'package:developers_hub_task2/features/auth/presentation/widgets/password_field.dart';
import 'package:developers_hub_task2/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late UserModel user;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 36),
          Text(
            "Create Account",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Fill in your details to get started",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomInputField(
                      controller: _fullNameController,
                      label: "FullName",
                      hintText: "Enter your FullName",
                      prefixIcon: Icons.person_outline,
                      validator: ValidationSettings.nameValidator,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                    ),

                    const SizedBox(height: 12),
                    CustomInputField(
                      controller: _emailController,
                      label: "Email",
                      hintText: "Enter your Email",
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: ValidationSettings.emailValidator,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                    ),

                    const SizedBox(height: 12),
                    PasswordField(
                      controller: _passwordController,
                      label: "Password",
                      hintText: "Enter your password",
                      validator: ValidationSettings.passwordValidator,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.newPassword],
                    ),

                    const SizedBox(height: 12),
                    PasswordField(
                      controller: _confirmPasswordController,
                      label: "Confirm Password",
                      hintText: "Confirm your Password",
                      validator: (value) =>
                          ValidationSettings.confirmPasswordValidator(
                            value: value,
                            password: _passwordController.text,
                          ),
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.newPassword],
                    ),

                    const SizedBox(height: 16),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthError) {
                          String error = state.message;
                          ShowSnackBar.show(
                            context,
                            message: error,
                            color: Colors.red,
                          );
                        } else if (state is AuthSuccess) {
                          ShowSnackBar.show(
                            context,
                            message: "Signed up successfully!",
                            color: Colors.green,
                          );
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeView(),
                            ),
                          );
                        }
                      },
                      builder: (context, state) => AuthButton(
                        text: "Create Account",
                        onPressed: _signUp,
                        isLoading: state is AuthLoading,
                      ),
                    ),

                    const SizedBox(height: 12),
                    AuthLinkText(
                      text: "Have an account?",
                      linkText: "Login",
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      _getUserModel();
      context.read<AuthCubit>().signUp(user: user);
    }
  }

  void _getUserModel() {
    String name = _fullNameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    user = UserModel(name: name, email: email, password: password);
  }
}
