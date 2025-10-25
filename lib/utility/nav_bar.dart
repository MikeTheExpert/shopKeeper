// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class MyDropDownNav extends StatefulWidget {
//   const MyDropDownNav({super.key});
//
//   @override
//   State<MyDropDownNav> createState() => _MyDropDownNavState();
// }
//
// class _MyDropDownNavState extends State<MyDropDownNav> {
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(4),
//         child: Container(
//           width: MediaQuery.sizeOf(context).width,
//           padding: const EdgeInsets.all(4),
//           margin: const EdgeInsets.symmetric(horizontal: 8),
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             color: Colors.grey,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               MyIconBtn(
//                 icon: const Icon(
//                   Icons.home,
//                 ),
//                 onPressed: () {
//                   Navigator.pushNamed(context, 'home_page');
//                 },
//               ),
//               MyIconBtn(
//                   icon: const Icon(Icons.fact_check_outlined),
//                   onPressed: () {
//                     Navigator.of(context).pop;
//                     Navigator.pushNamed(context, 'request_form');
//                   }),
//               MyIconBtn(
//                   icon: const Icon(Icons.face),
//                   onPressed: () {
//                     Navigator.of(context).pop;
//                     Navigator.pushNamed(context, 'profile_page');
//                   }),
//               MyIconBtn(
//                   icon: const Icon(Icons.history_outlined),
//                   onPressed: () {
//                     Navigator.of(context).pop;
//                     Navigator.pushNamed(context, 'history_page');
//                   }),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class MyIconBtn extends StatefulWidget {
//   final Icon icon;
//   final Function()? onPressed;
//
//   const MyIconBtn({super.key, required this.icon, required this.onPressed});
//
//   @override
//   State<MyIconBtn> createState() => _MyIconBtnState();
// }
//
// class _MyIconBtnState extends State<MyIconBtn> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: 36,
//         width: 36,
//         child: IconButton(
//             onPressed: widget.onPressed,
//             icon: widget.icon,
//             color: Colors.redAccent));
//   }
// }
