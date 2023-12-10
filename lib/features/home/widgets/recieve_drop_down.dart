// import 'package:avex_mobile/features/main/home/home_state_notifier.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class RecieveDropDown extends ConsumerWidget {
//   const RecieveDropDown({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final publicKey = ref
//         .watch(homeStateNortifierProvider.select((value) => value.myPublicKey));
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Container(
//               height: 4,
//               width: 60,
//               color: Colors.white,
//             ),
//             const SizedBox(
//               height: 22,
//             ),
//             Text(
//               textAlign: TextAlign.center,
//               "Recieve",
//               style: GoogleFonts.inter(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//             Text(
//               textAlign: TextAlign.center,
//               "Account Name",
//               style: GoogleFonts.inter(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Container(
//                 decoration: const BoxDecoration(
//                     color: Colors.white30,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(40.0),
//                     )),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text("Etherium MainNet",
//                           style: GoogleFonts.roboto(fontSize: 14)),
//                       Icon(Icons.expand_more)
//                     ],
//                   ),
//                 )),
//             const SizedBox(
//               height: 24,
//             ),
//             (publicKey == null)
//                 ? const SizedBox.square(
//                     dimension: 200,
//                     child: Center(child: CircularProgressIndicator()))
//                 : Container(
//                     width: 200,
//                     color: Colors.white,
//                     child: QrImageView(data: publicKey)),
//             const SizedBox(
//               height: 24,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
