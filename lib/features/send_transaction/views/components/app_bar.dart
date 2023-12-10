import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/themes/themes.dart';

AppBar appBar(BuildContext context) => AppBar(
      title: Text('Send', style: inter.copyWith(fontSize: 22)),
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20),
        onPressed: () => context.pop(),
      ),
    );
