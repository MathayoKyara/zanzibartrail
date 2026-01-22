import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/bottom_navigation.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  int _currentIndex = 3;
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  // EmailJS Configuration - Replace these with your EmailJS credentials
  //
  // SETUP INSTRUCTIONS:
  // 1. Go to https://www.emailjs.com/ and create a free account
  // 2. Add your email service (Gmail, Outlook, etc.) - use ZanzibarTrailTours@gmail.com
  // 3. Create an email template with these variables:
  //    - {{to_email}} - Recipient email (ZanzibarTrailTours@gmail.com)
  //    - {{from_name}} - Sender's name
  //    - {{from_email}} - Sender's email
  //    - {{subject}} - Email subject
  //    - {{message}} - Email message content
  //    - {{reply_to}} - Reply-to email
  // 4. Copy your Service ID, Template ID, and Public Key
  // 5. Replace the values below with your credentials
  // 6. In EmailJS dashboard, add your website URL to allowed origins:
  //    - https://mathayokyara.github.io (production)
  //    - http://localhost (for local development)
  //
  static const String emailJSServiceId = 'YOUR_SERVICE_ID';
  static const String emailJSTemplateId = 'YOUR_TEMPLATE_ID';
  static const String emailJSPublicKey = 'YOUR_PUBLIC_KEY';
  static const String emailJSAPIUrl =
      'https://api.emailjs.com/api/v1.0/email/send';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Get in Touch',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/about');
                  },
                  icon: Icon(Icons.info_outline, size: 18),
                  label: Text('About Us'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Have questions about our tours or ready to book your Tanzanian adventure? Reach out to us using the form below or through our contact details.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 32),

            // Contact Information
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Information',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(height: 16),
                      _buildContactItem(
                        Icons.email,
                        'Email',
                        'ZanzibarTrailTours@gmail.com',
                        () async {
                          final Uri params = Uri(
                            scheme: 'mailto',
                            path: 'ZanzibarTrailTours@gmail.com',
                            query: 'subject=Inquiry about Zanzibar Trail Tours',
                          );
                          if (await canLaunchUrl(params)) {
                            await launchUrl(params);
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      _buildContactItem(
                        Icons.phone,
                        'Phone',
                        '0675538957',
                        () async {
                          if (await canLaunchUrl(
                              Uri.parse('tel:0675538957'))) {
                            await launchUrl(Uri.parse('tel:0675538957'));
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      _buildContactItem(
                        Icons.chat,
                        'WhatsApp',
                        '0675538957',
                        () async {
                          if (await canLaunchUrl(
                              Uri.parse('https://wa.me/0675538957'))) {
                            await launchUrl(
                                Uri.parse('https://wa.me/0675538957'));
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      _buildContactItem(
                        Icons.location_on,
                        'Address',
                        'Mchina Mwisho, Zanzibar, Tanzania',
                        () async {
                          // Open maps
                          if (await canLaunchUrl(
                              Uri.parse('https://maps.app.goo.gl/zQ6dXSA7jNW1Rnow6'))) {
                            await launchUrl(
                                Uri.parse('https://maps.app.goo.gl/zQ6dXSA7jNW1Rnow6'));
                          }
                        },
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Follow Us',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.facebook,
                                size: 30, color: Colors.blue[600]),
                            onPressed: () async {
                              if (await canLaunchUrl(Uri.parse(
                                  'https://facebook.com/zanzibartrailtours'))) {
                                await launchUrl(Uri.parse(
                                    'https://facebook.com/zanzibartrailtours'));
                              }
                            },
                          ),
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.instagram,
                                size: 30, color: Colors.purple[600]),
                            onPressed: () async {
                              if (await canLaunchUrl(Uri.parse(
                                  'https://instagram.com/zanzibartrailtours'))) {
                                await launchUrl(Uri.parse(
                                    'https://instagram.com/zanzibartrailtours'));
                              }
                            },
                          ),
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.tiktok,
                                size: 30, color: Colors.black),
                            onPressed: () async {
                              if (await canLaunchUrl(Uri.parse(
                                  'https://tiktok.com/@zanzibartrailtours'))) {
                                await launchUrl(Uri.parse(
                                    'https://tiktok.com/@zanzibartrailtours'));
                              }
                            },
                          ),
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.youtube,
                                size: 30, color: Colors.red[600]),
                            onPressed: () async {
                              if (await canLaunchUrl(Uri.parse(
                                  'https://youtube.com/zanzibartrailtours'))) {
                                await launchUrl(Uri.parse(
                                    'https://youtube.com/zanzibartrailtours'));
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 32),

                // Contact Form
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Send us a Message',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Your Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _subjectController,
                          decoration: InputDecoration(
                            labelText: 'Subject',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a subject';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            labelText: 'Message',
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your message';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _isSending
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    _sendMessage();
                                  }
                                },
                          child: _isSending
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text('Sending...'),
                                  ],
                                )
                              : Text('Send Message'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Navigate to different screens based on index
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/tours');
              break;
            case 2:
              Navigator.pushNamed(context, '/gallery');
              break;
            case 3:
              // Already on contact screen
              break;
          }
        },
      ),
    );
  }

  Widget _buildContactItem(
      IconData icon, String title, String value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    setState(() {
      _isSending = true;
    });

    try {
      final String adminEmail = 'ZanzibarTrailTours@gmail.com';

      // Format the email content
      final String emailContent = '''
Dear Zanzibar Trail Tours Team,

I would like to contact you with the following inquiry:

MESSAGE DETAILS:
• Name: ${_nameController.text}
• Email: ${_emailController.text}
• Subject: ${_subjectController.text}

MESSAGE:
${_messageController.text}

Thank you for your time and I look forward to hearing from you soon.

Best regards,
${_nameController.text}
      '''
          .trim();

      // Prepare email data for EmailJS
      final Map<String, dynamic> emailData = {
        'service_id': emailJSServiceId,
        'template_id': emailJSTemplateId,
        'user_id': emailJSPublicKey,
        'template_params': {
          'to_email': adminEmail,
          'from_name': _nameController.text,
          'from_email': _emailController.text,
          'subject': _subjectController.text,
          'message': emailContent,
          'reply_to': _emailController.text,
        }
      };

      // Get current origin for CORS (required by EmailJS)
      // Dynamically detect the origin from the current URL
      String origin = 'http://localhost';
      if (Uri.base.hasScheme && Uri.base.hasAuthority) {
        origin = '${Uri.base.scheme}://${Uri.base.authority}';
      } else if (Uri.base.host.contains('localhost') ||
          Uri.base.host.contains('127.0.0.1')) {
        origin = 'http://localhost';
      }

      // Send email using EmailJS API
      final response = await http
          .post(
        Uri.parse(emailJSAPIUrl),
        headers: {
          'Content-Type': 'application/json',
          'origin': origin, // Required by EmailJS CORS policy
        },
        body: jsonEncode(emailData),
      )
          .timeout(
        Duration(seconds: 30),
        onTimeout: () {
          throw Exception(
              'Request timeout. Please check your internet connection.');
        },
      );

      setState(() {
        _isSending = false;
      });

      if (response.statusCode == 200) {
        // Success - show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Message Sent Successfully!'),
              content: Text(
                  'Thank you for your message! Your inquiry has been sent to ZanzibarTrailTours@gmail.com. We will respond to you within 24 hours.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Reset form after successful send
                    _nameController.clear();
                    _emailController.clear();
                    _subjectController.clear();
                    _messageController.clear();
                    _formKey.currentState!.reset();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Error response from EmailJS
        throw Exception(
            'Failed to send email. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isSending = false;
      });

      // Show error dialog
      String errorMessage = 'An error occurred while sending your message. ';

      if (e.toString().contains('timeout')) {
        errorMessage += 'Please check your internet connection and try again.';
      } else if (e.toString().contains('YOUR_SERVICE_ID') ||
          e.toString().contains('YOUR_TEMPLATE_ID') ||
          e.toString().contains('YOUR_PUBLIC_KEY')) {
        errorMessage +=
            'Email service is not configured. Please contact the website administrator.';
      } else {
        errorMessage +=
            'Please try again or contact us directly at ZanzibarTrailTours@gmail.com';
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
