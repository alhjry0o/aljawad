import 'dart:io';
import 'dart:math' as math;

import 'package:image/image.dart' as img;

const int canvasSize = 1024;

// حجم الشعار النهائي داخل Canvas.
// 640px = حوالي 62.5% من مساحة 1024.
const int logoSize = 640;

const String sourcePath = 'assets/images/logo.png';
const String appIconPath = 'assets/logo/app_icon.png';
const String foregroundPath = 'assets/logo/app_icon_foreground.png';

Future<void> main() async {
  final sourceFile = File(sourcePath);

  if (!sourceFile.existsSync()) {
    stderr.writeln('ERROR: Source logo not found: $sourcePath');
    exitCode = 1;
    return;
  }

  final sourceBytes = await sourceFile.readAsBytes();
  final decoded = img.decodeImage(sourceBytes);

  if (decoded == null) {
    stderr.writeln('ERROR: Could not decode logo PNG.');
    exitCode = 1;
    return;
  }

  print('Source logo: ${decoded.width}x${decoded.height}');

  // تحويل إلى RGBA لضمان وجود قناة شفافية.
  final source = decoded.convert(numChannels: 4);

  // اكتشاف الحدود الحقيقية للشعار اعتماداً على Alpha.
  final bounds = _findAlphaBounds(source);

  if (bounds == null) {
    stderr.writeln(
      'ERROR: No transparent logo bounds were detected. '
      'Make sure logo.png has a transparent background.',
    );
    exitCode = 1;
    return;
  }

  print(
    'Detected logo bounds: '
    'x=${bounds.left}, y=${bounds.top}, '
    'w=${bounds.width}, h=${bounds.height}',
  );

  // قص الفراغ الشفاف الخارجي من الشعار.
  final cropped = img.copyCrop(
    source,
    x: bounds.left,
    y: bounds.top,
    width: bounds.width,
    height: bounds.height,
  );

  // الحفاظ على نسبة الشعار الأصلية.
  final scale = logoSize / math.max(cropped.width, cropped.height);

  final resizedWidth = math.max(1, (cropped.width * scale).round());
  final resizedHeight = math.max(1, (cropped.height * scale).round());

  final resized = img.copyResize(
    cropped,
    width: resizedWidth,
    height: resizedHeight,
    interpolation: img.Interpolation.cubic,
  );

  // إنشاء Canvas شفاف 1024x1024.
  final appIcon = img.Image(
    width: canvasSize,
    height: canvasSize,
    numChannels: 4,
  );

  appIcon.clear(img.ColorRgba8(0, 0, 0, 0));

  // توسيط الشعار أفقياً وعمودياً.
  final x = ((canvasSize - resized.width) / 2).round();
  final y = ((canvasSize - resized.height) / 2).round();

  img.compositeImage(
    appIcon,
    resized,
    dstX: x,
    dstY: y,
    blend: img.BlendMode.alpha,
  );

  // إنشاء مجلد assets/logo إن لم يكن موجوداً.
  Directory('assets/logo').createSync(recursive: true);

  // حفظ app_icon.png.
  await File(appIconPath).writeAsBytes(
    img.encodePng(appIcon),
  );

  // نفس الشعار الشفاف للـAdaptive Foreground.
  // نستخدم نفس Canvas والحجم والتوسيط.
  final foreground = appIcon.clone();

  await File(foregroundPath).writeAsBytes(
    img.encodePng(foreground),
  );

  print('');
  print('SUCCESS: Icon assets prepared.');
  print('Created: $appIconPath');
  print('Created: $foregroundPath');
  print('Canvas: ${canvasSize}x$canvasSize');
  print('Logo max dimension: $logoSize px');
  print('Approximate padding: ${(canvasSize - logoSize) ~/ 2}px');
}
 
class _Bounds {
  final int left;
  final int top;
  final int right;
  final int bottom;

  const _Bounds({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  int get width => right - left + 1;
  int get height => bottom - top + 1;
}

_Bounds? _findAlphaBounds(img.Image image) {
  int left = image.width;
  int top = image.height;
  int right = -1;
  int bottom = -1;

  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      final pixel = image.getPixel(x, y);

      // أي بكسل له Alpha أكبر من 8 يعتبر جزءاً من الشعار.
      if (pixel.a > 8) {
        if (x < left) left = x;
        if (x > right) right = x;
        if (y < top) top = y;
        if (y > bottom) bottom = y;
      }
    }
  }

  if (right < 0 || bottom < 0) {
    return null;
  }

  return _Bounds(
    left: left,
    top: top,
    right: right,
    bottom: bottom,
  );
}
