import 'package:flutter/material.dart';

import 'package:avex_mobile/core/core.dart';

class NoTokenFoundWidget extends StatelessWidget {
  const NoTokenFoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Chip(
      backgroundColor: Colors.black26,
      avatar: NetworkAvatar(),
      label: Text('Token Not Found'),
    );
  }
}
