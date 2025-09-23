import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            AssetPaths.backIcon,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: context.h1,
                ),
                const SizedBox(
                  height: 32,
                ),
                PITextField(
                  hintText: 'Email',
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 16,
                ),
                PITextField(
                  hintText: 'Password',
                  controller: _passwordController,
                  type: PITextFieldType.password,
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forgot Password?',
                      style: context.b2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                PIButton(
                  text: 'Login',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Text(
                    'OR',
                    style: context.b1.copyWith(
                      color: AppColors.greyShade2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                PIButton.tertiary(
                  text: 'Continue with Google',
                  prefixIcon: SvgPicture.asset(
                    AssetPaths.googleIcon,
                  ),
                  onPressed: () {},
                ),
                PIButton.tertiary(
                  text: 'Continue with Apple',
                  prefixIcon: SvgPicture.asset(
                    AssetPaths.appleIcon,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Text(
              'By choosing to continue, you agree to PlugdIn’s Terms and Privacy Policy.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
