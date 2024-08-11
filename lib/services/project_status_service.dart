import 'package:flutter/material.dart';

class ProjectStatusService {
  static double getProgress(String status) {
    switch (status) {
      case 'leadReceived':
        return 0.10;
      case 'contacted':
        return 0.20;
      case 'qualified':
        return 0.30;
      case 'inNegotiation':
        return 0.50;
      case 'sentOffer':
        return 0.60;
      case 'mututalAgreementDone':
        return 0.40;
      case 'rennovationDone':
        return 0.50;
      case 'inMarket':
        return 0.60;
      case 'tokenAmountGiven':
        return 0.70;
      case 'primaryRegistrationDone':
        return 0.80;
      case 'loanInProcess':
        return 0.85;
      case 'registrationScheduled':
        return 0.90;
      case 'finalRegistrationDone':
        return 0.95;
      case 'commisionReceived':
        return 1.0;
      default:
        return 0.0;
    }
  }

  static Color getColorBasedOnStatus(String status, {required bool isAmount}) {
    switch (status) {
      case 'leadReceived':
        return Colors.grey.shade600; // Dark grey for initial lead received
      case 'contacted':
        return Colors.blue.shade300; // Light blue for contacted
      case 'qualified':
        return Colors.cyan.shade400; // Soft cyan for qualified
      case 'inNegotiation':
        return Colors.orange.shade400; // Warm orange for negotiation
      case 'sentOffer':
        return const Color.fromARGB(255, 248, 211, 90); // Amber for offer sent
      case 'mututalAgreementDone':
        return Colors.teal.shade400; // Muted teal for agreement done
      case 'rennovationDone':
        return Colors.yellow.shade700; // Bright yellow for renovation done
      case 'inMarket':
        return Colors.deepOrange.shade400; // Deep orange for in market
      case 'tokenAmountGiven':
        return isAmount
            ? Colors.green.shade500
            : Colors.purple.shade500; // Green for amount, purple otherwise
      case 'primaryRegistrationDone':
        return Colors.indigo.shade400; // Indigo for primary registration done
      case 'loanInProcess':
        return const Color.fromARGB(
            255, 229, 134, 134); // Darker grey for loan in process
      case 'registrationScheduled':
        return Colors
            .lightBlue.shade400; // Light blue for registration scheduled
      case 'finalRegistrationDone':
        return Colors.lime.shade500; // Bright lime for final registration done
      case 'commisionReceived':
        return Colors.green.shade600; // Dark green for commission received
      default:
        return Colors.grey.shade400; // Light grey for unknown status
    }
  }

  static Color getColor(String status) {
    switch (status) {
      case 'leadReceived':
        return Colors.grey.shade600;
      case 'contacted':
        return Colors.blue.shade300;
      case 'qualified':
        return Colors.cyan.shade400;
      case 'inNegotiation':
        return Colors.orange.shade400;
      case 'sentOffer':
        return const Color.fromARGB(255, 182, 141, 7);
      case 'mututalAgreementDone':
        return Colors.teal.shade400;
      case 'rennovationDone':
        return Colors.yellow.shade700;
      case 'inMarket':
        return Colors.deepOrange.shade400;
      case 'tokenAmountGiven':
        return Colors.green.shade500; // Default for amount given
      case 'primaryRegistrationDone':
        return Colors.indigo.shade400;
      case 'loanInProcess':
        return const Color.fromARGB(255, 116, 4, 4);
      case 'registrationScheduled':
        return Colors.lightBlue.shade400;
      case 'finalRegistrationDone':
        return Color.fromARGB(255, 58, 143, 241);
      case 'commisionReceived':
        return Colors.green.shade600;
      default:
        return Colors.grey.shade400;
    }
  }

  static String getStatusText(String status) {
    switch (status) {
      case 'leadReceived':
        return 'Lead Received';
      case 'contacted':
        return 'Contacted';
      case 'qualified':
        return 'Qualified';
      case 'inNegotiation':
        return 'In Negotiation';
      case 'sentOffer':
        return 'Offer Sent';
      case 'mututalAgreementDone':
        return 'Mutual Agreement Done';
      case 'rennovationDone':
        return 'Renovation Done';
      case 'inMarket':
        return 'In Market';
      case 'tokenAmountGiven':
        return 'Token Amount Given';
      case 'primaryRegistrationDone':
        return 'Primary Registration Done';
      case 'loanInProcess':
        return 'Loan In Process';
      case 'registrationScheduled':
        return 'Registration Scheduled';
      case 'finalRegistrationDone':
        return 'Final Registration Done';
      case 'commisionReceived':
        return 'Commission Received';
      default:
        return 'Unknown Status';
    }
  }

  static Widget getStatusIcon(String status,
      {double size = 22.0, Color color = Colors.black}) {
    switch (status) {
      case 'leadReceived':
        return Icon(Icons.call_received, size: size, color: color);
      case 'contacted':
        return Icon(Icons.phone, size: size, color: color);
      case 'qualified':
        return Icon(Icons.star, size: size, color: color);
      case 'inNegotiation':
        return Icon(Icons.compare_arrows, size: size, color: color);
      case 'sentOffer':
        return Icon(Icons.send, size: size, color: color);
      case 'mututalAgreementDone':
        return Icon(Icons.handshake, size: size, color: color);
      case 'rennovationDone':
        return Icon(Icons.build, size: size, color: color);
      case 'inMarket':
        return Icon(Icons.public, size: size, color: color);
      case 'tokenAmountGiven':
        return Icon(Icons.attach_money, size: size, color: color);
      case 'primaryRegistrationDone':
        return Icon(Icons.assignment_turned_in, size: size, color: color);
      case 'loanInProcess':
        return Icon(Icons.monetization_on, size: size, color: color);
      case 'registrationScheduled':
        return Icon(Icons.calendar_today, size: size, color: color);
      case 'finalRegistrationDone':
        return Icon(Icons.check_circle, size: size, color: color);
      case 'commisionReceived':
        return Icon(Icons.payment, size: size, color: color);
      default:
        return Icon(Icons.info, size: size, color: color);
    }
  }
}
