import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperPage extends StatelessWidget {
  DeveloperPage({super.key});

  final Uri ayushLinkedIn =
      Uri.parse('https://www.linkedin.com/in/ayushhsinghh/');
  final Uri ayanshLinkedIn = Uri.parse('https://www.linkedin.com/in/cyberdad/');
  final Uri githubLink =
      Uri.parse('https://github.com/ayushhsinghh/academiaApp');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.amber.shade100,
        title: const Text("About the Developer",
            style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const Center(
              child: Text(
                'This app is built for Students by Students',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'It\'s a property of all SRM students and is now Open Source! We encourage you to contribute any feature you might find useful for your fellow SRM students.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildDeveloperProfile('Ayush', ayushLinkedIn,
                    'assets/developer1.png'), // Replace placeholders
                buildDeveloperProfile('Ayansh', ayanshLinkedIn,
                    'assets/developer2.png'), // Replace placeholders
              ],
            ),
            const SizedBox(height: 50.0),
            InkWell(
              onLongPress: () {
                _launchUrl(githubLink);
              },
              child: Shimmer.fromColors(
                direction: ShimmerDirection.rtl,
                period: const Duration(seconds: 1),
                baseColor: Colors.black,
                highlightColor: Colors.yellow,
                child: const Column(
                  children: [
                    Text(
                      'Want to contribute? We welcome pull requests!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text(
                    //   'Check out our code on GitHub',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDeveloperProfile(String name, Uri linkedInUrl, String imagePath) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () =>
              (_launchUrl(linkedInUrl)), // Open LinkedIn profile on tap
          child: CircleAvatar(
            radius: 50.0,
            child: Lottie.asset(
              'assets/json/humans.json',
              repeat: true,
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        Text(name),
      ],
    );
  }

  Future<void> _launchUrl(Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $uri');
    }
  }
}
