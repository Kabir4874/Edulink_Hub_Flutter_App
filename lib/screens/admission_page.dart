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
      examUnits: ["20/05/25", "21/05/25", "22/05/25", "23/05/25"],
    ),
    University(
      name: "Dhaka University",
      location: "Dhaka",
      applyDate: "10/02/2025",
      deadline: "15/03/2025",
      applyLink: "https://admission.du.ac.bd/",
      admitCardDownload: "05/04/2025",
      examUnits: ["10/04/25", "11/04/25", "12/04/25", "13/04/25"],
    ),
  University(
  name: "Chittagong University",
  location: "Chittagong",
  applyDate: "23/03/2025",
  deadline: "24/04/2025",
  applyLink: "https://admission.cu.ac.bd/",
  admitCardDownload: "15/05/2025",
  examUnits: ["20/05/25", "21/05/25", "22/05/25", "23/05/25"],
  ),
  University(
  name: "Dhaka University",
  location: "Dhaka",
  applyDate: "01/02/2025",
  deadline: "11/03/2025",
  applyLink: "https://admission.eis.du.ac.bd/en/408b7c8ad06e4d9954fa2d948a01f508",
  admitCardDownload: "25/03/2025",
  examUnits: ["27/02/25", "28/02/25", "01/03/25", "02/03/25"],
  ),
  University(
  name: "Shahjalal University of Science and Technology",
  location: "Sylhet",
  applyDate: "05/02/2025",
  deadline: "13/03/2025",
  applyLink: "https://admission.sust.edu.bd/",
  admitCardDownload: "24/03/2025",
  examUnits: ["25/03/25", "26/03/25", "27/03/25", "28/03/25"],
  ),
  University(
  name: "Rajshahi University",
  location: "Rajshahi",
  applyDate: "01/02/2025",
  deadline: "01/03/2025",
  applyLink: "https://admission.ru.ac.bd/",
  admitCardDownload: "20/02/2025",
  examUnits: ["23/02/25", "24/02/25", "25/02/25", "26/02/25"],
  ),
  University(
  name: "Jahangirnagar University",
  location: "Dhaka",
  applyDate: "01/03/2025",
  deadline: "21/02/2025",
  applyLink: "https://ju-admission.org/",
  admitCardDownload: "28/02/2025",
  examUnits: ["05/03/25", "06/03/25", "07/03/25", "08/03/25"],
  ),
  University(
  name: "Khulna University",
  location: "Khulna",
  applyDate: "09/02/2025",
  deadline: "22/02/2025",
  applyLink: "https://admission.ku.ac.bd/",
  admitCardDownload: "01/03/2025",
  examUnits: ["15/03/25", "16/03/25", "17/03/25", "18/03/25"],
  ),
  University(
  name: "Jagannath University",
  location: "Dhaka",
  applyDate: "10/02/2025",
  deadline: "25/02/2025",
  applyLink: "https://jnuadmission.com/",
  admitCardDownload: "09/03/2025",
  examUnits: ["20/03/25", "21/03/25", "22/03/25", "23/03/25"],
  ),
  University(
  name: "Agricultural GST Admission",
  location: "Mymenshing, Dhaka",
  applyDate: "13/02/2025",
  deadline: "23/02/2025",
  applyLink: "https://acas.edu.bd/signin",
  admitCardDownload: "05/03/2025",
  examUnits: ["1/05/25"],
  ),
  University(
  name: "Hajee Mohammad Danesh Science & Technology University",
  location: "Basherhat",
  applyDate: "12/02/2025",
  deadline: "25/03/2025",
  applyLink: "https://hstu.ac.bd/admission/index",
  admitCardDownload: "30/03/2025",
  examUnits: ["12/04/25", "13/04/25", "14/04/25", "15/04/25"],
  ),
  University(
  name: "Patuakhali Science & Technology University",
  location: "Patuakhali",
  applyDate: "21/02/2025",
  deadline: "21/03/2025",
  applyLink: "https://www.pstu.ac.bd/admission",
  admitCardDownload: "06/04/2025",
  examUnits: ["18/04/25", "19/04/25", "20/04/25", "21/04/25"],
  ),
  University(
  name: "University GST Admission",
  location: "All District",
  applyDate: "05/03/2025",
  deadline: "15/03/2025",
  applyLink: "https://gstadmission.ac.bd/",
  admitCardDownload: "06/05/25",
  examUnits: ["12/05/2025", "13/05/25", "14/05/25", "15/05/25"],
  ),
  University(
  name: "Bangladesh University of Engineering and Technology (BUET)",
  location: "Dhaka",
  applyDate: "10/01/2025",
  deadline: "12/02/2025",
  applyLink: "https://ipe.buet.ac.bd/page/undergraduate-admission",
  admitCardDownload: "27/02/2025",
  examUnits: ["13/03/25"],
  ),
  University(
  name: "Chittagong University of Engineering & Technology (CUET)",
  location: "Chittagong",
  applyDate: "12/03/2025",
  deadline: "24/03/2025",
  applyLink: "https://www.cuet.ac.bd/admission",
  admitCardDownload: "06/04/2025",
  examUnits: ["10/06/25"],
  ),
  University(
  name: "Rajshahi University of Engineering & Technology (RUET)",
  location: "Rajshahi",
  applyDate: "18/05/2025",
  deadline: "25/05/2025",
  applyLink: "https://admission.ruet.ac.bd/",
  admitCardDownload: "09/06/2025",
  examUnits: ["12/06/25"],
  ),
  University(
  name: "Khulna University of Engineering & Technology (KUET)",
  location: "Khulna",
  applyDate: "08/02/2025",
  deadline: "27/02/2025",
  applyLink: "https://www.kuet.ac.bd/",
  admitCardDownload: "02/03/2025",
  examUnits: ["8/04/25"],
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
