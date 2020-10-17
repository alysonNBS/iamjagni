import 'package:flutter/material.dart';
import 'package:iamjagni/models/profile/experience/index.dart';
import 'package:iamjagni/utils/layout.dart';
import 'package:iamjagni/widgets/expandable_card.dart';
import 'package:iamjagni/widgets/image/cached_image_wrapper.dart';

class ExperienceTile extends StatelessWidget {
  final Experience experience;

  const ExperienceTile({Key key, this.experience}) : super(key: key);

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Row(children: <Widget>[
      Expanded(
        child: Stack(
          children: [
            Positioned(
                left: 9,
                top: 0,
                bottom: 0,
                child: Container(color: theme.dividerColor, width: 2)),
            Positioned(
              top: 22.5 + AppLayout.paddingSize,
              child: Container(
                width: 20,
                height: 20,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    color: theme.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(50),
                        blurRadius: 1,
                        offset: new Offset(0.0, 1.0),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 25,
                  bottom: AppLayout.paddingSize,
                  top: AppLayout.paddingSize),
              child: ExpandableContainer(
                header: Row(children: [
                  SizedBox(width: AppLayout.paddingSize / 2),
                  SizedBox(
                      width: 40,
                      height: 40,
                      child: CachedImageWrapper(
                          url: experience.data.icon, fit: BoxFit.contain)),
                  SizedBox(width: AppLayout.paddingSize / 2),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Líder Técnico", style: textTheme.headline6),
                      SizedBox(height: 3),
                      Text("Unichristus",
                          style: textTheme.subtitle1
                              .apply(color: textTheme.bodyText1.color)),
                      SizedBox(height: 3),
                      Text("ago/2019 - jul/2020", style: textTheme.caption)
                    ],
                  )),
                ]),
                content: Padding(
                  padding: EdgeInsets.only(
                      top: 8.0,
                      left: 40 + AppLayout.paddingSize,
                      right: AppLayout.paddingSize),
                  child: Text(
                    "asd ipsum dolor sit amet sdasd sad ad ada dadad asda dadad asdas dad",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
