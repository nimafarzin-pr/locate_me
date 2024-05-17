import 'dart:async';

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../model/place_item_model.dart';

class MyCustomMarker extends CustomPainter {
  final Place place;
  final int duration;

  MyCustomMarker(this.place, this.duration);

  void _buildMiniRect(Canvas canvas, Paint paint, double size) {
    paint.color = Colors.blue;
    final rect = Rect.fromLTWH(0, 0, size, size);
    canvas.drawRect(rect, paint);
  }

  Future<ui.Image> loadImageFromAsset() async {
    final ByteData data = await rootBundle.load(place.icon);
    final Uint8List bytes = data.buffer.asUint8List();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(bytes, (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }

  // void _buildParagraphAndImg({
  //   required Canvas canvas,
  //   required List<String> texts,
  //   required double width,
  //   required Offset offset,
  //   Color color = Colors.white,
  //   double fontSize = 18,
  //   String? fontFamily,
  //   TextAlign textAlign = TextAlign.left,
  // }) async {
  //   // Draw image if provided
  //   final ui.Image img = await loadImageFromAsset();
  //   final ui.ParagraphBuilder builder = ui.ParagraphBuilder(
  //     ui.ParagraphStyle(
  //       maxLines: 2,
  //       textAlign: textAlign,
  //     ),
  //   );
  //   builder.pushStyle(
  //     ui.TextStyle(
  //       color: color,
  //       fontSize: fontSize,
  //       fontFamily: fontFamily,
  //     ),
  //   );

  //   builder.addText(texts[0]);

  //   if (texts.length > 1) {
  //     builder.pushStyle(ui.TextStyle(
  //       fontWeight: FontWeight.bold,
  //     ));
  //     builder.addText(texts[1]);
  //   }

  //   final ui.Paragraph paragraph = builder.build();

  //   paragraph.layout(ui.ParagraphConstraints(width: width));
  //   canvas.drawParagraph(
  //     paragraph,
  //     Offset(offset.dx, offset.dy - paragraph.height / 2),
  //   );

  // final double imageWidth =
  //     paragraph.height; // Use paragraph height as image width
  // final double imageHeight =
  //     paragraph.height; // Use paragraph height as image height
  // canvas.drawImage(
  //   img,
  //   Offset(offset.dx - imageWidth - 5, offset.dy - imageHeight / 2),
  //   Paint(),
  // );
  // }
  void _buildParagraph({
    required Canvas canvas,
    required List<String> texts,
    required double width,
    required Offset offset,
    Color color = Colors.black,
    double fontSize = 18,
    String? fontFamily,
    TextAlign textAlign = TextAlign.left,
  }) async {
    final ui.Image img = await loadImageFromAsset();

    final ui.ParagraphBuilder builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        maxLines: 2,
        textAlign: textAlign,
      ),
    );
    builder.pushStyle(
      ui.TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
      ),
    );

    builder.addText(texts[0]);

    if (texts.length > 1) {
      builder.pushStyle(ui.TextStyle(
        fontWeight: FontWeight.bold,
      ));
      builder.addText(texts[1]);
    }

    const double imageWidth = 60; // Use paragraph height as image width
    const double imageHeight = 60; // Use paragraph height as image height
    canvas.drawImage(
      img,
      Offset(offset.dx - imageWidth - 5, offset.dy - imageHeight / 2),
      Paint(),
    );

    final ui.Paragraph paragraph = builder.build();

    paragraph.layout(ui.ParagraphConstraints(width: width));
    canvas.drawParagraph(
      paragraph,
      Offset(offset.dx, offset.dy - paragraph.height / 2),
    );
  }

  _shadow(Canvas canvas, double witdh, double height) {
    final path = Path();
    path.lineTo(0, height);
    path.lineTo(witdh, height);
    path.lineTo(witdh, 0);
    path.close();
    canvas.drawShadow(path, Colors.blue, 5, true);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    paint.color = Colors.deepOrangeAccent;

    final height = size.height - 15;
    _shadow(canvas, size.width, height);

    final RRect rrect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      height,
      const Radius.circular(0),
    );
    canvas.drawRRect(rrect, paint);

    final rect = Rect.fromLTWH(size.width / 2 - 2.5, height, 5, 200);

    canvas.drawRect(rect, paint);

    // _buildMiniRect(canvas, paint, height);

    // _buildParagraph(
    //   canvas: canvas,
    //   texts: ["$duration\n", "MIN"],
    //   width: height,
    //   fontSize: 24,
    //   textAlign: TextAlign.center,
    //   offset: Offset(0, height / 2),
    //   color: Colors.white,
    // );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

Future<Uint8List> placeToMarker(Place place, {required int duration}) async {
  ui.PictureRecorder recorder = ui.PictureRecorder();
  ui.Canvas canvas = ui.Canvas(recorder);
  const ui.Size size = ui.Size(300, 300);
  MyCustomMarker customMarker = MyCustomMarker(place, duration);
  customMarker.paint(canvas, size);
  ui.Picture picture = recorder.endRecording();
  final ui.Image image = await picture.toImage(
    size.width.toInt(),
    size.height.toInt(),
  );

  final ByteData? byteData = await image.toByteData(
    format: ui.ImageByteFormat.png,
  );
  return byteData!.buffer.asUint8List();
}
