// // notification_details.dart
// import 'package:flutter/material.dart';
// import 'package:stage_mgt_app/backend/models/notification.dart';

// class NotificationDetails extends StatelessWidget {
//   final NotificationModel notification;

//   const NotificationDetails({
//     super.key,
//     required this.notification,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Notification Details'),
//         backgroundColor: Colors.blueAccent[700],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Card(
//               elevation: 4.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundColor: notification.isNew
//                               ? Colors.blueAccent
//                               : Colors.grey.shade300,
//                           child: Icon(
//                             notification.isNew
//                                 ? Icons.notifications_active
//                                 : Icons.notifications_none,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(width: 16.0),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 notification.title,
//                                 style: const TextStyle(
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 4.0),
//                               Text(
//                                 notification.time,
//                                 style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 14.0,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16.0),
//                     const Divider(),
//                     const SizedBox(height: 16.0),
//                     Text(
//                       'Message:',
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 8.0),
//                     Text(
//                       notification.message,
//                       style: const TextStyle(fontSize: 16.0),
//                     ),
//                     const SizedBox(height: 16.0),
//                     Text(
//                       'Details:',
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 8.0),
//                     const Text(
//                       "notification.description",
//                       style: TextStyle(fontSize: 16.0),
//                     ),
//                     const SizedBox(height: 16.0),
//                     Text(
//                       'Date:',
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 8.0),
//                     const Text(
//                       "notification.date.toString()",
//                       style: TextStyle(fontSize: 16.0),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
