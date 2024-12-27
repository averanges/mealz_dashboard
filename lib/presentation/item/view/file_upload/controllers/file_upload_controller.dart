import 'package:dashboard_mealz/core/core.dart';
import 'package:dashboard_mealz/domain/models/unified_file.dart';
import 'package:dashboard_mealz/presentation/item/controllers/item_page_controller.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class FileUploadController extends GetxController {
  final RxList<UnifiedFile> files = RxList.empty();
  final RxBool _isDragAndDropHovered = RxBool(false);

  final RxBool _isLoading = RxBool(false);

  late DropzoneViewController dropzoneController;

  RxBool get isDragAndDropHovered => _isDragAndDropHovered;
  RxBool get isLoading => _isLoading;

  final ItemPageController _homeController = Get.find<ItemPageController>();

  void setIsDragAndDropHovered(bool value) {
    _isDragAndDropHovered.value = value;
  }

  void setDropzoneController(DropzoneViewController controller) {
    dropzoneController = controller;
  }

  Future<void> dropZoneFileUpload(DropzoneFileInterface file) async {
    try {
      Core.instance.logger.i('Dropzone file upload started');
      final mime = await dropzoneController.getFileMIME(file);

      if (mime !=
              'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' &&
          mime != 'application/vnd.ms-excel' &&
          mime != 'text/csv') {
        Get.snackbar('Error', 'File type not supported',
            snackPosition: SnackPosition.BOTTOM,
            dismissDirection: DismissDirection.horizontal,
            margin: const EdgeInsets.only(bottom: 10),
            maxWidth: 350,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return;
      }
      Core.instance.logger.i('File name: ${file.name}');
      Uint8List? bytes = await dropzoneController.getFileData(file);
      UnifiedFile unifiedFile = UnifiedFile.fromDropZoneFileType(file, bytes);
      files.add(unifiedFile);
    } catch (e) {
      Core.instance.logger.e(e);
    }
  }

  void removeFile(int index) {
    files.removeAt(index);
  }

  Future<void> filePickerFileUpload(FilePickerResult result) async {
    try {
      Core.instance.logger.i('File picker file upload started');
      PlatformFile file = result.files.first;
      UnifiedFile unifiedFile = UnifiedFile.fromPlatformFileType(file);
      files.add(unifiedFile);
    } catch (e) {
      Core.instance.logger.e(e);
    }
  }

  void openFile() async {
    Core.instance.logger.d('File open started');
    try {
      _isLoading.value = true;
      final UnifiedFile file = files.last;
      if (file.bytes == null) {
        Get.snackbar('Error', 'File not found',
            snackPosition: SnackPosition.BOTTOM,
            dismissDirection: DismissDirection.horizontal,
            margin: const EdgeInsets.only(bottom: 10),
            maxWidth: 350,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }

      final Uint8List bytes = file.bytes!;
      final excel = Excel.decodeBytes(bytes);
      final data = await parseExcelInBackground(excel);
      // _homeController.parseExcelData(data);
      _homeController.dataGridController.createDataGrid(data);

      _homeController.changePage(1);
    } catch (e) {
      Core.instance.logger.e(e);
      Get.snackbar('Error', '오류가 발생했어요!',
          snackPosition: SnackPosition.BOTTOM,
          dismissDirection: DismissDirection.horizontal,
          margin: const EdgeInsets.only(bottom: 10),
          maxWidth: 350,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      _isLoading.value = false;
    }
  }

  // void _parseExcel(Uint8List bytes) {
  // final workbook = xlsio.Workbook.withCulture(culture)
  // final sheet = workbook.worksheets[0];
  // for (int row = 1; row <= sheet.getLastRow(); row++) {
  //   for (int col = 1; col <= sheet.getLastColumn(); col++) {
  //     print(sheet.getRangeByIndex(row, col).text);
  //   }
  // }
  // workbook.dispose();
}

Future<List<Map<String, dynamic>>> parseExcelInBackground(Excel excel) async {
  return await compute(_parseExcelData, excel);
}

List<Map<String, dynamic>> _parseExcelData(Excel excel) {
  final List<Map<String, dynamic>> parsedData = [];

  try {
    // Get the first sheet (you can modify this to handle multiple sheets)
    final sheetName = excel.tables.keys.first;
    final sheet = excel.tables[sheetName];

    if (sheet == null || sheet.rows.isEmpty) {
      throw Exception('No data found in the sheet.');
    }

    // Assuming the first row contains headers
    final headers =
        sheet.rows.first.map((cell) => cell?.value?.toString() ?? '').toList();

    // Parse rows (skip the header row)
    for (int i = 1; i < sheet.rows.length; i++) {
      final row = sheet.rows[i];
      final rowData = <String, dynamic>{};

      for (int j = 0; j < headers.length; j++) {
        final header = headers[j];
        final cellValue = row[j]?.value;

        rowData[header] = cellValue;
      }

      parsedData.add(rowData);
    }
  } catch (e) {
    Core.instance.logger.e('Error parsing Excel data: $e');
  }

  return parsedData;
}
