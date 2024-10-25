import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting
import '../services/project_status_service.dart';
import '../widgets/circularProgressIndicator.dart';
import '../screens/projects_detail_screen.dart';
import 'package:anucivil_client/models/lead.dart';

class LeadCard extends StatefulWidget {
  final Lead lead;
  final bool isSelected;
  final VoidCallback onTap;

  LeadCard({
    required this.lead,
    required this.isSelected,
    required this.onTap,
  });

  @override
  _LeadCardState createState() => _LeadCardState();
}

class _LeadCardState extends State<LeadCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: widget.isSelected
                    ? Colors.blueAccent
                    : Colors.grey.shade200,
                width: widget.isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: _isExpanded ? 8 : 4,
            shadowColor: Colors.grey.withOpacity(0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    _getTitleText(),
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_isExpanded)
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(lead: widget.lead),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 24,
                            color: Colors.blueAccent,
                          ),
                          tooltip: 'View Details',
                        ),
                    ],
                  ),
                  leading: _buildStatusIcon(widget.lead.status ?? ''),
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
                if (_isExpanded) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8.0),
                        Text(
                          _getSubtitleText(),
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          _getAddressOrComments(),
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildPriceAndDeadline(widget.lead),
                            _buildDeadline(widget.lead),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                  _buildStatusBar(widget.lead.status ?? ''),
                ],
                if (widget.isSelected)
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.blueAccent,
                        size: 28,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTitleText() {
    if (widget.lead.leadType == LeadType.sell ||
        widget.lead.leadType == LeadType.tolet) {
      return '${widget.lead.totalBedrooms != null ? '${widget.lead.totalBedrooms}-BHK' : ''} ${widget.lead.propertyTyp ?? ''}';
    } else {
      return widget.lead.buyerName ?? '';
    }
  }

  String _getSubtitleText() {
    if (widget.lead.leadType == LeadType.sell ||
        widget.lead.leadType == LeadType.tolet) {
      return 'Area: ${widget.lead.areaInSft ?? ''} sqft';
    } else {
      return widget.lead.preferredProperties.toString() ?? '';
    }
  }

  String _getAddressOrComments() {
    if (widget.lead.leadType == LeadType.sell ||
        widget.lead.leadType == LeadType.tolet) {
      return widget.lead.roughAddress ?? '';
    } else {
      return widget.lead.buyerComments ?? '';
    }
  }

  Widget _buildStatusIcon(String status) {
    double progress = ProjectStatusService.getProgress(status);
    Color color = ProjectStatusService.getColor(status);

    return CircularProgressIndicatorWithPercentage(
        progress: progress, color: color);
  }

  Widget _buildPriceAndDeadline(Lead lead) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${(lead.leadType == LeadType.sell || lead.leadType == LeadType.tolet) ? 'Price' : 'Budget'}',
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Text(
            '${(lead.leadType == LeadType.sell || lead.leadType == LeadType.tolet) ? lead.sellingPrice ?? lead.propertyRent ?? '' : lead.buyerBudget ?? ''}',
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ProjectStatusService.getColorBasedOnStatus(
                  lead.status ?? '',
                  isAmount: true),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildDeadline(Lead lead) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (lead.leadType == LeadType.sell || lead.leadType == LeadType.tolet)
            Text(
              'Deadline',
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          if (lead.leadType == LeadType.sell || lead.leadType == LeadType.tolet)
            Text(
              _formatDeadline(lead.deadlineToSell),
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ProjectStatusService.getColorBasedOnStatus(
                    lead.status ?? '',
                    isAmount: false),
              ),
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }

  String _formatDeadline(String? deadline) {
    if (deadline == null || deadline.isEmpty) return '';
    try {
      final date = DateTime.parse(deadline);
      return DateFormat('MMM d, yyyy').format(date);
    } catch (e) {
      return deadline; // Return original string if parsing fails
    }
  }

  Widget _buildStatusBar(String status) {
    Color color = ProjectStatusService.getColor(status);
    String text = ProjectStatusService.getStatusText(status);
    Widget icon = ProjectStatusService.getStatusIcon(status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.lato(
                fontSize: 16,
                color: color,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
