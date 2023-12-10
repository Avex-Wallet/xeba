import 'package:avex_mobile/config/env/env.dart';

export 'env/env.dart';
export 'http/dio_config.dart';
export 'router/router.dart';

const kProductionMode = Env.productionMode;
const kShowDbInspector = kProductionMode ? !kProductionMode : Env.dbInspector;

const kVerifyToken = kProductionMode ? kProductionMode : Env.verifyToken;
