import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

SizedBox shimmerEffectAttandance(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: ListView.builder(
              itemBuilder: (_, __) => Container(
                margin: const EdgeInsets.all(7),
                height: MediaQuery.of(context).size.height * 0.22,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 25.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.grey.shade300,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 48.0,
                      height: 68.0,
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
