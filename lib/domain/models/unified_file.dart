import 'dart:math';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class UnifiedFile {
  final String id;
  final String name;
  final Uint8List? bytes;
  final DateTime? createdAt;
  final int size;

  UnifiedFile({
    required this.id,
    required this.name,
    required this.bytes,
    required this.createdAt,
    required this.size,
  });

  factory UnifiedFile.fromDropZoneFileType(
      DropzoneFileInterface file, Uint8List bytes) {
    return UnifiedFile(
      id: Random().nextInt(1000000).toString(),
      name: file.name,
      bytes: bytes,
      size: file.size,
      createdAt: DateTime.now(),
    );
  }

  factory UnifiedFile.fromPlatformFileType(PlatformFile file) {
    return UnifiedFile(
      id: Random().nextInt(1000000).toString(),
      name: file.name,
      bytes: file.bytes,
      size: file.size,
      createdAt: DateTime.now(),
    );
  }
}
