import 'package:flutter/material.dart';
import 'package:edulinkhub/widget/app_drawer.dart';
import 'package:edulinkhub/model/university.dart'; // Import the model
import 'package:edulinkhub/screens/universitydetailspage.dart';

class AdmissionPage extends StatelessWidget {
  final List<University> universities = [
    University(
      name: "Chittagong University",
      location: "Chittagong",
      applyDate: "23/03/2025",
      deadline: "24/04/2025",
      applyLink: "https://admission.cu.ac.bd/",
      admitCardDownload: "15/05/2025",
      examUnits: ["A-20/05/25", "B-21/05/25", "C-22/05/25", "D-23/05/25"],
      imageUrl: "https://example.com/chittagong-university.jpg", // ✅ Add image URL
    ),
    University(
      name: "Dhaka University",
      location: "Dhaka",
      applyDate: "10/02/2025",
      deadline: "15/03/2025",
      applyLink: "https://admission.du.ac.bd/",
      admitCardDownload: "05/04/2025",
      examUnits: ["A-10/04/25", "B-11/04/25", "C-12/04/25", "D-13/04/25"],
      imageUrl: "https://example.com/dhaka-university.jpg", // ✅ Add image URL
    ),
    University(
      name: "Shahjalal University of Science and Technology",
      location: "Sylhet",
      applyDate: "05/02/2025",
      deadline: "13/03/2025",
      applyLink: "https://admission.sust.edu.bd/",
      admitCardDownload: "24/03/2025",
      examUnits: ["A-25/03/25", "B-26/03/25", "C-27/03/25", "D-28/03/25"],
      imageUrl: "https://example.com/sust.jpg",
    ),
    University(
      name: "Rajshahi University",
      location: "Rajshahi",
      applyDate: "01/02/2025",
      deadline: "01/03/2025",
      applyLink: "https://admission.ru.ac.bd/",
      admitCardDownload: "20/02/2025",
      examUnits: ["A-23/02/25", "B-24/02/25", "C-25/02/25", "D-26/02/25"],
      imageUrl: "https://example.com/rajshahi-university.jpg",
    ),
    University(
      name: "Jahangirnagar University",
      location: "Dhaka",
      applyDate: "01/03/2025",
      deadline: "21/02/2025",
      applyLink: "https://ju-admission.org/",
      admitCardDownload: "28/02/2025",
      examUnits: ["A-05/03/25", "B-06/03/25", "C-07/03/25", "D-08/03/25"],
      imageUrl: "https://example.com/jahangirnagar-university.jpg",
    ),
    University(
      name: "Khulna University",
      location: "Khulna",
      applyDate: "09/02/2025",
      deadline: "22/02/2025",
      applyLink: "https://admission.ku.ac.bd/",
      admitCardDownload: "01/03/2025",
      examUnits: ["A-15/03/25", "B-16/03/25", "C-17/03/25", "D-18/03/25"],
      imageUrl: "https://example.com/khulna-university.jpg",
    ),
    University(
      name: "Jagannath University",
      location: "Dhaka",
      applyDate: "10/02/2025",
      deadline: "25/02/2025",
      applyLink: "https://jnuadmission.com/",
      admitCardDownload: "09/03/2025",
      examUnits: ["A-20/03/25", "B-21/03/25", "C-22/03/25", "D-23/03/25"],
      imageUrl: "https://example.com/jagannath-university.jpg",
    ),
    University(
      name: "Agricultural GST Admission",
      location: "Mymenshing, Dhaka",
      applyDate: "13/02/2025",
      deadline: "23/02/2025",
      applyLink: "https://acas.edu.bd/signin",
      admitCardDownload: "05/03/2025",
      examUnits: ["1/05/25"],
      imageUrl: "https://example.com/agriculture-gst.jpg",
    ),
    University(
      name: "Hajee Mohammad Danesh Science & Technology University",
      location: "Basherhat",
      applyDate: "12/02/2025",
      deadline: "25/03/2025",
      applyLink: "https://hstu.ac.bd/admission/index",
      admitCardDownload: "30/03/2025",
      examUnits: ["12/04/25", "13/04/25", "14/04/25", "15/04/25"],
      imageUrl: "https://example.com/hstu.jpg",
    ),
    University(
      name: "Patuakhali Science & Technology University",
      location: "Patuakhali",
      applyDate: "21/02/2025",
      deadline: "21/03/2025",
      applyLink: "https://www.pstu.ac.bd/admission",
      admitCardDownload: "06/04/2025",
      examUnits: ["A-18/04/25", "B-19/04/25", "C-20/04/25", "D-21/04/25"],
      imageUrl: "https://example.com/pstu.jpg",
    ),
    University(
      name: "University GST Admission",
      location: "All District",
      applyDate: "05/03/2025",
      deadline: "15/03/2025",
      applyLink: "https://gstadmission.ac.bd/",
      admitCardDownload: "06/05/25",
      examUnits: ["A-12/05/2025", "B-13/05/25", "C-14/05/25", "D-15/05/25"],
      imageUrl: "https://example.com/gst.jpg",
    ),
    University(
      name: "Bangladesh University of Engineering and Technology (BUET)",
      location: "Dhaka",
      applyDate: "10/01/2025",
      deadline: "12/02/2025",
      applyLink: "https://ipe.buet.ac.bd/page/undergraduate-admission",
      admitCardDownload: "27/02/2025",
      examUnits: ["13/03/25"],
      imageUrl: "https://example.com/buet.jpg",
    ),
    University(
      name: "Chittagong University of Engineering & Technology (CUET)",
      location: "Chittagong",
      applyDate: "12/03/2025",
      deadline: "24/03/2025",
      applyLink: "https://www.cuet.ac.bd/admission",
      admitCardDownload: "06/04/2025",
      examUnits: ["10/06/25"],
      imageUrl: "https://example.com/cuet.jpg",
    ),
    University(
      name: "Rajshahi University of Engineering & Technology (RUET)",
      location: "Rajshahi",
      applyDate: "18/05/2025",
      deadline: "25/05/2025",
      applyLink: "https://admission.ruet.ac.bd/",
      admitCardDownload: "09/06/2025",
      examUnits: ["12/06/25"],
      imageUrl: "https://example.com/ruet.jpg",
    ),
    University(
      name: "Khulna University of Engineering & Technology (KUET)",
      location: "Khulna",
      applyDate: "08/02/2025",
      deadline: "27/02/2025",
      applyLink: "https://www.kuet.ac.bd/",
      admitCardDownload: "02/03/2025",
      examUnits: ["8/04/25"],
      imageUrl: "https://example.com/kuet.jpg",
    ),
  ];

  // Add more universities as needed...


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admission Page'),
        actions: [
          // User Profile Button
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'), // Add profile image
            ),
            onPressed: () {
              // Navigate to user profile page when profile image is tapped
              Navigator.pushNamed(
                context,
                '/profile',
                arguments: {
                  'fullName': 'John Doe',  // Example data
                  'email': 'johndoe@example.com',
                  'phoneNumber': '+123456789',
                },
              );
            },
          ),
        ],
        backgroundColor: Colors.blue.shade300,
      ),
      drawer: AppDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                labelText: 'Search Universities',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Implement search functionality
              },
            ),
            SizedBox(height: 16),
            // Filters for Categorization
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: 'All Countries',
                    items: ['All Countries', 'USA', 'Canada', 'UK', 'Australia']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // Implement country filter
                    },
                    decoration: InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: 'All Programs',
                    items: ['All Programs', 'Undergraduate', 'Postgraduate', 'Ph.D.']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // Implement program type filter
                    },
                    decoration: InputDecoration(
                      labelText: 'Program Type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: universities.length, // Use universities list instead of hardcoded number
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(universities[index].name), // Display actual university name
                      subtitle: Text('Admission Deadline: ${universities[index].deadline}'),
                      trailing: IconButton(
                        icon: Icon(Icons.notifications),
                        onPressed: () {
                          // Implement notification for deadline
                        },
                      ),
                      onTap: () {
                        // Navigate to the university details page and pass the university object
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UniversityDetailsPage(university: universities[index]),
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
