import 'package:dashboard_mealz/common/consts/app_sizes.dart';
import 'package:dashboard_mealz/common/consts/enums.dart';
import 'package:dashboard_mealz/common/consts/images.dart';
import 'package:dashboard_mealz/core/core.dart';
import 'package:dashboard_mealz/core/navigation_routes.dart';
import 'package:dashboard_mealz/presentation/item/item_page.dart';
import 'package:dashboard_mealz/presentation/layout/controllers/layout_controller.dart';
import 'package:dashboard_mealz/presentation/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Layout extends StatelessWidget {
  Layout({super.key});

  final LayoutController _layoutController = Get.find<LayoutController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            drawer: Drawer(
              child: LeftSideMenu(layoutController: _layoutController),
            ),
            body: LayoutBuilder(builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              return Row(
                children: [
                  screenWidth < 900
                      ? const SizedBox.shrink()
                      : LeftSideMenu(layoutController: _layoutController),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: AppSizes.instance.largeHPadding,
                              right: AppSizes.instance.largeHPadding,
                              top: AppSizes.instance.mediumHPadding,
                              bottom: AppSizes.instance.smallHPadding),
                          height: 80,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFFF1F3F7).withOpacity(0.3),
                                  Colors.white,
                                  const Color(0xFFF7ECF1).withOpacity(0.3),
                                  Colors.white,
                                ],
                              ),
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 0.5,
                                ),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  screenWidth < 900
                                      ? IconButton(
                                          onPressed: () {
                                            _scaffoldKey.currentState
                                                ?.openDrawer();
                                          },
                                          icon: const Icon(Icons.menu))
                                      : const SizedBox.shrink(),
                                  SizedBox(
                                    width: AppSizes.instance.largeHPadding,
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('안녀하세요,',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Text('관리자님',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              Obx(
                                () => _layoutController.itemPageController
                                            .currentPageIndex.value ==
                                        1
                                    ? MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {
                                            _layoutController.itemPageController
                                                .changePage(0);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(
                                              AppSizes.instance.smallHPadding,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.red.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                                width: 0.5,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                    FontAwesomeIcons.leftLong,
                                                    size: 16,
                                                    color: Colors.white),
                                                SizedBox(
                                                    width: AppSizes.instance
                                                        .smallHPadding),
                                                const Text('주문 관리',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: PageView(
                            scrollDirection: Axis.vertical,
                            controller: _layoutController.pageController,
                            onPageChanged: (index) {
                              _layoutController.changePage(index);
                            },
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              const ProductPage(),
                              ItemPage(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            })));
  }
}

class RowDialog extends StatefulWidget {
  const RowDialog(
      {super.key,
      required this.title,
      required this.onTap,
      required this.layoutController,
      required this.icon,
      this.margin = 0,
      this.isSelected = false});
  final String title;
  final VoidCallback onTap;
  final LayoutController layoutController;
  final IconData icon;
  final double margin;
  final bool isSelected;

  @override
  State<RowDialog> createState() => _RowDialogState();
}

class _RowDialogState extends State<RowDialog> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            widget.onTap();
          },
          child: Container(
            padding: EdgeInsets.all(AppSizes.instance.smallHPadding),
            margin: EdgeInsets.only(
              bottom: widget.margin,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: widget.isSelected
                  ? [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: const Offset(0, 3)),
                    ]
                  : [],
              color: widget.isSelected ? Colors.red.shade200 : null,
            ),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  size: 16,
                  color:
                      widget.isSelected ? Colors.white : Colors.grey.shade500,
                ),
                SizedBox(width: AppSizes.instance.mediumHPadding),
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: widget.isSelected ? Colors.white : Colors.black),
                ),
              ],
            ),
          ),
        ));
  }
}

class LeftSideMenu extends StatelessWidget {
  const LeftSideMenu({super.key, required this.layoutController});

  final LayoutController layoutController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Colors.grey.shade200,
                width: 2,
              ),
            ),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF1F3F7),
                Colors.white,
                Color(0xFFF7ECF1),
                Colors.white,
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(AppSizes.instance.largeHPadding),
          width: 300,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          layoutController.changePage(0);
                        },
                        child: SizedBox(
                          width: 100,
                          child: AspectRatio(
                            aspectRatio: 2 / 1,
                            child: SvgPicture.asset(AppImages.instance.logo),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await Core.instance.sharedPreferencesDataSource
                            .remove(SharedPreferencesKeys.userToken);
                        Core.instance.navigationCore
                            .pushReplacementNamed(NavigationRoutes.sign);
                      },
                      icon: Icon(FontAwesomeIcons.rightFromBracket,
                          weight: 0.8, size: 16, color: Colors.grey.shade500),
                    )
                  ]),
              Divider(
                color: Colors.grey.shade200,
                thickness: 0.5,
              ),
              SizedBox(height: AppSizes.instance.largeHPadding),
              Obx(() => Column(
                    children: List.generate(
                      2,
                      (index) => RowDialog(
                        title: index == 0 ? '주문 관리' : '상품 관리',
                        margin:
                            index == 0 ? AppSizes.instance.largeHPadding : 0,
                        isSelected:
                            index == layoutController.currentPageIndex.value,
                        icon: index == 0
                            ? FontAwesomeIcons.truckFast
                            : FontAwesomeIcons.box,
                        onTap: () {
                          layoutController.changePage(index);
                        },
                        layoutController: layoutController,
                      ),
                    ),
                  )),
              SizedBox(height: AppSizes.instance.mediumHPadding),
              Divider(
                color: Colors.grey.shade200,
                thickness: 0.5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
