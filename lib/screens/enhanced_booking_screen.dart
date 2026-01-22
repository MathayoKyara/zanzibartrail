import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/bottom_navigation.dart';
import '../models/tour_data.dart';
import '../models/hidden_gems_data.dart';
import '../services/booking_service.dart';

class EnhancedBookingScreen extends StatefulWidget {
  final String? tourId;
  final String? gemId;
  final String? entityType; // 'tour', 'safari', 'hidden_gem'

  const EnhancedBookingScreen({
    Key? key,
    this.tourId,
    this.gemId,
    this.entityType,
  }) : super(key: key);

  @override
  _EnhancedBookingScreenState createState() => _EnhancedBookingScreenState();
}

class _EnhancedBookingScreenState extends State<EnhancedBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;

  // Booking mode selection
  String? _selectedBookingMode; // 'whatsapp' or 'email'

  // Form data
  DateTime? _selectedDate;
  int _numberOfPeople = 1;
  String _packageType = 'Standard';

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nationalityController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  // Entity details
  dynamic _selectedEntity;
  String _entityTitle = '';
  String _entityDescription = '';
  String _entityPrice = '';
  String _entityLocation = '';

  List<String> _packageOptions = ['Standard', 'Deluxe', 'Premium'];

  @override
  void initState() {
    super.initState();
    _loadEntityDetails();
  }

  void _loadEntityDetails() {
    if (widget.tourId != null) {
      _selectedEntity = TourData.getTourById(widget.tourId!);
      if (_selectedEntity != null) {
        setState(() {
          _entityTitle = _selectedEntity.title;
          _entityDescription = _selectedEntity.description;
          _entityPrice = _selectedEntity.price;
          _entityLocation = _selectedEntity.location;
        });
      }
    } else if (widget.gemId != null) {
      _selectedEntity = HiddenGemsData.getGemById(widget.gemId!);
      if (_selectedEntity != null) {
        setState(() {
          _entityTitle = _selectedEntity.title;
          _entityDescription = _selectedEntity.description;
          _entityPrice = 'Contact for pricing';
          _entityLocation = _selectedEntity.location;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Your Experience'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Entity Details Card
              if (_selectedEntity != null) ...[
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selected Experience',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _entityTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _entityDescription,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 16, color: Colors.grey[600]),
                            SizedBox(width: 4),
                            Text(_entityLocation,
                                style: Theme.of(context).textTheme.bodySmall),
                            Spacer(),
                            Text(
                              _entityPrice,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],

              // Booking Mode Selection
              Text(
                'Choose Booking Method',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: _selectedBookingMode == 'whatsapp' ? 8 : 2,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedBookingMode = 'whatsapp';
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Icon(
                                Icons.chat,
                                size: 48,
                                color: _selectedBookingMode == 'whatsapp'
                                    ? Colors.green
                                    : Colors.grey[600],
                              ),
                              SizedBox(height: 8),
                              Text(
                                'WhatsApp',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: _selectedBookingMode == 'whatsapp'
                                          ? Colors.green
                                          : Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Quick & Direct',
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      elevation: _selectedBookingMode == 'email' ? 8 : 2,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedBookingMode = 'email';
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Icon(
                                Icons.email,
                                size: 48,
                                color: _selectedBookingMode == 'email'
                                    ? Colors.blue
                                    : Colors.grey[600],
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Email',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: _selectedBookingMode == 'email'
                                          ? Colors.blue
                                          : Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Detailed & Formal',
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Booking Details Form (only show after mode selection)
              if (_selectedBookingMode != null) ...[
                Text(
                  'Booking Details',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: 16),

                // Personal Information
                Text(
                  'Personal Information',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
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
                    labelText: 'Email Address *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
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
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _nationalityController,
                  decoration: InputDecoration(
                    labelText: 'Nationality *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.flag),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your nationality';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),

                // Package Information
                Text(
                  'Package Information',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Package Type',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.work),
                  ),
                  value: _packageType,
                  items: _packageOptions.map((package) {
                    return DropdownMenuItem(
                      value: package,
                      child: Text(package),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _packageType = value!;
                    });
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now().add(Duration(days: 7)),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                          );
                          if (picked != null) {
                            setState(() {
                              _selectedDate = picked;
                            });
                          }
                        },
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Travel Date *',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          child: Text(
                            _selectedDate != null
                                ? DateFormat('MMM dd, yyyy')
                                    .format(_selectedDate!)
                                : 'Select date',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                          labelText: 'Number of People *',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.people),
                        ),
                        value: _numberOfPeople,
                        items: List.generate(10, (index) => index + 1)
                            .map((number) {
                          return DropdownMenuItem(
                            value: number,
                            child: Text('$number'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _numberOfPeople = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select number of people';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Additional Information
                Text(
                  'Additional Information',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    labelText: 'Special Requests or Questions',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 32),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitBooking();
                      }
                    },
                    child: Text(
                      'Submit Booking Request',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedBookingMode == 'whatsapp'
                          ? Colors.green
                          : Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],

              // Contact Information
              Center(
                child: Column(
                  children: [
                    Text('Need help? Contact us directly:'),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.email,
                              color: Theme.of(context).primaryColor),
                          onPressed: () {
                            _launchEmail();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.chat, color: Colors.green),
                          onPressed: () {
                            _launchWhatsApp();
                          },
                        ),
                      ],
                    ),
                    Text('Email: ${BookingService.adminEmail}'),
                    Text('WhatsApp: ${BookingService.adminWhatsApp}'),
                  ],
                ),
              ),
            ],
          ),
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
              Navigator.pushNamed(context, '/contact');
              break;
          }
        },
      ),
    );
  }

  void _submitBooking() async {
    final bookingDetails = _formatBookingDetails();

    // Validate booking details
    if (!BookingService.validateBookingDetails(bookingDetails)) {
      _showErrorDialog('Please fill in all required fields correctly.');
      return;
    }

    bool success = false;
    String mode = '';

    if (_selectedBookingMode == 'whatsapp') {
      success = await BookingService.sendWhatsAppBooking(bookingDetails);
      mode = 'WhatsApp';
    } else if (_selectedBookingMode == 'email') {
      success = await BookingService.sendEmailBooking(bookingDetails);
      mode = 'Email';
    }

    if (success) {
      _showConfirmationDialog(
        '$mode Booking',
        'Your booking details have been prepared. You will be redirected to $mode to send your booking request.',
      );
    } else {
      _showErrorDialog(
          'Failed to open $mode. Please contact us directly at ${BookingService.adminEmail} or ${BookingService.adminWhatsApp}');
    }
  }

  Map<String, dynamic> _formatBookingDetails() {
    return {
      'entityTitle': _entityTitle,
      'entityDescription': _entityDescription,
      'entityPrice': _entityPrice,
      'entityLocation': _entityLocation,
      'entityType': widget.entityType,
      'customerName': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'nationality': _nationalityController.text,
      'travelDate': _selectedDate != null
          ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
          : null,
      'numberOfPeople': _numberOfPeople,
      'packageType': _packageType,
      'specialRequests': _messageController.text,
      'bookingMode': _selectedBookingMode,
    };
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showErrorDialog(
          'Could not launch WhatsApp. Please contact us directly.');
    }
  }

  void _launchEmail() {
    final emailUrl =
        'mailto:${BookingService.adminEmail}?subject=Booking Inquiry&body=Hello, I would like to make a booking inquiry.';
    _launchURL(emailUrl);
  }

  void _launchWhatsApp() {
    final whatsappUrl =
        'https://wa.me/0675538957?text=Hello, I would like to make a booking inquiry.';
    _launchURL(whatsappUrl);
  }

  void _showConfirmationDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetForm();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
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

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _selectedDate = null;
      _numberOfPeople = 1;
      _packageType = 'Standard';
      _selectedBookingMode = null;
    });
  }
}
