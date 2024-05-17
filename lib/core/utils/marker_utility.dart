import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerUtils {
  static Future<BitmapDescriptor> createCustomMarkerBitmap() async {
    const Size size = Size(60, 120);
    final PictureRecorder recorder = PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    _drawCustomMarker(canvas, size);

    final ui.Picture picture = recorder.endRecording();
    final ui.Image image =
        await picture.toImage(size.width.toInt(), size.height.toInt());
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      throw Exception("ByteData is null");
    }

    final Uint8List pngBytes = byteData.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(pngBytes);
  }

  static void _drawCustomMarker(Canvas canvas, Size size) {
    const double pinWidth = 5;
    const double pinHeight = 30;
    const double pinRadius = 2;

    final Paint pinPaint = Paint()
      ..color = Colors.blue.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final Paint pinShadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    final Path pinPath = Path()
      ..moveTo(size.width / 2, size.height - pinHeight)
      ..lineTo(size.width / 2 - pinWidth / 2, size.height)
      ..lineTo(size.width / 2 + pinWidth / 2, size.height)
      ..close();

    final Rect pinBodyRect = Rect.fromLTWH(
      size.width / 2 - pinWidth / 2,
      size.height - pinHeight - pinRadius,
      pinWidth,
      pinHeight + pinRadius,
    );

    final RRect pinBodyRRect =
        RRect.fromRectAndRadius(pinBodyRect, const Radius.circular(pinRadius));

    final Gradient pinGradient = LinearGradient(
      colors: [Colors.blue.withOpacity(0.9), Colors.blue.withOpacity(0.5)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    canvas.drawShadow(pinPath, Colors.black, 5, true);
    canvas.drawPath(pinPath,
        pinPaint..shader = pinGradient.createShader(pinPath.getBounds()));
    canvas.drawRRect(pinBodyRRect, pinShadowPaint);
  }

  static Future<BitmapDescriptor> createCustomMarkerBitmapWithNameAndImage(
      String imagePath, Size size, String name) async {
    TextSpan span = TextSpan(
        style: const TextStyle(
          height: 1.2,
          color: Colors.black,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        text: name);

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);

    const double shadowWidth = 15.0;
    const double borderWidth = 3.0;
    const double imageOffset = shadowWidth + borderWidth;

    final Radius radius = Radius.circular(size.width / 2);

    final Paint shadowCirclePaint = Paint()..color = Colors.yellow;

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              size.width / 8, size.width / 2, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowCirclePaint);

    // TEXT BOX BACKGROUND
    Paint textBgBoxPaint = Paint()..color = Colors.yellow;

    Rect rect = Rect.fromLTWH(
      0,
      0,
      tp.width + 35,
      50,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(10.0)),
      textBgBoxPaint,
    );

    //ADD TEXT WITH ALIGN TO CANVAS
    tp.paint(canvas, const Offset(20.0, 5.0));

    /* Do your painting of the custom icon here, including drawing text, shapes, etc. */

    Rect oval = Rect.fromLTWH(35, 78, size.width - (imageOffset * 2),
        size.height - (imageOffset * 2));

    // ADD  PATH TO OVAL IMAGE
    canvas.clipPath(Path()..addOval(oval));

    ui.Image image = await getImageFromPath(imagePath);
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    ui.Picture p = recorder.endRecording();
    ByteData? pngBytes = await (await p.toImage(300, 300))
        .toByteData(format: ui.ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes!.buffer);

    return BitmapDescriptor.fromBytes(data);
  }

  static Future<ui.Image> getImageFromPath(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath);
    final Uint8List bytes = data.buffer.asUint8List();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(bytes, (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }

  static Future<BitmapDescriptor> getMarkerIcon(
      String image, String name) async {
    Size s = const Size(120, 120);

    var icon = await createCustomMarkerBitmapWithNameAndImage(image, s, name);

    return icon;
  }
}
