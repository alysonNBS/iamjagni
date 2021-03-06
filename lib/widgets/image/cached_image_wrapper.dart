import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iamjagni/utils/layout.dart';
import 'package:iamjagni/widgets/image/status.dart';

class CachedImageWrapper extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final Alignment alignment;
  const CachedImageWrapper(
      {Key key,
      this.url,
      this.fit = BoxFit.cover,
      this.alignment = Alignment.center})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final smallestMeasure = min(constraints.maxWidth, constraints.maxHeight);
      return CachedNetworkImage(
          fit: fit,
          imageUrl: url,
          alignment: alignment,
          fadeInDuration: Duration(milliseconds: 250),
          placeholderFadeInDuration: Duration(milliseconds: 250),
          fadeOutDuration: Duration(milliseconds: 100),
          placeholder: (context, url) => Center(
              child: SizedBox(
                  width: smallestMeasure / 2,
                  height: smallestMeasure / 2,
                  child: LoadingImage())),
          errorWidget: (context, url, error) => Container(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(AppLayout.paddingSize),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: smallestMeasure / 3, child: ErrorImage()),
                      Flexible(
                        child: Text(
                          'Ops! Houve um erro ao obter esta imagem',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                ),
              ));
    });
  }
}
