import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ReportIncidentFormScreen extends StatefulWidget {
  const ReportIncidentFormScreen({super.key});

  @override
  State<ReportIncidentFormScreen> createState() =>
      _ReportIncidentFormScreenState();
}

class _ReportIncidentFormScreenState extends State<ReportIncidentFormScreen> {
  void onSubmit() {
    if (_formKey.currentState!.validate() &&
        _incidentDate != null &&
        _incidentTime != null) {
      DateTime incidentDateTime = DateTime(
        _incidentDate!.year,
        _incidentDate!.month,
        _incidentDate!.day,
        _incidentTime!.hour,
        _incidentTime!.minute,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Incident reported on ${DateFormat.yMd().add_jm().format(incidentDateTime)}')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please complete all fields, including date and time.')),
      );
    }
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      setState(() {
        _selectedImages = images.map((image) => File(image.path)).toList();
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _incidentDate;
  TimeOfDay? _incidentTime;
  List<File> _selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Incident'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    _pickDate(context);
                  },
                  child: Text(
                    _incidentDate == null
                        ? 'Select Date'
                        : 'Selected Date: ${DateFormat.yMd().format(_incidentDate!)}',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _pickTime(context);
                  },
                  child: Text(
                    _incidentTime == null
                        ? 'Select Time'
                        : 'Selected Time: ${_incidentTime!.format(context)}',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickImages,
                  child: Text(
                    _selectedImages.isEmpty
                        ? 'Select Images'
                        : 'Images Selected: ${_selectedImages.length}',
                  ),
                ),
                if (_selectedImages.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _selectedImages.length,
                    itemBuilder: (context, index) {
                      return Image.file(
                        _selectedImages[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onSubmit,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pickDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      setState(() {
        _incidentDate = selectedDate;
      });
    }
  }

  void _pickTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        _incidentTime = selectedTime;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
