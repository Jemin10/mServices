import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mservices/modules/edit_profile/controller/edit_profile_controller.dart';
import 'package:mservices/utils/enums.dart';
import 'package:mservices/utils/utils.dart';
import 'package:mservices/utils/validation_utils.dart';
import 'package:mservices/widgets/appbar.dart';
import 'package:mservices/widgets/common_drop_down.dart';
import 'package:mservices/widgets/custom_button.dart';
import 'package:mservices/widgets/custom_textfield.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final EditProfileController _controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Edit Profile",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Obx(
          () => Form(
            key: _controller.formKey,
            autovalidateMode: _controller.autoValidateMode.value,
            child: Column(
              children: [
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
                      readOnly: true,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Enter Email",
                      inputFormatters: Utils.emailInputFormatter(),
                      validator: (value) => AppValidation.emailValidator(value),
                    ),
                  ),
                ),
                if (_controller.user.value?.userType == UserType.provider.name)
                  Column(
                    children: [
                      TitleFieldWidget(
                        title: "Service Type",
                        child: CommonDropDown<String>(
                          hintText: "Select Service Type",
                          value: _controller.selectedServiceType.value,
                          onChanged: (value) => _controller.onSelectService(value),
                          items: ServiceType.services,
                          itemAsString: (service) => service,
                          validator: (value) =>
                              AppValidation.nullValidator(value, "\t\t\t\t\tPlease select Service type"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        child: TitleFieldWidget(
                          title: "Description",
                          child: CommonTextField(
                            controller: _controller.descController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.sentences,
                            hintText: "Enter Description",
                            validator: (value) =>
                                AppValidation.emptyValidator(value, "Please enter Description"),
                          ),
                        ),
                      ),
                      TitleFieldWidget(
                        title: "Phone No",
                        child: CommonTextField(
                          keyboardType: TextInputType.number,
                          controller: _controller.phoneController,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 10,
                          hintText: "Enter Phone No",
                          validator: (value) => AppValidation.mobileNumberValidator(value),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        child: TitleFieldWidget(
                          title: "Experience in Years (0-9)",
                          child: CommonTextField(
                            controller: _controller.experienceController,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            hintText: "Enter Experience",
                            validator: (value) =>
                                AppValidation.emptyValidator(value, "Please enter your Experience"),
                          ),
                        ),
                      ),
                      TitleFieldWidget(
                        title: "Hourly Rate (Max 1000 ₹)",
                        child: CommonTextField(
                          controller: _controller.priceController,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          hintText: "Enter Hourly Rate",
                          validator: (value) => AppValidation.rateValidator(value),
                        ),
                      ),
                    ],
                  ),
                (_controller.user.value?.userType == UserType.provider.name ? 50 : 200).h.verticalSpace,
                CustomButton(
                  onTap: _controller.onUpdateTap,
                  isLoader: _controller.isLoading.isTrue,
                  text: "Update",
                  height: 55.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
