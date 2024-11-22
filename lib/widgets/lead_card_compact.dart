import 'package:fhaidaCrm/models/lead.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/project.dart';
import '../services/project_status_service.dart';
import '../widgets/circularProgressIndicator.dart';
import '../screens/projects_detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/lead.dart';
import '../services/project_status_service.dart';
import '../widgets/circularProgressIndicator.dart';
import '../screens/projects_detail_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class LeadCardComponent extends StatelessWidget {
  final Lead lead;
  final bool isSelected;
  final VoidCallback onTap;

  LeadCardComponent({
    required this.lead,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return (lead.buyerPhoneNumber != null && lead.buyerPhoneNumber!.isNotEmpty)
        ? GestureDetector(
            onTap: onTap,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: isSelected ? Colors.blue : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // _buildStatusIcon(lead.status!),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: (lead.leadType == LeadType.sell ||
                                            lead.leadType == LeadType.tolet)
                                        ? Text(
                                            '${lead.numberOfBedrooms != null ? lead.totalBedrooms : ''} ${lead.totalBedrooms!.isNotEmpty ? lead.totalBedrooms : ''} BHK ${lead.propertyTyp}',
                                            style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ))
                                        : Text(
                                            '${lead.buyerName != null ? lead.buyerName : ''} ${lead.buyerOccupation != null ? lead.buyerOccupation : ''}  ${lead.preferredProperties}',
                                            style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        var number =
                                            (lead.buyerPhoneNumber != null &&
                                                    lead.buyerPhoneNumber!
                                                        .isNotEmpty)
                                                ? lead.buyerPhoneNumber
                                                : ''; //set the number here
                                        await FlutterPhoneDirectCaller
                                            .callNumber(number!);
                                      },
                                      icon: Icon(
                                        Icons.call,
                                        size: 22,
                                        color: Colors.blueAccent,
                                      )),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              (lead.leadType == LeadType.sell ||
                                      lead.leadType == LeadType.tolet)
                                  ? Text(
                                      'Area: ${lead.areaInSft} sft ',
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    )
                                  : const SizedBox(height: 0.0),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${(lead.leadType == LeadType.sell || lead.leadType == LeadType.tolet) ? 'Price' : 'Budget'}',
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        '${(lead.leadType == LeadType.sell || lead.leadType == LeadType.tolet) ? (lead.sellingPrice == null) ? lead.sellingPrice : lead.propertyRent : lead.buyerBudget}',
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: ProjectStatusService
                                              .getColorBasedOnStatus(
                                                  lead.status!,
                                                  isAmount: true),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (isSelected)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 24,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          )
        : Wrap(children: [
            GestureDetector(
              onTap: onTap,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: isSelected ? Colors.blue : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // _buildStatusIcon(lead.status!),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: (lead.leadType == LeadType.sell ||
                                              lead.leadType == LeadType.tolet)
                                          ? Text(
                                              '${lead.numberOfBedrooms != null ? lead.totalBedrooms : ''} ${lead.totalBedrooms!.isNotEmpty ? lead.totalBedrooms : ''} BHK ${lead.propertyTyp}',
                                              style: GoogleFonts.roboto(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ))
                                          : Text(
                                              '${lead.buyerName != null ? lead.buyerName : ''} ${lead.buyerOccupation!.isNotEmpty ? lead.buyerOccupation : ''}  ${lead.preferredProperties}',
                                              style: GoogleFonts.roboto(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          var number =
                                              (lead.buyerPhoneNumber != null &&
                                                      lead.buyerPhoneNumber!
                                                          .isNotEmpty)
                                                  ? lead.buyerPhoneNumber
                                                  : ''; //set the number here
                                          await FlutterPhoneDirectCaller
                                              .callNumber(number!);
                                        },
                                        icon: Icon(
                                          Icons.call,
                                          size: 22,
                                          color: Colors.blueAccent,
                                        )),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                (lead.leadType == LeadType.sell ||
                                        lead.leadType == LeadType.tolet)
                                    ? Text(
                                        'Area: ${lead.areaInSft} sft ',
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      )
                                    : const SizedBox(height: 0.0),
                                const SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${(lead.leadType == LeadType.sell || lead.leadType == LeadType.tolet) ? 'Price' : 'Budget'}',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          '${(lead.leadType == LeadType.sell || lead.leadType == LeadType.tolet) ? (lead.sellingPrice == null) ? lead.sellingPrice : lead.propertyRent : lead.buyerBudget}',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: ProjectStatusService
                                                .getColorBasedOnStatus(
                                                    lead.status!,
                                                    isAmount: true),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (isSelected)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 24,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ]);
  }

  Widget _buildStatusIcon(String status) {
    double progress = ProjectStatusService.getProgress(status);
    Color color = ProjectStatusService.getColor(status);

    return CircularProgressIndicatorWithPercentage(
        progress: progress, color: color);
  }

  Widget _buildStatusBar(String status) {
    Color color = ProjectStatusService.getColor(status);
    String text = ProjectStatusService.getStatusText(status);
    Widget icon = ProjectStatusService.getStatusIcon(status);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: color.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          SizedBox(width: 8.0),
          Text(
            text,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
