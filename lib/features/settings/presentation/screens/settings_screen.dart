import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          // Profile Avatar
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E1E1E), // Dark background for avatar
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, size: 80, color: Colors.white24),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF5A46E6),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFF7F9FC), width: 3),
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.edit, color: Colors.white, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Everyday Curator',
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F1419),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Premium Member since 2023',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),
          
          // PREFERENCES Section
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'PREFERENCES',
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF5A46E6),
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                _buildSettingTile(
                  icon: Icons.dark_mode,
                  title: 'Dark Mode',
                  subtitle: 'Adjust app appearance',
                  trailing: Switch(
                    value: false,
                    onChanged: (val) {},
                    activeColor: const Color(0xFF5A46E6),
                  ),
                ),
                const Divider(height: 1, indent: 70, endIndent: 20),
                _buildSettingTile(
                  icon: Icons.sync,
                  title: 'Backup & Sync',
                  subtitle: 'Keep your data safe across devices',
                  trailing: const Icon(Icons.chevron_right, color: Colors.black26),
                ),
                const Divider(height: 1, indent: 70, endIndent: 20),
                _buildSettingTile(
                  icon: Icons.security,
                  title: 'Security',
                  subtitle: 'Biometrics and privacy locks',
                  trailing: const Icon(Icons.chevron_right, color: Colors.black26),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          
          // ACCOUNT Section
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'ACCOUNT',
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF5A46E6),
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: _buildSettingTile(
              icon: Icons.help_outline,
              title: 'Help & Support',
              trailing: const Icon(Icons.chevron_right, color: Colors.black26),
            ),
          ),
          const SizedBox(height: 48),
          
          // Logout Button
          SizedBox(
            width: double.infinity, // or specify a fixed width if prefer pill shape
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout, color: Color(0xFFD32F2F)),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Color(0xFFD32F2F),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE1E5ED).withOpacity(0.5),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 120), // Padding for bottom nav
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required Widget trailing,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFE1E5ED).withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF5A46E6), size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F1419)),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            )
          : null,
      trailing: trailing,
      onTap: () {},
    );
  }
}
