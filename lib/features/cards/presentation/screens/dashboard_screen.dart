import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:loyalty_card_storage_app/features/cards/domain/models/loyalty_card.dart';
import 'package:loyalty_card_storage_app/features/cards/presentation/utils/barcode_helper.dart';
import 'package:loyalty_card_storage_app/features/core/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:loyalty_card_storage_app/features/cards/presentation/screens/add_card_screen.dart';
import 'package:loyalty_card_storage_app/features/alerts/presentation/screens/alerts_screen.dart';
import 'package:loyalty_card_storage_app/features/cards/presentation/screens/card_detail_screen.dart';
import 'package:loyalty_card_storage_app/features/settings/presentation/screens/settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  
  final List<LoyaltyCard> _loyaltyCards = [
    LoyaltyCard(
      id: '1',
      name: 'Starbucks',
      cardNumber: '1234567890123',
      expiryDate: DateTime(2026, 12),
      barcodeType: 'QR_CODE', // Now QR Code
    ),
    LoyaltyCard(
      id: '2',
      name: 'Costco',
      cardNumber: '9876543210987',
      expiryDate: DateTime.now().add(const Duration(days: 15)),
      barcodeType: 'CODE_128', // Standard
    ),
    LoyaltyCard(
      id: '3',
      name: 'Target',
      cardNumber: '4567890123456',
      expiryDate: DateTime(2025, 8),
      barcodeType: 'EAN_13', // EAN 13
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: _buildAppBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _CardsTab(loyaltyCards: _loyaltyCards),
          const Center(child: Text('Activity Coming Soon')),
          AddCardScreen(
            onSave: (LoyaltyCard newCard) {
              setState(() {
                _loyaltyCards.add(newCard);
                _currentIndex = 0;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Loyalty Card Saved Successfully!'),
                  backgroundColor: Color(0xFF00B894),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          const AlertsScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: _currentIndex == 2 
        ? IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0F1419)),
            onPressed: () => setState(() => _currentIndex = 0),
          )
        : IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF0F1419)),
            onPressed: () {},
          ),
      title: Text(
        _currentIndex == 2 ? 'Add Card' : 'Everyday Rewards',
        style: GoogleFonts.outfit(
          color: _currentIndex == 2 ? const Color(0xFF0F1419) : const Color(0xFF5A46E6),
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundColor: Color(0xFFE1E5ED),
          child: Icon(Icons.person, color: Colors.black54),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

class _CardsTab extends StatelessWidget {
  final List<LoyaltyCard> loyaltyCards;

  const _CardsTab({required this.loyaltyCards});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'My Cards',
            style: GoogleFonts.outfit(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F1419),
            ),
          ),
          const SizedBox(height: 20),
          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFE1E5ED).withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search cards...',
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.black38),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Filter Tabs
          Row(
            children: [
              _FilterChip(label: 'All', isSelected: true),
              const SizedBox(width: 10),
              _FilterChip(label: 'Expiring Soon', isSelected: false),
            ],
          ),
          const SizedBox(height: 24),
          // Card List
          ...loyaltyCards.map((card) => _LoyaltyCardItem(card: card)),
          const _AddCardButton(),
          const SizedBox(height: 40), // Padding
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _FilterChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF5A46E6) : const Color(0xFFE1E5ED).withOpacity(0.5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black54,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _LoyaltyCardItem extends StatelessWidget {
  final LoyaltyCard card;
  const _LoyaltyCardItem({required this.card});

  @override
  Widget build(BuildContext context) {
    final bool isExpiringSoon = card.name == 'Costco';
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardDetailScreen(card: card),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
          border: isExpiringSoon ? Border.all(color: Colors.red.withOpacity(0.2), width: 1.5) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _getMerchantColor(card.name),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_getMerchantIcon(card.name), color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.name,
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F1419),
                        ),
                      ),
                      Text(
                        'Exp: ${_formatExpiry(card.expiryDate, isExpiringSoon)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: isExpiringSoon ? Colors.red : Colors.black45,
                          fontWeight: isExpiringSoon ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert, color: Colors.black26),
              ],
            ),
            const SizedBox(height: 24),
            // Barcode Implementation
            Container(
              height: 70,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F9FC),
                borderRadius: BorderRadius.circular(16),
              ),
              child: BarcodeWidget(
                barcode: BarcodeHelper.getBarcodeFromType(card.barcodeType),
                data: card.cardNumber,
                drawText: false,
                color: const Color(0xFF0F1419).withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getMerchantColor(String name) {
    if (name == 'Starbucks') return const Color(0xFF006241);
    if (name == 'Costco') return const Color(0xFF005DAA);
    if (name == 'Target') return const Color(0xFFCC0000);
    return Colors.grey;
  }

  IconData _getMerchantIcon(String name) {
    if (name == 'Starbucks') return Icons.local_cafe;
    if (name == 'Costco') return Icons.shopping_cart;
    if (name == 'Target') return Icons.adjust;
    return Icons.credit_card;
  }

  String _formatExpiry(DateTime date, bool isSoon) {
    if (isSoon) return 'Next Month';
    return '${_getMonthName(date.month)} ${date.year}';
  }

  String _getMonthName(int month) {
    const names = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return names[month - 1];
  }
}

class _AddCardButton extends StatelessWidget {
  const _AddCardButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black12, width: 1.5, style: BorderStyle.solid),
      ),
      child: Column(
        children: [
          const Icon(Icons.add_card, size: 40, color: Colors.black26),
          const SizedBox(height: 12),
          Text(
            'Add New Reward Card',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F1419),
            ),
          ),
          const Text(
            'Scan your physical card to digitize it in seconds',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.black38),
          ),
        ],
      ),
    );
  }
}

