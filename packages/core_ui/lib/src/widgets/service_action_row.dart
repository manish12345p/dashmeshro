import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'phone_action_handler.dart';

class ServiceActionRow extends StatelessWidget {
  final String phone;
  final String serviceDetailsText;
  final bool isDisabled;
  final Color? callIconColor;
  final Color? shareIconColor;
  final Color? copyIconColor;
  final double iconSize;

  const ServiceActionRow({
    super.key,
    required this.phone,
    required this.serviceDetailsText,
    this.isDisabled = false,
    this.callIconColor,
    this.shareIconColor,
    this.copyIconColor,
    this.iconSize = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (phone.isNotEmpty) ...[
          IconButton(
            icon: Icon(
              Icons.call,
              color: isDisabled ? Colors.grey.shade400 : (callIconColor ?? Colors.blue.shade600),
              size: iconSize,
            ),
            onPressed: isDisabled
                ? null
                : () {
                    PhoneActionHandler.handleAction(
                      context: context,
                      rawNumbers: phone,
                      actionName: 'Call',
                      onSelected: (selectedNumber) async {
                        final url = Uri.parse('tel:$selectedNumber');
                        try {
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            await launchUrl(url);
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Could not launch dialer')),
                            );
                          }
                        }
                      },
                    );
                  },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
        ],
        IconButton(
          icon: Icon(
            Icons.share,
            color: isDisabled ? Colors.grey.shade400 : (shareIconColor ?? Colors.green.shade600),
            size: iconSize,
          ),
          onPressed: isDisabled
              ? null
              : () {
                  Share.share(serviceDetailsText);
                },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(
            Icons.copy,
            color: isDisabled ? Colors.grey.shade400 : (copyIconColor ?? Colors.purple.shade600),
            size: iconSize,
          ),
          onPressed: isDisabled
              ? null
              : () {
                  Clipboard.setData(ClipboardData(text: serviceDetailsText));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied')),
                  );
                },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
