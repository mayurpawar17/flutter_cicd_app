import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const CicdDashboardScreen(),
    );
  }
}

class CicdDashboardScreen extends StatelessWidget {
  const CicdDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter CI/CD Pipeline'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              _buildOverviewCard(context),
              const SizedBox(height: 24),

              Text(
                'Pipeline Workflow Steps',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Pipeline Timeline Steps
              _buildPipelineStep(
                context: context,
                stepNumber: '1',
                title: 'Code Commit & Push',
                subtitle: 'Triggered by Developer',
                description: 'You push your Flutter code to a GitHub repository branch (e.g., main or release).',
                icon: Icons.cloud_upload_outlined,
                iconColor: Colors.blueAccent,
                isLast: false,
              ),
              _buildPipelineStep(
                context: context,
                stepNumber: '2',
                title: 'GitHub Actions (The Orchestrator)',
                subtitle: 'Continuous Integration (CI)',
                description: 'GitHub spins up a virtual machine, installs Flutter, runs unit tests, analyzes your code structure, and ensures everything compiles perfectly.',
                icon: Icons.loop_rounded,
                iconColor: Colors.purpleAccent,
                isLast: false,
              ),
              _buildPipelineStep(
                context: context,
                stepNumber: '3',
                title: 'Fastlane Integration',
                subtitle: 'Continuous Delivery (CD)',
                description: 'GitHub Actions hands off the build to Fastlane. Fastlane handles complex tasks like managing certificates, code signing, and compiling the final .ipa (iOS) or .apk (Android) files.',
                icon: Icons.rocket_launch_rounded,
                iconColor: Colors.orangeAccent,
                isLast: false,
              ),
              _buildPipelineStep(
                context: context,
                stepNumber: '4',
                title: 'App Store & Google Play Deploy',
                subtitle: 'Release Automation',
                description: 'Fastlane automatically uploads the signed, finished builds to TestFlight, Google Play Console internal tracks, or public production releases.',
                icon: Icons.shop_two_rounded,
                iconColor: Colors.greenAccent,
                isLast: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for the top overview card
  Widget _buildOverviewCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.surfaceContainer,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome, color: Colors.amber, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    'What is this setup?',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'This UI visualizes how code travels from your local environment to your users seamlessly using GitHub Actions to automate runs and Fastlane to bypass manual platform builds and credentials management.',
                style: TextStyle(fontSize: 14, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for a single pipeline step
  Widget _buildPipelineStep({
    required BuildContext context,
    required String stepNumber,
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
    required Color iconColor,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left timeline column (number, icon, and connecting line)
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(color: iconColor, width: 2),
              ),
              child: Center(
                child: Icon(icon, color: iconColor, size: 20),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 100,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
          ],
        ),
        const SizedBox(width: 16),

        // Right description column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Step $stepNumber: ',
                    style: TextStyle(
                      color: iconColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                  fontSize: 13,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 24), // Spacing helper between steps
            ],
          ),
        ),
      ],
    );
  }
}