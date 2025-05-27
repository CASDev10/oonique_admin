import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import '../../../../app/app_cubit.dart';
import '../../../../config/routes/nav_router.dart';
import '../../../../core/core.dart';
import '../../../../generated/assets.dart';
import '../../../../ui/input/input_field.dart';
import '../../../../ui/widgets/password_suffix_widget.dart';
import '../../../../ui/widgets/primary_button.dart';
import '../../../../ui/widgets/toast_loader.dart';
import '../../../../utils/validators/email_validator.dart';
import '../../../../utils/validators/validators.dart';
import '../../models/login_input_model.dart';
import '../cubit/login_cubit.dart';

class LoginMobilePage extends StatelessWidget {
  const LoginMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(authRepository: sl()),
      child: LoginMobileView(),
    );
  }
}

class LoginMobileView extends StatefulWidget {
  LoginMobileView({Key? key}) : super(key: key);

  @override
  State<LoginMobileView> createState() => _LoginMobileViewState();
}

class _LoginMobileViewState extends State<LoginMobileView> {
  TextEditingController emailController = TextEditingController(
    text: "admin@oonique.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: "11223344",
  );
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final languageCubit = context.read<AppCubit>();

    return Title(
      color: context.colorScheme.onPrimary,
      title: 'Oonique Login',
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state.loginStatus == LoginStatus.loading) {
            ToastLoader.show();
          } else if (state.loginStatus == LoginStatus.success) {
            ToastLoader.remove();
            emailController.clear();
            passwordController.clear();

            NavRouter.pushAndRemoveUntil(context, '/dashboard/home');
          } else if (state.loginStatus == LoginStatus.error) {
            ToastLoader.remove();
            context.showSnackBar(state.errorMessage);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Form(
                key: _formKey,
                autovalidateMode:
                    state.isAutoValidate
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        child: Hero(
                          tag: 'logo',
                          child: Image.asset(Assets.pngOoniqueLogo),
                        ),
                      ),
                      const SizedBox(height: 46),
                      Center(
                        child: Text(
                          "Welcome Admin",
                          style: context.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Center(child: Text("Sign in to Continue")),
                      const SizedBox(height: 20),
                      InputField.email(
                        label: "Email",
                        controller: emailController,
                        validator: (value) {
                          if (value == null) {
                            return "Email Required";
                          }
                          if (!EmailValidator.validate(value)) {
                            return "Invalid Email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),
                      InputField.password(
                        label: "Password",
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        suffixIcon: PasswordSuffixIcon(
                          isPasswordVisible: !state.isPasswordHidden,
                          onTap: () {
                            context.read<LoginCubit>().toggleShowPassword();
                          },
                        ),
                        validator:
                            (value) =>
                                Validators.password(value, "password Required"),
                        obscureText: state.isPasswordHidden,
                      ),
                      // Align(
                      //     alignment: Alignment.centerRight,
                      //     child: IconButton(
                      //       style: ButtonStyle(
                      //           padding: MaterialStateProperty.all(
                      //               EdgeInsets.symmetric(
                      //                   horizontal: 2, vertical: 0))),
                      //       onPressed: () {
                      //         // NavRouter.push(context, ForgotPasswordPage());
                      //       },
                      //       icon: Text(
                      //         context.localization.forgot_password,
                      //         style:
                      //             TextStyle(color: context.colorScheme.primary),
                      //       ),
                      //     )),
                      SizedBox(height: 32),
                      PrimaryButton(onPressed: _onLoggedIn, title: "Sign in"),
                      SizedBox(height: 16),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(context.localization.dont_have_an_account),
                      //     IconButton(
                      //         onPressed: () {
                      //           // context.go(Routes.signup);
                      //         },
                      //         icon: Text(
                      //           context.localization.sign_up,
                      //           style: context.textTheme.headlineSmall?.copyWith(
                      //               fontWeight: FontWeight.w700,
                      //               color: context.colorScheme.primary),
                      //         ))
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onLoggedIn() {
    if (_formKey.currentState!.validate()) {
      LoginInput loginInput = LoginInput(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      context.read<LoginCubit>().login(loginInput);
    } else {
      context.read<LoginCubit>().enableAutoValidateMode();
    }
  }
}
