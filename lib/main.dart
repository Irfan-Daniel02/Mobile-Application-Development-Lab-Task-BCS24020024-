import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }

  // Portrait Mode: Stack StudentDetailsSection, TitleSection, Image, and Pickers vertically
  Widget _buildPortraitView() {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: const [
        StudentDetailsSection(),
        TitleSection(
          name: 'Taman Sri Perlabuhan',
          location: 'Bintulu, Sarawak, Malaysia',
          starCount: 41,
        ),
        ImageSection(imagePath: 'assets/Bintulu-Sarawak-Malaysia-featured.jpg'),
        SizedBox(height: 16),
        InteractivePickersSection(),
      ],
    );
  }

  // Landscape Mode: Place StudentDetailsSection and TitleSection + Pickers side-by-side
  Widget _buildLandscapeView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: StudentDetailsSection(),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: const [
              TitleSection(
                name: 'Taman Sri Perlabuhan',
                location: 'Bintulu, Sarawak, Malaysia',
                starCount: 41,
              ),
              ImageSection(imagePath: 'assets/Bintulu-Sarawak-Malaysia-featured.jpg'),
              SizedBox(height: 16),
              InteractivePickersSection(),
            ],
          ),
        ),
      ],
    );
  }
}

// --- LAB 01 DECOMPOSED WIDGET: STUDENT DETAILS SECTION ---
class StudentDetailsSection extends StatelessWidget {
  const StudentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.indigo,
              backgroundImage: AssetImage('assets/profile.jpeg'),
            ),
            SizedBox(height: 20),
            Text(
              'IRFAN DANIEL BIN ABDUL RAHIM',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Student ID: BCS24020024',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Divider(height: 32, thickness: 1),
            Text(
              'Personal Life Goal / Quote:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '"To be financially independent"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- EXERCISE 2.1: TITLE SECTION ---
class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const Icon(Icons.star, color: Colors.red),
          const SizedBox(width: 4),
          Text('$starCount'),
        ],
      ),
    );
  }
}

// --- EXERCISE 2.2: IMAGE SECTION ---
class ImageSection extends StatelessWidget {
  final String imagePath;

  const ImageSection({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imagePath,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

// --- EXERCISE 2.2: PICKERS (MATERIAL VS. CUPERTINO) ---
class InteractivePickersSection extends StatefulWidget {
  const InteractivePickersSection({super.key});

  @override
  State<InteractivePickersSection> createState() => _InteractivePickersSectionState();
}

class _InteractivePickersSectionState extends State<InteractivePickersSection> {
  DateTime _selectedDate = DateTime.now();
  String _selectedRole = 'Student';
  final List<String> _roles = ['Student', 'Developer', 'Designer'];

  // 1. Material Date Picker
  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // 2. Cupertino Date Picker (Modal Sheet)
  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 240,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: _selectedDate,
          maximumDate: DateTime.now(),
          onDateTimeChanged: (DateTime newDate) {
            setState(() => _selectedDate = newDate);
          },
        ),
      ),
    );
  }

  // 4. Cupertino Picker (Wheel)
  void _showCupertinoRolePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 200,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoPicker(
          itemExtent: 32,
          onSelectedItemChanged: (int index) {
            setState(() => _selectedRole = _roles[index]);
          },
          children: _roles.map((role) => Center(child: Text(role))).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Pickers (Lab 2.2)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Divider(),
            Text(
              'Selected Date: $formattedDate',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Selected Role: $_selectedRole',
              style: const TextStyle(color: Colors.indigo),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => _selectMaterialDate(context),
              icon: const Icon(Icons.calendar_today, size: 18),
              label: const Text('Material Date Picker'),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => _showCupertinoDatePicker(context),
              icon: const Icon(Icons.date_range, size: 18),
              label: const Text('Cupertino Date Picker (Bottom Sheet)'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Material Dropdown: '),
                const SizedBox(width: 8),
                // 3. Material DropdownButton
                DropdownButton<String>(
                  value: _selectedRole,
                  items: _roles.map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _selectedRole = newValue);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => _showCupertinoRolePicker(context),
              icon: const Icon(Icons.list, size: 18),
              label: const Text('Cupertino Wheel Picker'),
            ),
          ],
        ),
      ),
    );
  }
}