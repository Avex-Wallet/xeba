import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:avex_mobile/config/config.dart';
import 'package:avex_mobile/model/account/account_collection.dart';
import 'package:avex_mobile/model/token/token_model.dart';

final isarProvider = FutureProvider<Isar>(
  (ref) async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      [AccountSchema, TokenModelSchema],
      directory: dir.path,
      inspector: kShowDbInspector,
    );
  },
);
