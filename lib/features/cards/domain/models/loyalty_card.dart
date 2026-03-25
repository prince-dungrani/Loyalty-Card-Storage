import 'package:flutter/material.dart';

class LoyaltyCard {
  final String id;
  final String name;
  final String cardNumber;
  final DateTime expiryDate;
  final String? notes;
  final String? imageUrl;
  final String barcodeType; // e.g., 'EAN_13', 'QR_CODE'

  LoyaltyCard({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.expiryDate,
    this.notes,
    this.imageUrl,
    this.barcodeType = 'EAN_13',
  });
}
