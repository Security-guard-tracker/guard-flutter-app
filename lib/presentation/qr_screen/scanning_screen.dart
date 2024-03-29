import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sgt/presentation/property_details_screen/model/shift_details_modal.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import '../clocked_in_out_screen/clock_in_screen.dart';

class ScanningScreen extends StatefulWidget {
  int? propertyId;
  ScanningScreen({super.key,this.propertyId});

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  final qrKey = GlobalKey(debugLabel: "Qr");
  QRViewController? controller;
  Barcode? result;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }


  shiftIdRetrive(result) async {
    print("widget.qrData =====> ${result?.code}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final ShiftDetailsModal shiftDetails = shiftDetailsModalFromJson(result?.code);
    String? shiftId = shiftDetails.shiftDetails!.shiftId.toString();
    // String? jsonString = result?.code.toString();
    // Map<String, dynamic> jsonData = jsonDecode(jsonString!);
    // int shiftId = jsonData['shift_details']['shift_id'];
    print('Shift ID: $shiftId');
    // print("==============jsonString===================>   ${jsonString}");
    // print("==============ShiftStatus===================>   ${jsonData}");
    shiftDetails.shiftDetails!.clockOut == null ? 
    await prefs.setString('shiftId', shiftId) : print("-------------------------------------");
  }
  
  @override
  Widget build(BuildContext context) {
    return result != null
        ? ClockInScreen(propId:widget.propertyId) //if the qr has data then it will show clock in screen
        : MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Scaffold(
              appBar: CustomAppBarWidget(appbarTitle: 'QR Scan'),
              backgroundColor: white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Column(children: [
                  SizedBox(
                    height: 69,
                  ),
                  const Text(
                    'Clock in',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Scan QR code\n to clock in!',
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17, color: Colors.grey,fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 88),
                  SizedBox(height: 242, width: 242, child: buildQrView(context))
                ]),
              ),
            ),
          );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderLength: 70,
          borderColor: greenColor,
          overlayColor: Colors.white,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
          borderWidth: 5,
          borderRadius: 7,
        ),
      );

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.resumeCamera();

    controller.scannedDataStream.listen((scanData) {
      log(scanData.code.toString());
      HapticFeedback.vibrate();
      setState(() {
        result = scanData;
        shiftIdRetrive(result);
      });
    });
    this.controller!.pauseCamera();
    this.controller!.resumeCamera();
  }
}
