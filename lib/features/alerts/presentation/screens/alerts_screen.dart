import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'Alerts',
            style: GoogleFonts.outfit(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F1419),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Stay updated with your latest rewards and card statuses.',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 24),
          
          // Alert Items
          _buildAlertCard(
            type: 'URGENT',
            icon: Icons.warning_amber_rounded,
            iconColor: Colors.red,
            iconBg: Colors.red.withOpacity(0.1),
            time: '3d ago',
            title: 'Your Starbucks card expires in 3 days!',
            description: 'Renew your membership today to keep earning stars on every purchase. Your current balance of 145 stars will be preserved.',
            primaryAction: 'Renew Now',
          ),
          const SizedBox(height: 16),
          _buildAlertCard(
            type: 'NEW OFFER',
            icon: Icons.local_offer,
            iconColor: Colors.green,
            iconBg: Colors.green.withOpacity(0.1),
            time: '5h ago',
            title: 'New offer from Costco: 10% off',
            description: 'Exclusive member-only discount on all bulk purchases this weekend. Tap to activate the reward on your card.',
            primaryAction: 'Activate',
            secondaryAction: 'Details',
          ),
          const SizedBox(height: 16),
          _buildAlertCard(
            type: 'INSIGHTS',
            icon: Icons.bar_chart,
            iconColor: const Color(0xFF5A46E6),
            iconBg: const Color(0xFF5A46E6).withOpacity(0.1),
            time: 'Yesterday',
            title: 'Your Weekly Rewards Summary',
            description: 'You earned 450 points last week! That\'s 15% more than your previous average. View your detailed breakdown.',
            customWidget: _buildInsightsWidget(),
          ),
          const SizedBox(height: 16),
          _buildAlertCard(
            type: 'UPGRADE',
            icon: Icons.auto_awesome,
            iconColor: Colors.purple,
            iconBg: Colors.purple.withOpacity(0.1),
            time: '2d ago',
            title: 'Upgrade to Curator Platinum',
            description: 'Get 2x points on all travel and dining. Special introductory rate available for 24 more hours.',
          ),
          const SizedBox(height: 100), // padding for bottom nav
        ],
      ),
    );
  }

  Widget _buildAlertCard({
    required String type,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String time,
    required String title,
    required String description,
    String? primaryAction,
    String? secondaryAction,
    Widget? customWidget,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          type,
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: iconColor,
                            letterSpacing: 1,
                          ),
                        ),
                        Text(
                          time,
                          style: const TextStyle(fontSize: 10, color: Colors.black38),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F1419),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(fontSize: 13, color: Colors.black54, height: 1.5),
          ),
          if (customWidget != null) ...[
            const SizedBox(height: 16),
            customWidget,
          ],
          if (primaryAction != null || secondaryAction != null) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                if (primaryAction != null)
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: type == 'URGENT' ? const Color(0xFFF7F9FC) : const Color(0xFF5A46E6),
                      foregroundColor: type == 'URGENT' ? const Color(0xFF5A46E6) : Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text(
                      primaryAction,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                if (secondaryAction != null) ...[
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black54,
                      side: const BorderSide(color: Colors.black12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text(
                      secondaryAction,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInsightsWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF00B894),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Earned',
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                  Text(
                    '\$24.50',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F1419),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Icon(Icons.chevron_right, color: Colors.black38),
        ],
      ),
    );
  }
}
