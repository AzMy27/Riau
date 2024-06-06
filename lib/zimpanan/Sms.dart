// import 'package:flutter/material.dart';
// import 'package:flutter_sms/flutter_sms.dart';

// class MySMSDemo extends StatefulWidget {
//   const MySMSDemo({super.key, required this.title});
//   final String title;
//   @override
//   _MySMSDemoState createState() => _MySMSDemoState();
// }

// class _MySMSDemoState extends State<MySMSDemo> {
//   final TextEditingController _numController = TextEditingController();
//   final TextEditingController _msgController = TextEditingController();
//   String _message = "";
//   void _sendSMS(List<String> numbers, String message) async {
//     try {
//       String result = await sendSMS(message: message, recipients: numbers);
//       setState(() => _message = result);
//     } catch (error) {
//       setState(() => _message = error.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Demo kirim SMS'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: <Widget>[
//               TextField(
//                 controller: _numController,
//                 keyboardType: TextInputType.phone,
//                 decoration: const InputDecoration(
//                   hintText: 'Masukan nomor handphone',
//                 ),
//               ),
//               Container(
//                 height: 30.0,
//               ),
//               TextField(
//                 controller: _msgController,
//                 maxLines: 5,
//                 decoration: const InputDecoration(
//                   hintText: 'Pesan SMS',
//                 ),
//               ),
//               Container(
//                 height: 30.0,
//               ),
//               FloatingActionButton(
//                 tooltip: 'Kirim SMS',
//                 child: const Icon(Icons.sms),
//                 onPressed: () {
//                   List<String> numbers = [_numController.text];
//                   _sendSMS(numbers, _msgController.text);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
