import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cool Onboarding',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1506765515384-028b60a970df?auto=format&fit=crop&w=1950&q=80',
              fit: BoxFit.cover,
            ),
          ),
          // Blur layer
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),
          ),
          // Onboarding Pages
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => isLastPage = (index == 2));
            },
            children: [
              buildPage(
                title: '🌟 Welcome!',
                subtitle: 'Discover new experiences tailored for you.',
                imageUrl: 'https://picsum.photos/seed/1/600/300',
              ),
              buildPage(
                title: '📅 Easy Booking',
                subtitle: 'Book services in just a few taps.',
                imageUrl: 'https://picsum.photos/seed/2/600/300',
              ),
              buildPage(
                title: '🚀 Get Started',
                subtitle: 'Join us and explore more!',
                imageUrl: 'https://picsum.photos/seed/3/600/300',
              ),
            ],
          ),
          // Bottom Controls
          Positioned(
            bottom: 60,
            left: 20,
            right: 20,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.white60,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => _controller.jumpToPage(2),
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        if (isLastPage) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => HomeScreen()),
                          );
                        } else {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Text(isLastPage ? "Get Started" : "Next"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({
    required String title,
    required String subtitle,
    required String imageUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [Shadow(blurRadius: 4, color: Colors.black45)],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final greeting = getGreeting();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 🌈 Cool gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0f2027), Color(0xFF203a43), Color(0xFF2c5364)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 🧊 Frosted glass content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$greeting 👋",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Welcome back!",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                            "https://i.pravatar.cc/300"), // Replace with user avatar
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  buildGlassCard(Icons.book_online, "My Bookings", "View upcoming appointments"),
                  buildGlassCard(Icons.support_agent, "Support", "Contact our help center"),
                  buildGlassCard(Icons.settings, "Settings", "Manage your preferences"),
                ],
              ),
            ),
          ),
        ],
      ),

      // ⚙️ Modern FAB
      floatingActionButton: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Colors.tealAccent, Colors.teal],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.4),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {},
          child: const Icon(Icons.add, size: 30),
        ),
      ),
    );
  }

  Widget buildGlassCard(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              child: Icon(icon, color: Colors.white),
            ),
            title: Text(title,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text(subtitle, style: TextStyle(color: Colors.white70)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
            onTap: () {},
          ),
        ),
      ),
    );
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good morning";
    if (hour < 17) return "Good afternoon";
    return "Good evening";
  }
}

