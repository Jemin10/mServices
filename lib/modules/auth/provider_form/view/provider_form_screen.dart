import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mservices/modules/auth/provider_form/controller/provider_form_controller.dart';
import 'package:mservices/utils/assets.dart';
import 'package:mservices/utils/enums.dart';
import 'package:mservices/utils/palette.dart';
import 'package:mservices/utils/validation_utils.dart';
import 'package:mservices/widgets/appbar.dart';
import 'package:mservices/widgets/common_drop_down.dart';
import 'package:mservices/widgets/custom_button.dart';
import 'package:mservices/widgets/custom_textfield.dart';

class ProviderFormScreen extends StatelessWidget {
  ProviderFormScreen({super.key});

  final ProviderFormController _controller = Get.put(ProviderFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Service Details",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
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
                    margin: EdgeInsets.only(bottom: 40.h),
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
                      validator: (value) => AppValidation.emptyValidator(value, "Please enter Description"),
                    ),
                  ),
                ),
                TitleFieldWidget(
                  title: "Phone No",
                  child: CommonTextField(
                    controller: _controller.phoneNoController,
                    keyboardType: TextInputType.number,
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
                50.h.verticalSpace,
                CustomButton(
                  onTap: _controller.onSaveTap,
                  isLoader: _controller.isLoading.isTrue,
                  text: "Continue",
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
