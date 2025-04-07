import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:edulinkhub/widget/admin_drawer.dart'; // Import the drawer file

class AdminDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red.shade400,
      ),
      drawer: AdminDrawer(), // Attach the drawer here
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 20),
              _buildStatsRow(),
              SizedBox(height: 20),
              _buildChart(),
              SizedBox(height: 20),
              _buildNavigationGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Welcome, Admin!',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/images/profile.jpg'),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard('Total Users', '1.2K', Icons.people),
        _buildStatCard('Total Funds', '\$50K', Icons.attach_money),
        _buildStatCard('Books Uploaded', '120', Icons.book),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.red.shade600),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Growth',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 1),
                        FlSpot(1, 3),
                        FlSpot(2, 7),
                        FlSpot(3, 6),
                        FlSpot(4, 8),
                        FlSpot(5, 10),
                      ],
                      isCurved: true,
                      color: Colors.red.shade600,
                      dotData: FlDotData(show: false),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5, // Increase height/width ratio to make buttons larger
      children: [
        _buildAdminButton(
          context,
          'Manage Admission',
          Icons.school,
          '/admin-admission-management',
          Colors.blue.shade700,
        ),
        _buildAdminButton(
          context,
          'Manage Funding',
          Icons.money,
          '/admin-funding-management',
          Colors.green.shade700,
        ),
        _buildAdminButton(
          context,
          'Manage Books',
          Icons.book,
          '/admin-books-management',
          Colors.orange.shade700,
        ),
        _buildAdminButton(
          context,
          'View Reports',
          Icons.analytics,
          '/admin-reports',
          Colors.purple.shade700,
        ),
      ],
    );
  }

  Widget _buildAdminButton(BuildContext context, String title, IconData icon, String route, Color color) {
    return Card(
      elevation: 4, // Softer shadow for a gentle effect
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        splashColor: Colors.blue.withOpacity(0.2), // Soft splash effect
        highlightColor: Colors.blue.withOpacity(0.1), // Light highlight on tap
        child: Container(
          decoration: BoxDecoration(
            color: color, // More vibrant color for better contrast
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Increased padding for larger buttons
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, size: 50, color: Colors.white), // Larger icon for better visibility
                SizedBox(height: 10), // More spacing for better readability
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for better contrast
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
