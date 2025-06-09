import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mservices/modules/auth/register/controller/register_controller.dart';
import 'package:mservices/utils/assets.dart';
import 'package:mservices/utils/constants.dart';
import 'package:mservices/utils/enums.dart';
import 'package:mservices/utils/navigation/navigation.dart';
import 'package:mservices/utils/navigation/routes.dart';
import 'package:mservices/utils/palette.dart';
import 'package:mservices/utils/utils.dart';
import 'package:mservices/utils/validation_utils.dart';
import 'package:mservices/widgets/app_text.dart';
import 'package:mservices/widgets/custom_button.dart';
import 'package:mservices/widgets/custom_textfield.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final RegisterController _controller = Get.put(RegisterController());

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
                      text: "Register Yourself",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  55.h.verticalSpace,
                  TitleFieldWidget(
                    title: "Name",
                    child: CommonTextField(
                      controller: _controller.nameController,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      hintText: "Enter Name",
                      validator: (value) => AppValidation.emptyValidator(value, "Please enter Name"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
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
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio<UserType>(
                              value: UserType.customer,
                              groupValue: _controller.userType.value,
                              onChanged: (value) => _controller.onChangeType(value),
                              fillColor: WidgetStatePropertyAll(Palette.primary),
                            ),
                            GestureDetector(
                              onTap: () => _controller.onChangeType(UserType.customer),
                              child: AppText(
                                text: UserType.customer.name.capitalizeFirst ?? "",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<UserType>(
                              value: UserType.provider,
                              groupValue: _controller.userType.value,
                              onChanged: (value) => _controller.onChangeType(value),
                              fillColor: WidgetStatePropertyAll(Palette.primary),
                            ),
                            GestureDetector(
                              onTap: () => _controller.onChangeType(UserType.provider),
                              child: AppText(
                                text: UserType.provider.name.capitalizeFirst ?? "",
                              ),
                            ),
                            12.w.horizontalSpace,
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100.h, bottom: 50.h),
                    child: CustomButton(
                      onTap: _controller.onRegisterTap,
                      isLoader: _controller.isLoading.isTrue,
                      text: "Register",
                      height: 55.h,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigation.replace(Routes.login),
                    behavior: HitTestBehavior.translucent,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account?\t",
                          ),
                          TextSpan(
                            text: "Login",
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
