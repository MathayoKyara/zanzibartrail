import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Zanzibar Trail Tours',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: 16),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 300,
                    maxHeight: 150,
                  ),
                  child: Image.asset(
                    'assets/images/alltours/logo.jpg',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 150,
                        width: 300,
                        color: Colors.grey[300],
                        child: Icon(Icons.image,
                            size: 50, color: Colors.grey[600]),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Our Story',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(height: 8),
            Text(
              'Founded in 2010, Zanzibar Trail Tours has been providing authentic and unforgettable experiences to travelers from around the world. We started as a small local operator in Zanzibar and have grown to become a respected tour company offering comprehensive experiences across Tanzania.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 24),
            Text(
              'Our Mission',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(height: 8),
            Text(
              'To provide authentic, professional, and unforgettable experiences that showcase the best of Zanzibar and Tanzania mainland while supporting local communities and promoting sustainable tourism.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 24),
            Text(
              'Our Coverage',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(height: 8),
            Text(
              'We offer comprehensive tours across both Zanzibar and Tanzania mainland, including:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBulletPoint('Zanzibar Archipelago (Unguja and Pemba)'),
                  _buildBulletPoint('Serengeti National Park'),
                  _buildBulletPoint('Ngorongoro Conservation Area'),
                  _buildBulletPoint('Mount Kilimanjaro'),
                  _buildBulletPoint('Selous Game Reserve'),
                  _buildBulletPoint('Ruaha National Park'),
                  _buildBulletPoint('Tarangire National Park'),
                  _buildBulletPoint('Lake Manyara National Park'),
                  _buildBulletPoint('Dar es Salaam and Coast'),
                ],
              ),
            ),
            SizedBox(height: 32),
            _buildOurTeamSection(),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/contact');
                },
                child: Text('Contact Us'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
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
              Navigator.pushNamed(context, '/contact');
              break;
          }
        },
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ',
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColor)),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOurTeamSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Team',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        SizedBox(height: 8),
        Text(
          'Meet the passionate professionals behind Zanzibar Trail Tours',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildTeamMemberCard(
                'assets/images/alltours/ceo.jpg',
                'Chief Executive Officer',
                'Leading our vision for authentic Zanzibar experiences',
                Colors.blue[700]!,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildTeamMemberCard(
                'assets/images/alltours/iddy.jpg',
                'Director of Adventure & Exploration',
                'Designing signature expeditions across Zanzibar and Tanzania',
                Colors.orange[700]!,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTeamMemberCard(
                'assets/images/alltours/guider.jpeg',
                'Tour Guider',
                'Guiding guests through immersive cultural and wildlife journeys',
                Colors.purple[700]!,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildTeamMemberCard(
                'assets/images/alltours/tech2.jpg',
                'Tech Officer',
                'Ensuring seamless digital experiences for our guests',
                Colors.green[700]!,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTeamMemberCard(String imagePath, String position,
      String description, Color accentColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          // Team member photo
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey[600],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Photo not available',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Team member info
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Position badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accentColor.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    position,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ),

                SizedBox(height: 12),

                // Description
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
