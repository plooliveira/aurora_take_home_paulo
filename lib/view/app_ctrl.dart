import 'dart:async';
import 'dart:typed_data';

import 'package:aurora_take_home_paulo/core/image_palette.dart';
import 'package:aurora_take_home_paulo/core/result.dart';
import 'package:aurora_take_home_paulo/core/theme.dart';
import 'package:aurora_take_home_paulo/data/models/image_data.dart';
import 'package:aurora_take_home_paulo/data/repositories/image_repository.dart';
import 'package:ctrl/ctrl.dart';
import 'package:flutter/material.dart';

class ImageBundle {
  String url = '';
  ImageProvider? image;
  List<Color> colorPallete = [];
  bool hasError = false;
}

class AppCtrl with Ctrl {
  AppCtrl(this.imageRepository);

  final ImageRepository imageRepository;
  late final _imageData = mutable<ImageBundle>(ImageBundle());
  late final Observable<ImageBundle> imageData = _imageData;
  late final Observable<Brightness> brightness = Locator()
      .get<AppThemeCtrl>()
      .brightness;

  late final Observable<ColorScheme> colorScheme = scope.merge(
    [imageData, brightness],
    () {
      if (imageData.value.colorPallete.isEmpty) {
        return ColorScheme.fromSeed(
          seedColor: Colors.white,
          dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
        );
      }
      return ColorScheme.fromSeed(
        seedColor: imageData.value.colorPallete.first,
        dynamicSchemeVariant: DynamicSchemeVariant.content,
        brightness: brightness.value,
      );
    },
  );

  void getNewImage() async {
    beginLoading();
    final result = await imageRepository.get();
    if (result is Success<ImageData>) {
      final bytes = await imageRepository.download(result.data.url);
      if (bytes is Success<Uint8List>) {
        final ImageProvider imageProvider = ResizeImage(
          MemoryImage(bytes.data),
          width: 600, // I think is good enough for the app
          policy: ResizeImagePolicy.fit,
        );
        final colorResult = await getColorsFromImage(imageProvider);
        if (colorResult is Success<List<Color>>) {
          await _preDecodeImage(imageProvider);

          _imageData.update((value) {
            value.url = result.data.url;
            value.image = imageProvider;
            value.hasError = false;
            value.colorPallete = colorResult.data;
          });
        } else {
          _imageData.update((value) {
            value.hasError = true;
            value.image = null;
            value.colorPallete = [];
          });
        }
      } else {
        _imageData.update((value) {
          value.hasError = true;
          value.image = null;
          value.colorPallete = [];
        });
      }
    } else {
      _imageData.update((value) {
        value.hasError = true;
        value.image = null;
        value.colorPallete = [];
      });
    }
    completeLoading();
  }

  Future<void> _preDecodeImage(ImageProvider provider) async {
    final completer = Completer<void>();
    final stream = provider.resolve(const ImageConfiguration());
    late ImageStreamListener listener;

    listener = ImageStreamListener(
      (info, synchronousCall) {
        stream.removeListener(listener);
        if (!completer.isCompleted) {
          completer.complete();
        }
      },
      onError: (error, stackTrace) {
        stream.removeListener(listener);
        if (!completer.isCompleted) {
          completer.complete();
        }
      },
    );

    stream.addListener(listener);
    return completer.future;
  }
}
