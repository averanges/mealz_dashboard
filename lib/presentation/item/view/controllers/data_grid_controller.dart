import 'package:dashboard_mealz/common/shared_widgets/order_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataGridController extends GetxController {
  final RxList<DataColumn> columns = RxList.empty();
  final Rx<DataTableSource?> dataTableSource = Rx<DataTableSource?>(null);
  final RxInt hoveredRowIndex = 0.obs;

  void createDataGrid(List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      columns.clear();
      dataTableSource.value = null;
      return;
    }

    columns.value = data.first.keys
        .map((key) => DataColumn(
            label:
                Text(key, style: const TextStyle(fontWeight: FontWeight.bold))))
        .toList();

    dataTableSource.value = ExcelDataSource(data);
  }

  Future<void> showRow(int index) async {
    await showDialog(
        context: Get.context!,
        builder: (context) => const OrderDetailsDialog());
  }
}

class ExcelDataSource extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final DataGridController hoverStateController = Get.find();

  ExcelDataSource(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final row = data[index];

    return DataRow(
      color: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return Colors.red.shade200;
        }
        return null;
      }),
      onSelectChanged: (isSelected) async {
        if (isSelected != null && isSelected) {
          await hoverStateController.showRow(index);
        }
      },
      cells: row.values.map((value) {
        return DataCell(
          Text(value?.toString() ?? ''),
        );
      }).toList(),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
