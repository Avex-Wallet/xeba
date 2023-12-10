import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingTokenListView extends StatelessWidget {
  const LoadingTokenListView({super.key, this.radius = 35});
  final double radius;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mq = MediaQuery.of(context);
    return Shimmer.fromColors(
      baseColor: Colors.white54,
      highlightColor: Colors.black12,
      child: ListView.builder(
        itemCount: 12,
        itemBuilder: (_, i) => ListTile(
          contentPadding: const EdgeInsets.only(left: 10, right: 16),
          leading: CircleAvatar(
            radius: radius,
            backgroundColor: Colors.white12,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 16,
                color: Colors.white12,
                width: mq.size.width * .3,
              ),
              Container(
                height: 16,
                color: Colors.white12,
                width: mq.size.width * .25,
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 14,
                color: Colors.white12,
                width: mq.size.width * 0.15,
              ),
              Container(
                height: 14,
                color: Colors.white12,
                width: mq.size.width * 0.2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
