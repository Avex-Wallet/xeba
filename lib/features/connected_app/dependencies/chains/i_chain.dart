import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class IChain {
  String getNamespace();
  String getChainId();
  List<String> getEvents();
  void setRef(WidgetRef widgetRef);
}
