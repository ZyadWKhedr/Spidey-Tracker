import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants/app_colors.dart';

abstract final class MarkerGenerator {
  static BitmapDescriptor? _cachedSpideyMarker;

  /// Creates a custom BitmapDescriptor marker from an asset image with safe test fallback.
  static Future<BitmapDescriptor> getSpideyMarker({int width = 90}) async {
    if (_cachedSpideyMarker != null) {
      return _cachedSpideyMarker!;
    }

    try {
      final ByteData data =
          await rootBundle.load('assets/images/spidey_icon.png');
      final ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: width,
      );
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ui.Image image = frameInfo.image;

      // Draw the image on a canvas with a subtle circular badge backing & pin shadow
      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(recorder);
      final double canvasSize = width.toDouble() + 24;
      final double center = canvasSize / 2;
      final double radius = width.toDouble() / 2 + 6;

      // Outer shadow
      final Paint shadowPaint = Paint()
        ..color = Colors.black.withValues(alpha: 0.45)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawCircle(Offset(center, center + 3), radius, shadowPaint);

      // Black pixel border
      final Paint borderPaint = Paint()
        ..color = AppColors.pixelBlack
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(center, center), radius, borderPaint);

      // Badge Cream inner circle
      final Paint badgePaint = Paint()
        ..color = AppColors.badgeCream
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(center, center), radius - 3, badgePaint);

      // Draw Spidey Mask in center
      final double iconOffset = (canvasSize - width) / 2;
      canvas.drawImage(
        image,
        Offset(iconOffset, iconOffset),
        Paint(),
      );

      final ui.Picture picture = recorder.endRecording();
      final ui.Image finalImage = await picture.toImage(
        canvasSize.toInt(),
        canvasSize.toInt(),
      );
      final ByteData? byteData = await finalImage.toByteData(
        format: ui.ImageByteFormat.png,
      );

      _cachedSpideyMarker =
          BitmapDescriptor.bytes(byteData!.buffer.asUint8List());
      return _cachedSpideyMarker!;
    } catch (_) {
      // Fallback for headless unit test environments
      _cachedSpideyMarker =
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
      return _cachedSpideyMarker!;
    }
  }

  /// Creates a custom dynamic Cluster Marker with count text
  static Future<BitmapDescriptor> getClusterMarker({
    required int count,
    int size = 110,
  }) async {
    try {
      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(recorder);
      final double center = size / 2;
      final double radius = center - 8;

      // Outer Glow
      final Paint glowPaint = Paint()
        ..color = (count > 25 ? AppColors.spideyRed : AppColors.primarySkyBlue)
            .withValues(alpha: 0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(Offset(center, center), radius + 4, glowPaint);

      // Black Border
      final Paint borderPaint = Paint()
        ..color = AppColors.pixelBlack
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(center, center), radius, borderPaint);

      // Main Cluster Fill
      final Paint fillPaint = Paint()
        ..color = count > 50
            ? AppColors.spideyRed
            : (count > 15 ? AppColors.alertOrange : AppColors.primarySkyBlue)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(center, center), radius - 3.5, fillPaint);

      // Text Painter for count
      final String text = count > 99 ? '99+' : '$count';
      final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: text,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: AppColors.pixelBlack,
            fontFamily: 'monospace',
            letterSpacing: -0.5,
          ),
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          center - (textPainter.width / 2),
          center - (textPainter.height / 2),
        ),
      );

      final ui.Picture picture = recorder.endRecording();
      final ui.Image image = await picture.toImage(size, size);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      return BitmapDescriptor.bytes(byteData!.buffer.asUint8List());
    } catch (_) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    }
  }
}
