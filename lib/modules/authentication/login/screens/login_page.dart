import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/constants/app_colors.dart';
import 'package:oonique/modules/dashboard/view/base_view.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

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

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(authRepository: sl()),
      child: LoginDesktopView(),
    );
  }
}

class LoginDesktopView extends StatefulWidget {
  const LoginDesktopView({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginDesktopView> createState() => _LoginDesktopViewState();
}

class _LoginDesktopViewState extends State<LoginDesktopView> {
  TextEditingController emailController = TextEditingController(
    text: "admin@oonique.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: "11223344",
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
      if (state.loginStatus == LoginStatus.loading) {
        ToastLoader.show();
      } else if (state.loginStatus == LoginStatus.success) {
        ToastLoader.remove();
        emailController.clear();
        passwordController.clear();

        NavRouter.push(context, BaseView());
      } else if (state.loginStatus == LoginStatus.error) {
        ToastLoader.remove();
        context.showSnackBar(state.errorMessage);
      }
    }, builder: (context, state) {
      return Scaffold(
          backgroundColor: AppColors.bgColor,
          body: Center(
              child: Container(
            // height: containerHeight,
            width: 500,
            decoration: BoxDecoration(
                color: AppColors.white,
                // border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(12)),
            child: Form(
              key: _formKey,
              autovalidateMode: state.isAutoValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Hero(
                        tag: 'logo',
                        child: Image.asset(
                          Assets.pngOoniqueLogo,
                          height: 150,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
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
                          return "Email is Required";
                        }
                        if (!EmailValidator.validate(value)) {
                          return "Invalid Email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    InputField.password(
                      label: "Passowrd",
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      suffixIcon: PasswordSuffixIcon(
                        isPasswordVisible: !state.isPasswordHidden,
                        onTap: () {
                          context.read<LoginCubit>().toggleShowPassword();
                        },
                      ),
                      validator: (value) => Validators.password(
                        value,
                        "Password is Required",
                      ),
                      obscureText: state.isPasswordHidden,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          // NavRouter.push(context, ForgotPasswordPage());
                        },
                        icon: Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    PrimaryButton(
                      onPressed: _onLoggedIn,
                      title: "Sign In",
                      backgroundColor: AppColors.primaryColor,
                      height: 50,
                      shadowColor: AppColors.transparent,
                    ),
                    // PrimaryButton(
                    //   onPressed: () async {
                    //     BannersRepository repo = sl<BannersRepository>();
                    //
                    //     FiltersResponse response =
                    //         await repo.getCategories();
                    //     Filter categories = response.data.filters
                    //         .firstWhere((v) => v.key == "kategorie");
                    //
                    //     print(categories.uniqueValues);
                    //   },
                    //   title: "Get Categories",
                    // ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          )));
    });
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
