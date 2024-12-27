import 'package:dashboard_mealz/common/consts/app_sizes.dart';
import 'package:dashboard_mealz/presentation/product/controllers/product_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: AppSizes.instance.largeHPadding,
            right: AppSizes.instance.largeHPadding,
            top: AppSizes.instance.largeHPadding),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [OrderTable()],
        ));
  }
}

class OrderTable extends StatelessWidget {
  const OrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.instance.largeHPadding,
            vertical: AppSizes.instance.largeHPadding),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(width: 0.5, color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[100]!.withOpacity(0.8),
              spreadRadius: -8.0,
              blurRadius: 10.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: MaterialApp(
          scrollBehavior: const MaterialScrollBehavior(),
          debugShowCheckedModeBanner: false,
          home: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: DataTable(
              showCheckboxColumn: false,
              border: TableBorder.all(),
              columnSpacing: 20,
              columns: const [
                DataColumn(label: Text('주문번호')),
                DataColumn(label: Text('주문상태')),
                DataColumn(label: Text('주문날짜')),
                DataColumn(label: Text('주소')),
              ],
              rows: [
                for (var i = 123457; i <= 123460; i++)
                  DataRow(
                    color: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.hovered)) {
                        return Colors.red.shade200;
                      }
                      return null;
                    }),
                    onSelectChanged: (isSelected) async {
                      if (isSelected != null && isSelected) {
                        await Get.find<ProductControllers>().showRow(i);
                      }
                    },
                    cells: [
                      DataCell(Text(i.toString())),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: const Text('준비중'),
                        ),
                      ),
                      const DataCell(Text('2024-01-01 00:00:00')),
                      const DataCell(Text('부산 진구 금융센터')),
                    ],
                  ),
              ],
            ),
          ),
        ));
  }
}
