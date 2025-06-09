import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mservices/modules/auth/login/model/user.dart';
import 'package:mservices/modules/home/controller/home_controller.dart';
import 'package:mservices/utils/assets.dart';
import 'package:mservices/utils/constants.dart';
import 'package:mservices/utils/enums.dart';
import 'package:mservices/utils/navigation/navigation.dart';
import 'package:mservices/utils/navigation/routes.dart';
import 'package:mservices/utils/palette.dart';
import 'package:mservices/widgets/app_text.dart';
import 'package:mservices/widgets/appbar.dart';
import 'package:mservices/widgets/custom_loading_widget.dart';
import 'package:mservices/widgets/custom_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _controller.onFetchUserData(),
    );
  }

  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: CustomAppBar(
          backArrow: false,
          leading: Container(
            width: 61.w,
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(
              IconAsset.appLogo,
              width: 45.w,
            ),
          ),
          title: "Hii, ${_controller.user.value?.name?.split(" ").first ?? ""} 👋",
          centerTitle: false,
        ),
        body: _controller.isLoading.isTrue
            ? Center(
                child: CustomLoadingWidget(),
              )
            : _controller.providers.isEmpty
                ? Center(
                    child: AppText(text: "No Data Found !"),
                  )
                : _BodyView(),
      ),
    );
  }
}

class _BodyView extends StatelessWidget {
  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<UserModel> users = [];
        List<UserModel> tempUsers = [];

        if (_controller.selectedType.value != "All") {
          tempUsers.addAll(_controller.providers
              .where((value) => value.serviceType == _controller.selectedType.value)
              .toList());
        } else {
          tempUsers.addAll(_controller.providers);
        }

        if (_controller.searchText.trim().isEmpty) {
          users.addAll(tempUsers);
        } else {
          users.addAll(tempUsers
              .where((value) =>
                  value.name?.toLowerCase().contains(_controller.searchText.trim().toLowerCase()) ?? false)
              .toList());
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CommonTextField(
                controller: _controller.searchController,
                prefixIcon: IconAsset.search,
                onChanged: (value) => _controller.onSearch(value),
                suffix: _controller.searchText.value.isNotEmpty
                    ? GestureDetector(
                        onTap: _controller.onClearSearch,
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          width: 45.w,
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            IconAsset.close,
                            height: 20.w,
                            width: 20.w,
                          ),
                        ),
                      )
                    : null,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                hintText: "Search here",
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 8.w,
                children: List.generate(
                  ServiceType.services.length + 1,
                  (index) {
                    String title = index == 0 ? "All" : ServiceType.services[index - 1];
                    bool isSelected = title == _controller.selectedType.value;

                    return GestureDetector(
                      onTap: () => _controller.selectedType.value = title,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: isSelected ? Palette.primary : Palette.secondary),
                          borderRadius: BorderRadius.circular(20.r),
                          color: isSelected ? Palette.primary : Palette.white,
                        ),
                        child: Center(
                          child: AppText(
                            text: title,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Palette.secondary : Palette.primary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: users.isEmpty
                  ? Center(
                      child: AppText(text: "No Data Found !"),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final data = users[index];

                        return GestureDetector(
                          onTap: () => Navigation.pushNamed(
                            Routes.providerDetails,
                            arg: {"user": data},
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10.w),
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Palette.lightGrey, width: 2.w),
                            ),
                            child: Column(
                              spacing: 8.h,
                              children: [
                                Row(
                                  spacing: 10.w,
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: 50.h,
                                      decoration: BoxDecoration(
                                        color: Palette.primary,
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      child: Center(
                                        child: AppText(
                                          text: data.name?.capitalizeFirst?[0] ?? "",
                                          fontWeight: FontWeight.w900,
                                          color: Palette.secondary,
                                          fontSize: 25.sp,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      spacing: 6.h,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: data.name ?? "",
                                        ),
                                        AppText(
                                          text: data.serviceType ?? "",
                                          fontSize: 14.sp,
                                          color: Palette.grey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        spacing: 6.w,
                                        children: [
                                          SvgPicture.asset(
                                            IconAsset.price,
                                            height: 16.h,
                                            colorFilter: ColorFilter.mode(Palette.primary, BlendMode.srcIn),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "${data.hourlyRate}₹",
                                                  style: TextStyle(
                                                    color: Palette.primary,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "\tper hour",
                                                ),
                                              ],
                                              style: TextStyle(
                                                fontFamily: FontFamily.inter,
                                                color: Palette.text,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp,
                                                height: 1.1,
                                                letterSpacing: 0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        spacing: 6.w,
                                        children: [
                                          SvgPicture.asset(
                                            IconAsset.award,
                                            height: 16.h,
                                            colorFilter: ColorFilter.mode(Palette.primary, BlendMode.srcIn),
                                          ),
                                          data.experience != "0"
                                              ? RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "${data.experience}",
                                                        style: TextStyle(
                                                          color: Palette.primary,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: "\tyears",
                                                      ),
                                                    ],
                                                    style: TextStyle(
                                                      fontFamily: FontFamily.inter,
                                                      color: Palette.text,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12.sp,
                                                      height: 1.1,
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                )
                                              : AppText(
                                                  text: "Beginner",
                                                  fontSize: 12.sp,
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
