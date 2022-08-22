import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

SizedBox shimmerEffectCalender(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.grey.shade100,
            child: ListView.builder(
              itemBuilder: (_, __) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                padding: const EdgeInsets.only(
                    left: 7, right: 7, top: 20, bottom: 7),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.grey.shade300,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 48.0,
                      height: 30.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              itemCount: 6,
            ),
          ),
        ),
      ],
    ),
  );
}
