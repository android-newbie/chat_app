import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:http/http.dart';

class FCMService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Replace with your service account JSON file content
  final serviceAccountCredentials = r'''
  {
    "type": "service_account",
  "project_id": "chatapp-98f9a",
  "private_key_id": "5b6b6f3ebac39a9fa4c05b8a1c4b36fd0ba707a2",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDKTCi945UjzGD+\n0vMUvZl+c8+ftMCCuD5BsKfuV0vrtht7EbjGhn7f5QcUn/Pi2zDsnUu/m2rj5j6Q\n/zdX0+HHQqp4tjetNKdTK/fr5utRsJBOmRJxANa9rkrY/OiOG9Jlz9/dP+mM56Py\nA4TxUmvRq04aVwZobSAWglZuHU8QQjH9eses2Y3OK4fTJRN31qbxlSe1w/Mb0iIs\n+Zjl+bImNLIHnjCcBGu6pq87hxiylcYoghR/JluzBNxOf8hWy7iLTY2vlPg4YqpS\n9DPlyLSWVAvgllgS1C9rHz9yRvZVjGA/ihFHlX351otniSJLAXvU/CtYrvWX2LSB\nssIddw0zAgMBAAECggEAIaJJmySq/Qbee4+hcv8roC7AxDSpAIgscFSJic2BexZN\nzweSbo4ZqxT+OTYiNkNWM4jazr0YJ6hLb7psaPxP4LFwprLjt+GguOnUWv2LfgtP\n5YQlYPIQQfzSnJgT/DNGUb90NhS0ZRp1k2fKuIAJGr+TXpATKdU24rcsh+X0lBGk\nXAzJnSDcDiJRyaEqv2Rj3dt/aeQVUiNKID2jeW9xVHeXcsi3adm7kvjPGc3m3lGb\ns00IgzXRttX0a7HJtMWskgLLSUjClwt13Ar+nIWuumM3d2UabqjI9MxrlqJrqf2T\naTaKg1E9ipt4EzkRFO1aiNWYpFqui6mS7aUWDma3dQKBgQDrjSirThbPRb8Sk6Pf\nx/sjVQBfjVdkCAlmqPB1prYWDVwaaW0xzM5LTTVS4n+Cw7vNCFxUMsfIMSvcAT6f\nMBmmmR6GBHc3Ob7UBZH2Hr1dBXiF3j5BfoSKvYU1LpXbeOR9U/vlgZ5dAtwcGonT\nO2Pw/pfrFRh8NUl6kHIZY6NUhwKBgQDb2/kXGP2R98hfzn5InH+qAvIsiW/U1skv\nNraGpY6kG1ygITlj1o7P9j0GZ/jZvqUsN2zOjMKUEkSvpUOSPpuj9cMQ1FYTuzKl\nkxlqnsuUdkJVvbIIevqbKzHJMPJooX2zT0BhGe/DPK2phgHd0lHcD7YROKq/lBdF\n5V0wPRGY9QKBgAPERho3LXYzD1MkuUIi2IlAGrlscTFQT5YsrWu0NsUzgX2Kogxh\n0gqyOWAR7ygQKTimIZPXHAq/fowOGQpCoqZfXHWYLK/dZIfPbv4Yj76lD8BURXqW\no1f0n+Sx0gOocz7t0OFiqT2jhhGM+xc9o+N+rr87nyCdWYd0N97gEQSRAoGAJXuC\nIuryyADrW1IT+4MazLxF10vzEeEwWWlFgv0UrWuwxegEJb49iLzdOItfRJgZBsnI\nNgqPXbkjlqJhO7yKwlAy2lqo9iIzB0Fl0uSRppTmyEFX6dQ1h2C80yUSHr5xdLFt\nM2C9nJZqsP0UsmGZ7R+MlbEIgzLXKOZqlb/DkUUCgYBNiKP5oW2WuWcOPnPD+u2j\nLiAY1CmxjbNbZgxmBmlRdZqUkMpi0VHSK335JxpbUmGYqpqYZUzsPNFpyaSdrtVe\n+L3oOvFTBykqGJw6sThfygkH9xRfcGfDWm6yAhXYS3KFPjpMckyMYD7XZCIpMNec\nQE3CefqRyz/+UCRemqiILg==\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-m2t37@chatapp-98f9a.iam.gserviceaccount.com",
  "client_id": "117906252424463447640",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-m2t37%40chatapp-98f9a.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"

  }
  ''';

  // Send FCM notification using HTTP v1 API
  Future<void> sendPushNotification(String token, String message, String senderEmail) async {
    const String fcmUrl = 'https://fcm.googleapis.com/v1/projects/chatapp-98f9a/messages:send';

    final Map<String, dynamic> notificationData = {
      "message": {
        "token": token,
        "notification": {
          "title": "New message from $senderEmail",
          "body": message,
        },
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "sound": "default"
        }
      }
    };

    // Authenticate using the service account credentials
    final client = Client();
    final authClient = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(jsonDecode(serviceAccountCredentials)),
        ['https://www.googleapis.com/auth/cloud-platform'],baseClient: client);

    // Send HTTP POST request to the FCM v1 API
    final response = await authClient.post(
      Uri.parse(fcmUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(notificationData),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification: ${response.body}');
    }

    authClient.close();
  }
}
