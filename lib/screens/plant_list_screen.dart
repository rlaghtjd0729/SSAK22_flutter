import 'package:flutter/material.dart';
import '../models/plant_model.dart';
import 'plant_detail_screen.dart';
import 'plant_add_screen.dart';

class PlantListScreen extends StatefulWidget {
  const PlantListScreen({super.key});

  @override
  State<PlantListScreen> createState() => _PlantListScreenState();
}

class _PlantListScreenState extends State<PlantListScreen> {
  List<Plant> plants = [
    Plant(
      name: "톡톡이",
      type: "방울 토마토",
      water: "물 주기 D-3",
      date: "2025.04.22",
      image: "assets/images/tomato.jpg",
      urgent: false,
      lastWatered: DateTime(2025, 5, 21),
      waterCycleDays: 6,
    ),

  ];

  void _navigateToAddScreen() async {
    final Plant? newPlant = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PlantAddScreen()),
    );

    if (newPlant != null) {
      setState(() {
        plants.add(newPlant);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8E8),
      appBar: AppBar(
        title: const Text("내 식물"),
        backgroundColor: const Color(0xFFFCF8E8),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: plants.length,
        itemBuilder: (context, index) {
          final plant = plants[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlantDetailScreen(plant: plant),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: plant.image.isEmpty
                        ? Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                    )
                        : Image.network(
                      plant.image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(plant.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(plant.type, style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 4),
                        Text(
                          plant.water,
                          style: TextStyle(
                            color: plant.urgent ? Colors.red : Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text("심은 날짜 ${plant.date}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddScreen,
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
