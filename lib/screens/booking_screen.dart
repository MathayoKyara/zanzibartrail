import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/bottom_navigation.dart';
import 'enhanced_booking_screen.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;
  
  String? _selectedTour;
  DateTime? _selectedDate;
  int _numberOfPeople = 1;
  String _packageType = 'Standard';
  
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  List<String> _tourOptions = [
    'Zanzibar Spice Tour',
    'Stone Town Exploration',
    'Prison Island Visit',
    'Jozani Forest Tour',
    'Nungwi & Kendwa Beach Experience',
    'Serengeti Safari',
    'Ngorongoro Crater Tour',
    'Mount Kilimanjaro Trek',
    'Selous Game Reserve Safari',
    'Cultural & Cuisine Experience'
  ];

  List<String> _packageOptions = [
    'Standard',
    'Deluxe',
    'Premium'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Your Tour'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Start Your Zanzibar & Tanzania Adventure Today!',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 16),
              Text(
                'Fill out the form below to book your tour. Our team will contact you within 24 hours to confirm your booking.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 24),
              
              // Personal Information
              Text(
                'Personal Information',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
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
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
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
                  labelText: 'Phone Number',
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
              SizedBox(height: 24),
              
              // Tour Information
              Text(
                'Tour Information',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Tour',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.explore),
                ),
                value: _selectedTour,
                items: _tourOptions.map((tour) {
                  return DropdownMenuItem(
                    value: tour,
                    child: Text(tour),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTour = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a tour';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
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
                          labelText: 'Travel Date',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(
                          _selectedDate != null 
                            ? DateFormat('MMM dd, yyyy').format(_selectedDate!)
                            : 'Select date',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Number of People',
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              
              // Additional Information
              Text(
                'Additional Information',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 16),
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
                  child: Text('Submit Booking Request', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                ),
              ),
              SizedBox(height: 24),
              
              // Contact Information
              Center(
                child: Column(
                  children: [
                    Text('Prefer to book directly?'),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.email, color: Theme.of(context).primaryColor),
                          onPressed: () {
                            // Launch email
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.phone, color: Theme.of(context).primaryColor),
                          onPressed: () {
                            // Launch phone
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.chat, color: Theme.of(context).primaryColor),
                          onPressed: () {
                            // Launch WhatsApp
                          },
                        ),
                      ],
                    ),
                    Text('Email: ZanzibarTrailTours@gmail.com'),
                    Text('Phone: 0675538957'),
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
  
  void _submitBooking() {
    // Navigate to enhanced booking screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnhancedBookingScreen(
          tourId: _selectedTour,
          entityType: 'tour',
        ),
      ),
    );
  }
}
