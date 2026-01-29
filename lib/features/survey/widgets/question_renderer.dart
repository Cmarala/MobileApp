import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/models/survey_model.dart';
import 'package:mobileapp/utils/bilingual_helper.dart';
import 'package:mobileapp/features/settings/providers/settings_providers.dart';
class QuestionRenderer extends ConsumerWidget {
  final SurveyQuestion question;
  
  // DATA INPUTS
  final String? currentAnswerValue;      // For Text/Date inputs
  final List<String> selectedOptionIds;  // For ALL Select inputs (Single & Multi)
  
  // CALLBACKS
  // Returns list of selected IDs (for checkbox/chips)
  final Function(List<String> ids) onOptionChanged; 
  // Returns text value (for text/date)
  final Function(String value) onTextChanged;       

  const QuestionRenderer({
    Key? key,
    required this.question,
    this.currentAnswerValue,
    this.selectedOptionIds = const [], // Default to empty list
    required this.onOptionChanged,
    required this.onTextChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final langCode = ref.watch(settingsProvider).langCode;
    if (question.uiType == QuestionUiType.sectionHeader) {
      return _buildHeader(context, langCode);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Question Label
          Text(
            BilingualHelper.getQuestionText(question.text, question.textLocal, langCode) + (question.isMandatory ? ' *' : ''),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          
          // 2. The Widget
          _buildInputWidget(context, langCode),
        ],
      ),
    );
  }

  // --- 1. RENDERER SWITCHER ---

  Widget _buildInputWidget(BuildContext context, String langCode) {
    switch (question.uiType) {
      // Free Text
      case QuestionUiType.textInput:
      case QuestionUiType.numericInput:
        return _buildTextField();
      
      case QuestionUiType.datePicker:
        return _buildDatePicker(context);

      // Single Select
      case QuestionUiType.radioList:
      case QuestionUiType.searchableDropdown: 
        return _buildRadioList(langCode); // Or dropdown if preferred
        
      // Multi Select
      case QuestionUiType.checkboxList:
        return _buildCheckboxList(langCode);
        
      case QuestionUiType.chipSelect:
        return _buildChipSelect(context, langCode);

      case QuestionUiType.searchableMultiSelect: 
        return _buildSearchableMultiSelect(context, langCode); // The "Heavy Lifter"

      default:
        return const Text("Unsupported Type", style: TextStyle(color: Colors.red));
    }
  }

  // --- 2. SIMPLE WIDGETS ---

  Widget _buildTextField() {
    final isNumeric = question.uiType == QuestionUiType.numericInput;
    return TextFormField(
      initialValue: currentAnswerValue,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Type answer...',
      ),
      onChanged: onTextChanged,
    );
  }

  Widget _buildRadioList(String langCode) {
    return Column(
      children: question.options.map((opt) {
        return RadioListTile<String>(
          title: Text(BilingualHelper.getOptionText(opt.text, opt.textLocal, langCode)),
          value: opt.id,
          groupValue: selectedOptionIds.firstOrNull, // Check first item
          contentPadding: EdgeInsets.zero,
          onChanged: (val) {
            if (val != null) onOptionChanged([val]); // Send as single-item list
          },
        );
      }).toList(),
    );
  }

  Widget _buildCheckboxList(String langCode) {
    return Column(
      children: question.options.map((opt) {
        final isSelected = selectedOptionIds.contains(opt.id);
        return CheckboxListTile(
          title: Text(BilingualHelper.getOptionText(opt.text, opt.textLocal, langCode)),
          value: isSelected,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          onChanged: (bool? checked) {
            final newIds = List<String>.from(selectedOptionIds);
            if (checked == true) {
              newIds.add(opt.id);
            } else {
              newIds.remove(opt.id);
            }
            onOptionChanged(newIds);
          },
        );
      }).toList(),
    );
  }

  Widget _buildChipSelect(BuildContext context, String langCode) {
    // Determine if this question allows multiple (based on UI logic)
    // Usually chips are multi-select, but can be single. 
    // Let's assume Multi for flexibility.
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: question.options.map((opt) {
        final isSelected = selectedOptionIds.contains(opt.id);
        return FilterChip(
          label: Text(BilingualHelper.getOptionText(opt.text, opt.textLocal, langCode)),
          selected: isSelected,
          onSelected: (bool selected) {
             final newIds = List<String>.from(selectedOptionIds);
            if (selected) {
              newIds.add(opt.id);
            } else {
              newIds.remove(opt.id);
            }
            onOptionChanged(newIds);
          },
        );
      }).toList(),
    );
  }

  // --- 3. THE "SEARCHABLE MULTI SELECT" (For 50+ Schemes) ---

  Widget _buildSearchableMultiSelect(BuildContext context, String langCode) {
    // 1. Calculate Summary (e.g., "3 Selected")
    final count = selectedOptionIds.length;
    final summaryText = count == 0 
        ? "Select Options" 
        : "$count selected";

    return InkWell(
      onTap: () => _showMultiSelectDialog(context, langCode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(summaryText, style: const TextStyle(fontSize: 16)),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  void _showMultiSelectDialog(BuildContext context, String langCode) {
    // We use a StatefulBuilder inside the Dialog to handle local search state
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) {
        return _SearchableDialogContent(
          options: question.options,
          initialSelection: selectedOptionIds,
          langCode: langCode,
          onConfirm: onOptionChanged,
        );
      },
    );
  }
  
  // --- 4. VISUAL HEADER ---
  
  Widget _buildHeader(BuildContext context, String langCode) {
     return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 2)),
      ),
      child: Text(
        BilingualHelper.getQuestionText(question.text, question.textLocal, langCode),
        style: TextStyle(
          fontSize: 18, 
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
  
  // --- 5. DATE PICKER ---
  Widget _buildDatePicker(BuildContext context) {
     // (Same as previous code)
     return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          final formatted = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
          onTextChanged(formatted);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currentAnswerValue ?? 'Select Date',
              style: TextStyle(
                  color: currentAnswerValue == null ? Colors.grey : Colors.black),
            ),
            const Icon(Icons.calendar_today, size: 20),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// INTERNAL HELPER: The Searchable Dialog Logic
// =============================================================================

class _SearchableDialogContent extends StatefulWidget {
  final List<SurveyOption> options;
  final List<String> initialSelection;
  final String langCode;
  final Function(List<String>) onConfirm;

  const _SearchableDialogContent({
    required this.options,
    required this.initialSelection,
    required this.langCode,
    required this.onConfirm,
  });

  @override
  State<_SearchableDialogContent> createState() => _SearchableDialogContentState();
}

class _SearchableDialogContentState extends State<_SearchableDialogContent> {
  late List<String> _tempSelectedIds;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tempSelectedIds = List.from(widget.initialSelection);
  }

  @override
  Widget build(BuildContext context) {
    // 1. Filter Options (search both English and local text)
    final filtered = widget.options.where((opt) {
      final englishText = opt.text.toLowerCase();
      final localText = opt.textLocal?.toLowerCase() ?? '';
      final query = _searchQuery.toLowerCase();
      return englishText.contains(query) || localText.contains(query);
    }).toList();

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                setState(() => _searchQuery = val);
              },
            ),
          ),
          
          // List
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filtered.length,
              itemBuilder: (ctx, index) {
                final opt = filtered[index];
                final isSelected = _tempSelectedIds.contains(opt.id);
                return CheckboxListTile(
                  title: Text(BilingualHelper.getOptionText(opt.text, opt.textLocal, widget.langCode)),
                  value: isSelected,
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
                        _tempSelectedIds.add(opt.id);
                      } else {
                        _tempSelectedIds.remove(opt.id);
                      }
                    });
                  },
                );
              },
            ),
          ),
          
          // Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {
                widget.onConfirm(_tempSelectedIds);
                Navigator.pop(context);
              },
              child: Text("Confirm (${_tempSelectedIds.length})"),
            ),
          ),
        ],
      ),
    );
  }
}