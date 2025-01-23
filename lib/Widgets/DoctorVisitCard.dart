import 'package:flutter/material.dart';
import 'package:healthy_sync/unts/AppColor.dart';

class DoctorVisitCard extends StatelessWidget {
  const DoctorVisitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      gradient: AppColor.primaryGradient,
        borderRadius: BorderRadius.circular(12),
      ),

      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Dr. Ahmed',
                  style:  TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.white

                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Cardiologist',
                  style:  TextStyle(
                    fontSize: 16,
                  color: AppColor.white
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time, color: AppColor.white),
                    const SizedBox(width: 4),
                    Text(
                      'Time: ١٢:٠٠ م',
                      style:  TextStyle(fontSize: 16, color: AppColor.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: AppColor.white),
                    const SizedBox(width: 4),
                    Text(
                      "Date: ١٢/١٢/٢٠٢١",
                      style:  TextStyle(
                        fontSize: 14,
                        color: AppColor.white
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Address: 1234 Main St, Cairo, Egypt',
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.description, color: AppColor.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Details: The patient is experiencing chest pain.',
                    style:  TextStyle(fontSize: 16,color: AppColor.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.health_and_safety, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'Stable',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
