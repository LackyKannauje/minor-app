import 'package:flutter/material.dart';
import 'package:minor_app/api/animal_api.dart';
import '../models/animal.dart';
import 'screens/add_animal_form.dart';

class AnimalListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Rescue Details'),
      ),
      body: FutureBuilder<List<Animal>>(
        future: fetchAnimals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No animals found'));
          } else {
            List<Animal> animals = snapshot.data!;

            return ListView.builder(
              itemCount: animals.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text(
                      animals[index].name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(animals[index].description),
                    leading: Icon(Icons.pets, size: 40),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAnimalForm()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
