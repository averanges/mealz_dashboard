import 'package:dashboard_mealz/common/consts/app_sizes.dart';
import 'package:dashboard_mealz/common/consts/images.dart';
import 'package:dashboard_mealz/presentation/item/view/file_upload/controllers/file_upload_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:skeleton_text/skeleton_text.dart';

class FileUpload extends StatelessWidget {
  FileUpload({super.key});

  final FileUploadController _fileUploadController =
      Get.find<FileUploadController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: AppSizes.instance.largeHPadding,
            right: AppSizes.instance.largeHPadding,
            top: AppSizes.instance.largeHPadding),
        child: Column(
          children: [
            DottedBorder(
              borderType: BorderType.RRect,
              dashPattern: const [10, 10],
              radius: const Radius.circular(12),
              padding: const EdgeInsets.all(6),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Obx(
                  () {
                    return SizedBox(
                      height: 280,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          DropzoneView(
                            operation: DragOperation.copy,
                            cursor: CursorType.grab,
                            onCreated: (controller) {
                              _fileUploadController
                                  .setDropzoneController(controller);
                            },
                            onDropFile: (file) async {
                              await _fileUploadController
                                  .dropZoneFileUpload(file);
                              _fileUploadController
                                  .setIsDragAndDropHovered(false);
                            },
                            onHover: () {
                              _fileUploadController
                                  .setIsDragAndDropHovered(true);
                            },
                            onLeave: () {
                              _fileUploadController
                                  .setIsDragAndDropHovered(false);
                            },
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.instance.smallHPadding,
                                vertical: AppSizes.instance.smallHPadding),
                            height: 280,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: _fileUploadController
                                      .isDragAndDropHovered.value
                                  ? Colors.blueGrey[100]
                                  : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image.asset(
                                        AppImages.instance.fileUpload),
                                  ),
                                ),
                                SizedBox(
                                    height: AppSizes.instance.mediumHPadding),
                                const Text('드래그 앤 드롭 파일 입력',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                    height: AppSizes.instance.smallHPadding),
                                const Text('똔는'),
                                SizedBox(
                                    height: AppSizes.instance.smallHPadding),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles(
                                              type: FileType.custom,
                                              allowedExtensions: [
                                                'xlsx',
                                                'xls',
                                                'csv',
                                              ],
                                              allowMultiple: false);
                                      if (result != null) {
                                        await _fileUploadController
                                            .filePickerFileUpload(result);
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              AppSizes.instance.smallHPadding),
                                      width: 125,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[300]!,
                                            blurRadius: 10,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                        color: Colors.red.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text('파일 선택',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: AppSizes.instance.mediumHPadding),
            Obx(() {
              return Visibility(
                  visible: _fileUploadController.files.isNotEmpty,
                  child: _fileUploadController.isLoading.value
                      ? SkeletonAnimation(
                          shimmerColor: Colors.red.withOpacity(0.5),
                          child: _buildHideLoadedFileContainer())
                      : _buildHideLoadedFileContainer());
            })
          ],
        ));
  }

  Widget _buildHideLoadedFileContainer() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: AppSizes.instance.smallHPadding,
          horizontal: AppSizes.instance.smallHPadding),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[100],
        border: Border.all(
          color: Colors.grey[300]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!.withOpacity(0.8),
            spreadRadius: -8.0,
            blurRadius: 10.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.instance.excelLogo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(_fileUploadController.files.isEmpty
                  ? ''
                  : _fileUploadController.files.last.name),
              SizedBox(width: AppSizes.instance.smallHPadding),
              Text(
                  '${_fileUploadController.files.isEmpty ? 0 : _fileUploadController.files.last.size}kb',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500])),
              SizedBox(width: AppSizes.instance.largeHPadding),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onHover: (event) {
                  print(event);
                },
                child: GestureDetector(
                  onTap: () {
                    _fileUploadController.openFile();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.instance.largeHPadding,
                        vertical: AppSizes.instance.smallHPadding),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black87),
                    child: const Text('파일 열기',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              )
            ],
          ),
          IconButton(
              onPressed: () {
                _fileUploadController.files.removeAt(0);
              },
              icon: Icon(Icons.close, size: 20, color: Colors.grey[500]))
        ],
      ),
    );
  }
}
