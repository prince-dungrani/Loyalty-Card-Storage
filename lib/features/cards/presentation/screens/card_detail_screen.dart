import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:loyalty_card_storage_app/features/cards/domain/models/loyalty_card.dart';
import 'package:loyalty_card_storage_app/features/cards/presentation/utils/barcode_helper.dart';

class CardDetailScreen extends StatelessWidget {
  final LoyaltyCard card;

  const CardDetailScreen({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    // Determine barcode data to display nicely spaced
    final rawNumber = card.cardNumber;
    
    // Group by 4s and then last remainder
    String formattedNumber = '';
    for (int i = 0; i < rawNumber.length; i++) {
      formattedNumber += '${rawNumber[i]} ';
      if ((i + 1) % 4 == 0 && i != rawNumber.length - 1) {
        formattedNumber += '  ';
      }
    }
    if (formattedNumber.length > 20) {
      // split into two lines roughly in half for display
      final mid = formattedNumber.length ~/ 2;
      final splitIndex = formattedNumber.indexOf('   ', mid) != -1 
        ? formattedNumber.indexOf('   ', mid) 
        : mid;
      formattedNumber = '${formattedNumber.substring(0, splitIndex).trim()}\n${formattedNumber.substring(splitIndex).trim()}';
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E17), // Deep Dark Blue/Black
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF1E232D),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'EVERYDAY REWARDS',
              style: GoogleFonts.outfit(
                color: Colors.white54,
                fontSize: 10,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Digital Curator Card',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            // Main Dark Card Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              decoration: BoxDecoration(
                color: const Color(0xFF161925), // Lighter dark panel
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Premium Member',
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Everyday Curator',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // White Barcode Display Panel
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4D6DB), // Light grey matching screenshot
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        // The Barcode
                        SizedBox(
                          height: 140,
                          child: BarcodeWidget(
                            barcode: BarcodeHelper.getBarcodeFromType(card.barcodeType),
                            data: card.cardNumber,
                            drawText: false,
                            color: const Color(0xFF0F1419),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Number
                        Text(
                          formattedNumber,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.spaceMono(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F1419),
                            height: 1.5,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Ready To Scan Chip
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF000000).withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.verified_user, color: Color(0xFF5A46E6), size: 14),
                              const SizedBox(width: 8),
                              Text(
                                'READY TO SCAN',
                                style: GoogleFonts.outfit(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF5A46E6),
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Bottom Stats
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF222533),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CURRENT\nBALANCE',
                                style: GoogleFonts.outfit(
                                  color: Colors.white54,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '12,450',
                                    style: GoogleFonts.outfit(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    'PTS',
                                    style: TextStyle(
                                      color: Color(0xFF5A46E6),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF222533),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'REWARD TIER',
                                style: GoogleFonts.outfit(
                                  color: Colors.white54,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Gold',
                                style: GoogleFonts.outfit(
                                  color: const Color(0xFF00B894),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
            // Brightness hint pill
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: const Color(0xFF161925),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: const Text(
                'Screen brightness maximized for scanning',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
