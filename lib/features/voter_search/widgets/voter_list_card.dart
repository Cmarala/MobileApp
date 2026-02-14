import 'package:flutter/material.dart';
import 'package:mobileapp/models/voter.dart';
import 'package:mobileapp/models/enums.dart';
import 'package:mobileapp/utils/bilingual_helper.dart';

class VoterListCard extends StatelessWidget {
  final Voter voter;
  final String langCode;
  final VoidCallback onTap;

  const VoterListCard({
    super.key,
    required this.voter,
    required this.langCode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final voterName = BilingualHelper.getVoterName(
      voter.name,
      voter.nameLocal,
      langCode,
    );
    
    final relationName = BilingualHelper.getLocalizedValue(
      englishValue: voter.relationName,
      localValue: voter.relationNameLocal,
      currentLangCode: langCode,
    );
    
    final address = BilingualHelper.getLocalizedValue(
      englishValue: voter.address,
      localValue: voter.addressLocal,
      currentLangCode: langCode,
    );
    
    // Combine house_no and address
    String fullAddress = '';
    if (voter.houseNo != null && voter.houseNo!.isNotEmpty) {
      fullAddress = voter.houseNo!;
      if (address.isNotEmpty) {
        fullAddress += ', $address';
      }
    } else if (address.isNotEmpty) {
      fullAddress = address;
    }

    // Compact age/gender format: 26/F
    String ageGenderText = '';
    if (voter.age != null && voter.gender != null) {
      ageGenderText = '${voter.age}/${voter.gender!.code}';
    } else if (voter.age != null) {
      ageGenderText = '${voter.age}';
    } else if (voter.gender != null) {
      ageGenderText = voter.gender!.code;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade200, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column 1: Left Side - Favorability, Part/Serial, Age/Gender
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Prominent Favorability Indicator
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: voter.favorability.color,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: voter.favorability.color.withValues(alpha: 0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        voter.favorability == VoterFavorability.veryStrong ? Icons.favorite : 
                        voter.favorability == VoterFavorability.strong ? Icons.thumb_up : 
                        voter.favorability == VoterFavorability.neutral ? Icons.circle : Icons.block,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  
                  // Part No / Serial Number (bold)
                  if (voter.boothNumber != null && voter.serialNumber != null) ...[
                    Text(
                      '${voter.boothNumber}/${voter.serialNumber}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                  ] else if (voter.boothNumber != null) ...[
                    Text(
                      '${voter.boothNumber}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                  ] else if (voter.serialNumber != null) ...[
                    Text(
                      '${voter.serialNumber}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                  ],
                  
                  // Age/Gender
                  if (ageGenderText.isNotEmpty) ...[
                    Text(
                      ageGenderText,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(width: 12),
              
              // Column 2: Main Voter Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name - Prominent
                    Text(
                      voterName.isEmpty ? 'Unknown' : voterName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    // Relative Name - 2 lines allowed with icon
                    if (relationName.isNotEmpty) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.person_outline, size: 14, color: Colors.grey[700]),
                          const SizedBox(width: 4),
                          if (voter.relation != null) ...[
                            Text(
                              '(${voter.relation}) ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                          Expanded(
                            child: Text(
                              relationName,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                    
                    // Address - 2 lines with icon
                    if (fullAddress.isNotEmpty) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Icon(Icons.home_outlined, size: 14, color: Colors.grey[700]),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              fullAddress,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                    
                    // EPIC ID and Mobile in one row - compact
                    Row(
                      children: [
                        if (voter.epicId != null) ...[
                          Icon(Icons.badge, size: 13, color: Colors.grey[700]),
                          const SizedBox(width: 3),
                          Text(
                            voter.epicId!,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        if (voter.epicId != null && voter.phone != null) ...[
                          const SizedBox(width: 8),
                          Text('•', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                          const SizedBox(width: 8),
                        ],
                        if (voter.phone != null) ...[
                          Icon(Icons.phone, size: 13, color: Colors.grey[700]),
                          const SizedBox(width: 3),
                          Text(
                            voter.phone!,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              
              // Chevron
              Icon(Icons.chevron_right, size: 18, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
