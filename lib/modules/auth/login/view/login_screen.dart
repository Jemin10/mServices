import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mservices/modules/auth/login/controller/login_controller.dart';
import 'package:mservices/utils/assets.dart';
import 'package:mservices/utils/constants.dart';
import 'package:mservices/utils/navigation/navigation.dart';
import 'package:mservices/utils/navigation/routes.dart';
import 'package:mservices/utils/palette.dart';
import 'package:mservices/utils/utils.dart';
import 'package:mservices/utils/validation_utils.dart';
import 'package:mservices/widgets/app_text.dart';
import 'package:mservices/widgets/custom_button.dart';
import 'package:mservices/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: SafeArea(
          child: Obx(
            () => Form(
              key: _controller.formKey,
              autovalidateMode: _controller.autoValidateMode.value,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 80.h,
                      width: 80.h,
                      margin: EdgeInsets.only(top: 30.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Palette.secondary,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          IconAsset.appLogo,
                          width: 55.h,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: AppText(
                      text: "Login",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  80.h.verticalSpace,
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: TitleFieldWidget(
                      title: "Email",
                      child: CommonTextField(
                        controller: _controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Enter Email",
                        inputFormatters: Utils.emailInputFormatter(),
                        validator: (value) => AppValidation.emailValidator(value),
                      ),
                    ),
                  ),
                  TitleFieldWidget(
                    title: "Password",
                    child: CommonTextField(
                      controller: _controller.passController,
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: "Enter Password",
                      validator: (value) => AppValidation.passValidator(value),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 150.h, bottom: 80.h),
                    child: CustomButton(
                      onTap: _controller.onLoginTap,
                      isLoader: _controller.isLoading.isTrue,
                      text: "Login",
                      height: 55.h,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigation.replace(Routes.register),
                    behavior: HitTestBehavior.translucent,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account?\t",
                          ),
                          TextSpan(
                            text: "Register",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Palette.primary,
                            ),
                          ),
                        ],
                        style: TextStyle(
                          fontFamily: FontFamily.inter,
                          color: Palette.text,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          height: 1.1,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
