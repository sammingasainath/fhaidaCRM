import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectStatusService {
  static double getProgress(String status) {
    switch (status) {
      case 'reportRecieved':
        return 1.0;
      case 'Sampling In Process':
        return 0.75;
      case 'Action Required':
        return 0.5;
      default:
        return 0.25;
    }
  }

  static Color getColorBasedOnStatus(String status, {required bool isAmount}) {
    switch (status) {
      case 'reportRecieved':
        return Colors.green;
      case 'Sampling In Process':
        return isAmount ? Colors.green : Colors.brown;
      case 'Action Required':
        return isAmount ? Colors.green : Colors.red;
      default:
        return Colors.black;
    }
  }

  static Color getColor(String status) {
    switch (status) {
      case 'reportRecieved':
        return Colors.green;
      case 'Sampling In Process':
        return Colors.orange;
      case 'Action Required':
        return Colors.red;
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
        );
      case 'Action Required':
        return Icon(Icons.warning, size: size, color: color);
      default:
        return Icon(Icons.info, size: size, color: color);
    }
  }
}
