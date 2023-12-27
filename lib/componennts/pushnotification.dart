import 'package:http/http.dart' as http;
import 'dart:convert';

class PushnotificationApi {
  static Future<void> sendNotification() async {
    const String serverKey =
        'AAAAboPcDeM:APA91bHrQvz0RpZVnvFPQ9CEoRW3lihmS89Wdr6esgKVQ3Jp664YKuHCBPeiY2i1UUsgCDCAKqrkOEHvI8CxENBhW5eddNnCaAEE0YijJ6YbcJImdXov1cpEYbgSHNBfT3NZtecE2sBV'; // Replace with your FCM server key

    final Uri url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/guessthebox-b5778/messages:send');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final Map<String, dynamic> message = {
      'message': {
        'token':
            'dVDS39p4TvyQmuws4ETTgt:APA91bFs7Aey1KSCxoN_Znb_DuvHjZjdjedoN1YI9jIc219u0kVi3gPPuW3H7GVDvqLUjinCrwp6O9x5T4ViIQ6Abr5jVyyAUB8IXyOYo5Yc2Hbacjh0QPFCkeQ9-19c0SoeEqd1VvNY',
        'notification': {
          'body': 'This is an FCM notification message!',
          'title': 'FCM Message',
        },
      },
    };

    final http.Response response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('Message sent successfully');
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
}
