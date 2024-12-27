import 'package:dashboard_mealz/common/consts/app_sizes.dart';
import 'package:dashboard_mealz/common/utils/horizontal_scroll_for_tables.dart';
import 'package:dashboard_mealz/presentation/item/view/controllers/data_grid_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataGrid extends StatelessWidget {
  DataGrid({super.key});

  final DataGridController controller = Get.find<DataGridController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.instance.largeHPadding,
            vertical: AppSizes.instance.largeHPadding),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          boxShadow: [
            BoxShadow(
              color: Colors.grey[100]!.withOpacity(0.8),
              spreadRadius: -8.0,
              blurRadius: 10.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[300]!,
              ),
            ),
            height: 500,
            width: 500,
            child: controller.columns.isEmpty || controller.columns.isEmpty
                ? const Center(
                    child: Text('No data'),
                  )
                : Obx(
                    () => MaterialApp(
                        debugShowCheckedModeBanner: false,
                        scrollBehavior: MyMaterialScrollBehavior(),
                        home: SingleChildScrollView(
                          child: PaginatedDataTable(
                            showCheckboxColumn: false,
                            source: controller.dataTableSource.value!,
                            rowsPerPage: PaginatedDataTable.defaultRowsPerPage,
                            columns: controller.columns.map((column) {
                              return DataColumn(
                                label: DefaultTextStyle(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.grey[300],
                                  ),
                                  child: column.label,
                                ),
                              );
                            }).toList(),
                          ),
                        )),
                  )));
  }
}
