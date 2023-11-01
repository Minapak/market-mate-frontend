// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:sip_app/constants/colors.dart';
//
// import 'package:sip_app/modules/expert/providers/experts_provider.dart';
// import 'package:sip_app/modules/expert/providers/experts_submit_provider.dart';
// import 'package:sip_app/modules/expert/providers/experts_upload_image_provider.dart';
//
// import '../providers/experts_upload_intro_detail_provider.dart';
//
// class ExpertRegisterSubmitButton extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//
//
//     void onClickMoveNextStep() {
//       ref.read(ExpertRegisterSubmitProvider.notifier).onSubmit();
//       // context.push('/signup/password');
//     }
//
//     return GestureDetector(
//         onTap:() {
//           onClickMoveNextStep();
//         },
//         child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children  : [
//               Container(
//                 width: 160,
//                 height: 54,
//                 decoration: BoxDecoration(
//                  // color: canClick ? BUTTON_PRIMARY_COLOR : INPUT_BORDER_GRAY_COLOR,
//                   borderRadius: BorderRadius.circular(100),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text('완료', style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700
//                     ),),
//                   ],
//                 ),
//               ),
//             ]
//         )
//     );
//   }
// }