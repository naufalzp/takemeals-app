import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takemeals/providers/user_provider.dart';
import 'package:takemeals/screens/auth/login_screen.dart';
import 'package:takemeals/screens/profile/qr_scanner_screen.dart';
import 'package:takemeals/services/auth_service.dart';
import 'package:takemeals/utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthService authService = AuthService();

  Future<void> _logout() async {
    final success = await authService.logout();
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (!mounted) return;

    if (success) {
      userProvider.clearUser();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (_) => false,
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("An error occurred"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    if (userProvider.isFetching) {
      return const Center(child: CircularProgressIndicator());
    }

    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: user == null
          ? const Center(
              child: Text(
                'No user data available',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Header
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  primaryColor.withOpacity(0.6),
                                  primaryColor,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user.name ?? '-',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user.email ?? '-',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 40, thickness: 1.5),

                  // Profile Information Section
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Profile Details",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildProfileInfoRow(
                            Icons.phone,
                            'Phone',
                            user.phone,
                          ),
                          const Divider(height: 32, thickness: 1),
                          _buildProfileInfoRow(
                            Icons.person_pin,
                            'Is Partner',
                            user.isPartner == true ? 'Yes' : 'No',
                          ),
                          const SizedBox(height: 16),
                          if (user.isPartner == true)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const QRScannerScreen(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.qr_code_scanner),
                                label: const Text(
                                  'Scan Order QR',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _logout,
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileInfoRow(IconData icon, String label, String? value) {
    return Row(
      children: [
        Icon(icon, color: primaryColor),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        Text(
          value ?? '-',
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }
}
