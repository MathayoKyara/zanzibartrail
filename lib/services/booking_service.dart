import 'package:url_launcher/url_launcher.dart';

class BookingService {
  static const String adminEmail = 'ZanzibarTrailTours@gmail.com';
  static const String adminWhatsApp = '0675538957';

  /// Send booking request via WhatsApp
  static Future<bool> sendWhatsAppBooking(
      Map<String, dynamic> bookingDetails) async {
    try {
      final message = _formatWhatsAppMessage(bookingDetails);
      final whatsappUrl =
          'https://wa.me/0675538957?text=${Uri.encodeComponent(message)}';

      if (await canLaunch(whatsappUrl)) {
        await launch(whatsappUrl);
        return true;
      }
      return false;
    } catch (e) {
      print('Error launching WhatsApp: $e');
      return false;
    }
  }

  /// Send booking request via Email
  static Future<bool> sendEmailBooking(
      Map<String, dynamic> bookingDetails) async {
    try {
      final emailContent = _formatEmailContent(bookingDetails);
      final subject = 'Booking Request - ${bookingDetails['entityTitle']}';
      final emailUrl =
          'mailto:$adminEmail?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(emailContent)}';

      if (await canLaunch(emailUrl)) {
        await launch(emailUrl);
        return true;
      }
      return false;
    } catch (e) {
      print('Error launching email: $e');
      return false;
    }
  }

  /// Format WhatsApp message
  static String _formatWhatsAppMessage(Map<String, dynamic> bookingDetails) {
    String entityType = bookingDetails['entityType'] ?? 'tour';
    String typeLabel = entityType == 'hidden_gem'
        ? 'Hidden Gem'
        : entityType == 'safari'
            ? 'Safari'
            : 'Tour';

    return '''
🏝️ *ZANZIBAR TRAIL TOURS - ${typeLabel.toUpperCase()} BOOKING REQUEST* 🏝️

📋 *${typeLabel} Details:*
• ${typeLabel}: ${bookingDetails['entityTitle']}
• Location: ${bookingDetails['entityLocation']}
• Price: ${bookingDetails['entityPrice']}

👤 *Customer Information:*
• Name: ${bookingDetails['customerName']}
• Email: ${bookingDetails['email']}
• Phone: ${bookingDetails['phone']}
• Nationality: ${bookingDetails['nationality']}

📅 *Booking Details:*
• Travel Date: ${bookingDetails['travelDate']}
• Number of People: ${bookingDetails['numberOfPeople']}
• Package Type: ${bookingDetails['packageType']}
• Booking Method: ${bookingDetails['bookingMode']}

💬 *Special Requests:*
${bookingDetails['specialRequests']}

Please confirm this booking and provide any additional information needed.

Thank you for choosing Zanzibar Trail Tours! 🌟
    ''';
  }

  /// Format email content
  static String _formatEmailContent(Map<String, dynamic> bookingDetails) {
    String entityType = bookingDetails['entityType'] ?? 'tour';
    String typeLabel = entityType == 'hidden_gem'
        ? 'Hidden Gem'
        : entityType == 'safari'
            ? 'Safari'
            : 'Tour';

    return '''
Dear Zanzibar Trail Tours Team,

I would like to make a booking request for the following ${typeLabel.toLowerCase()}:

${typeLabel.toUpperCase()} DETAILS:
• ${typeLabel}: ${bookingDetails['entityTitle']}
• Location: ${bookingDetails['entityLocation']}
• Price: ${bookingDetails['entityPrice']}

CUSTOMER INFORMATION:
• Name: ${bookingDetails['customerName']}
• Email: ${bookingDetails['email']}
• Phone: ${bookingDetails['phone']}
• Nationality: ${bookingDetails['nationality']}

BOOKING DETAILS:
• Travel Date: ${bookingDetails['travelDate']}
• Number of People: ${bookingDetails['numberOfPeople']}
• Package Type: ${bookingDetails['packageType']}
• Booking Method: ${bookingDetails['bookingMode']}

SPECIAL REQUESTS:
${bookingDetails['specialRequests']}

Please confirm this booking and provide any additional information needed.

Thank you for your time and I look forward to hearing from you soon.

Best regards,
${bookingDetails['customerName']}
    ''';
  }

  /// Validate booking details
  static bool validateBookingDetails(Map<String, dynamic> bookingDetails) {
    final requiredFields = [
      'customerName',
      'email',
      'phone',
      'nationality',
      'travelDate',
      'numberOfPeople',
      'packageType'
    ];

    for (String field in requiredFields) {
      if (bookingDetails[field] == null ||
          bookingDetails[field].toString().isEmpty) {
        return false;
      }
    }

    // Validate email format
    final email = bookingDetails['email'].toString();
    if (!email.contains('@') || !email.contains('.')) {
      return false;
    }

    // Validate number of people
    final numberOfPeople = bookingDetails['numberOfPeople'];
    if (numberOfPeople is! int || numberOfPeople < 1 || numberOfPeople > 20) {
      return false;
    }

    return true;
  }
}
