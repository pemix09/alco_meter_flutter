import 'package:alco_meter_flutter/app/presentation/pages/make_photo.dart/subviews/camera_error.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class MakePhotoView extends StatefulWidget {
  static const routeName = 'make_photo';
  const MakePhotoView({super.key});

  @override
  State<MakePhotoView> createState() => _MakePhotoViewState();
}

class _MakePhotoViewState extends State<MakePhotoView> {
  late CameraController controller;
  late List<CameraDescription> _cameras;

  @override
  Future<void> initState() async {
    super.initState();
    _cameras = await availableCameras();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const CameraError(errorDesc: 'Error initializing camera');
    }
    return CupertinoPageScaffold(
      child: CameraPreview(controller),
    );
  }
}