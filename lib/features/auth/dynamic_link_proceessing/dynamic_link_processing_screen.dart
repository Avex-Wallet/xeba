import 'package:avex_mobile/config/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dynamic_link_processing_state_notifier.dart';

class DynamicLinkProcessingScreen extends ConsumerStatefulWidget {
  const DynamicLinkProcessingScreen({
    required this.authToken,
    Key? key,
  }) : super(key: key);
  final String authToken;

  @override
  ConsumerState createState() => _DynamicLinkProcessingScreenState();
}

class _DynamicLinkProcessingScreenState
    extends ConsumerState<DynamicLinkProcessingScreen> {
  @override
  void initState() {
    super.initState();
    ref
        .read(dynamicLinkProcessingStateNotifierProvider.notifier)
        .verifyDynamicLink(widget.authToken);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(dynamicLinkProcessingStateNotifierProvider, (previous, next) {
      if (next.status == DynamicLinkProcessingStateNotifierStatus.error) {
        // //debugprint("ERROR MESAAGE");
        Future.delayed(const Duration(milliseconds: 500), () {
          SignupScreenRoute().push(context);
          // AutoRouter.of(context).pushAndPopUntil(const SignupRoute(),
          //     predicate: (route) => false);
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.errorMessage.toString()),
          duration: const Duration(milliseconds: 300),
        ));
        // AutoRouter.of(context).navigateBack();
      }
      if (next.status == DynamicLinkProcessingStateNotifierStatus.loaded) {
        final userExistInBackend = ref.read(
            dynamicLinkProcessingStateNotifierProvider
                .select((value) => value.userExistsInBackend));
        if (userExistInBackend) {
          //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<CHANGE IT HERE
          Future.delayed(const Duration(milliseconds: 500), () {
            SeedRecoveryScreenRoute().go(context);
          });
        } else {
          Future.delayed(const Duration(milliseconds: 500), () {
            SetupOrImportNewAccountScreenRoute().go(context);
          });
        }
        //debugprint("dynamic link api done. ");
      }
      if (next.status ==
          DynamicLinkProcessingStateNotifierStatus.dynamicLinkVerified) {
        ref
            .read(dynamicLinkProcessingStateNotifierProvider.notifier)
            .checkWhetherUserExists();
        //debugprint("deep link successful");
      }
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
