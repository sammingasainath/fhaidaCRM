import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectStatusService {
  static double getProgress(String status) {
    switch (status) {
      case 'reportRecieved':
        return 0.90;
      case 'Sampling In Process':
      case 'Quotation Accepted':
      case 'Sent To Lab':
        return 0.75;
      case 'Action Required':
      case 'Quotation Requested':
      case 'Quotation Sent':
        return 0.5;
      case 'reportShipped':
        return 1.0;
      default:
        return 0.25;
    }
  }

  static Color getColorBasedOnStatus(String status, {required bool isAmount}) {
    switch (status) {
      case 'reportRecieved':
        return Colors.green;
      case 'Sampling In Process':
      case 'Quotation Accepted':
      case 'Sent To Lab':
        return isAmount ? Colors.green : Colors.brown;
      case 'Action Required':
      case 'Quotation Requested':
      case 'Quotation Sent':
        return isAmount ? Colors.green : Colors.red;
      case 'reportShipped':
        return Colors.lightBlue;
      default:
        return Colors.black;
    }
  }

  static Color getColor(String status) {
    switch (status) {
      case 'reportRecieved':
        return Colors.green;
      case 'Sampling In Process':
      case 'Quotation Accepted':
      case 'Sent To Lab':
        return Colors.orange;
      case 'Action Required':
      case 'Quotation Requested':
      case 'Quotation Sent':
        return Colors.red;
      case 'reportShipped':
        return Colors.lightBlue;
      default:
        return Colors.grey;
    }
  }

  static String getStatusText(String status) {
    switch (status) {
      case 'reportRecieved':
        return 'Report is being prepared';
      case 'Sampling In Process':
        return 'Sampling In Process';
      case 'Action Required':
        return 'Action Required';
      case 'Quotation Accepted':
        return 'Going To Start Work';
      case 'Sent To Lab':
        return 'Lab Tests Going On';
      case 'reportShipped':
        return 'Reports on their way';
      case 'Quotation Sent':
        return 'Accept Quotation';
      case 'Quotation Requested':
        return 'Preparing a Quotation for You';
      default:
        return 'Unknown Status';
    }
  }

  static Widget getStatusIcon(String status,
      {double size = 22.0, Color color = Colors.black}) {
    switch (status) {
      case 'reportRecieved':
        return Icon(Icons.access_time, size: size, color: color);
      case 'Sampling In Process':
        return SvgPicture.asset(
          'lib/assets/shovel.svg',
          height: size,
          width: size,
          color: color,
        );
      case 'Action Required':
        return Icon(Icons.warning, size: size, color: color);
      case 'Quotation Accepted':
        return Icon(Icons.check_circle, size: size, color: color);
      case 'Sent To Lab':
        return Icon(Icons.science, size: size, color: color);
      case 'reportShipped':
        return Icon(Icons.local_shipping, size: size, color: color);
      case 'Quotation Sent':
        return Icon(Icons.description, size: size, color: color);
      case 'Quotation Requested':
        return Icon(Icons.request_quote, size: size, color: color);
      default:
        return Icon(Icons.info, size: size, color: color);
    }
  }
}
