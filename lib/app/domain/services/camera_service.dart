import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService {
  late CameraController controller;
  late List<CameraDescription> cameras;

  Future<Widget> takePicture() async {
    return CameraPreview(controller);
  }

  Future<bool> requestCameraPermission() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();
      controller = CameraController(cameras[0], ResolutionPreset.max);
      await controller.initialize();

      if (!controller.value.isInitialized) {
        throw 'Error initializing camera';
      }

      return true;
    }

    throw 'Camera permission denied';
  }
}
