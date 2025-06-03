import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_sync/core/themes/app_color.dart';
import 'package:healthy_sync/core/themes/styles.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final ImagePicker _picker = ImagePicker();
  final MobileScannerController controller = MobileScannerController();
  bool isFlashOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainBlue,
        title: Text(
          'QR Scanner',
          style: TextStyles.font20WhiteBold,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.white, size: 22.sp),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.toggleTorch();
              setState(() {
                isFlashOn = !isFlashOn;
              });
            },
            icon: Icon(
              isFlashOn ? Icons.flash_on : Icons.flash_off,
              color: AppColor.white,
              size: 24.sp,
            ),
          ),
          IconButton(
            onPressed: () async {
              await controller.switchCamera();
            },
            icon: Icon(
              Icons.flip_camera_ios,
              color: AppColor.white,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  Navigator.pop(context, barcode.rawValue);
                  break;
                }
              }
            },
          ),
          Center(
            child: Container(
              width: 250.w,
              height: 250.w,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.mainBlue,
                  width: 2.w,
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
          Positioned(
            bottom: 30.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final XFile? image = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image != null) {
                      // Here you would typically use a QR code scanning library
                      // For now, we'll just simulate a scan
                      Navigator.pop(context, "123456789");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.mainBlue,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.sp,
                      vertical: 12.sp,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  icon: Icon(
                    Icons.image,
                    color: AppColor.white,
                    size: 24.sp,
                  ),
                  label: Text(
                    'Scan from Gallery',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
