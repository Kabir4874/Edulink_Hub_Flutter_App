import 'dart:convert';

import 'package:edulinkhub/screens/universitydetailspage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdmissionPage extends StatefulWidget {
  @override
  _AdmissionPageState createState() => _AdmissionPageState();
}

class _AdmissionPageState extends State<AdmissionPage> {
  List<dynamic> universities = [];
  List<dynamic> filteredUniversities = [];
  Set<String> countries = {'All Countries'};
  Set<String> programTypes = {'All Programs'};
  String selectedCountry = 'All Countries';
  String selectedProgramType = 'All Programs';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUniversities();
  }

  Future<void> fetchUniversities() async {
    final response = await http.get(Uri.parse(
        'https://edulink-hub-backend.onrender.com/university/get-all'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        setState(() {
          universities = data['universities'];
          filteredUniversities = universities;
          extractFilterOptions();
          filterUniversities();
        });
      }
    }
  }

  void extractFilterOptions() {
    countries.add('All Countries');
    programTypes.add('All Programs');
    universities.forEach((university) {
      if (university['location'] != null) {
        countries.add(university['location']);
      }
      if (university['programType'] != null) {
        programTypes.add(university['programType']);
      }
    });
  }

  void filterUniversities() {
    setState(() {
      filteredUniversities = universities.where((university) {
        final bool matchesCountry = selectedCountry == 'All Countries' ||
            university['location'] == selectedCountry;
        final bool matchesProgram = selectedProgramType == 'All Programs' ||
            university['programType'] == selectedProgramType;
        final bool matchesSearch = searchController.text.isEmpty ||
            university['name']
                .toLowerCase()
                .contains(searchController.text.toLowerCase());
        return matchesCountry && matchesProgram && matchesSearch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admission Page'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Universities',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              onChanged: (value) => filterUniversities(),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedCountry,
                    items: countries.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value!;
                        filterUniversities();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                ),

                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedProgramType,
                    items: programTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedProgramType = value!;
                        filterUniversities();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Program Type',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // University List
            Expanded(
              child: ListView.builder(
                itemCount: filteredUniversities.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(

                      title: Text(filteredUniversities[index]['name']),
                      subtitle: Text(
                          'Location: ${filteredUniversities[index]['location']}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UniversityDetailsPage(
                              universityId: filteredUniversities[index]['_id'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
