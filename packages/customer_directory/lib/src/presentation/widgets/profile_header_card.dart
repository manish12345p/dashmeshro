import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import '../../domain/entities/customer.dart';

class ProfileHeaderCard extends StatelessWidget {
  final Customer customer;

  const ProfileHeaderCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          children: [
            // Big avatar with badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(customer.avatarUrl.isNotEmpty
                          ? customer.avatarUrl
                          : 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=150'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Text(
                        customer.status.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF15803D),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Customer Name & Subtitle
            Text(
              customer.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.verified, size: 16, color: Color(0xFF1E3A8A)),
                const SizedBox(width: 4),
                Text(
                  customer.role,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1E3A8A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Contact Info Fields
            _buildContactRow(Icons.phone, customer.number),
            const SizedBox(height: 12),
            _buildContactRow(Icons.email_outlined, customer.email),
            const SizedBox(height: 12),
            _buildContactRow(Icons.location_on_outlined, customer.address, isMultiline: true),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text, {bool isMultiline = false}) {
    return Row(
      crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: const Color(0xFF1E3A8A)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF334155),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
