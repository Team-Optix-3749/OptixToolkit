import 'package:flutter/material.dart';
import 'package:OptixToolkit/services/database.dart';

class BarcodeResultPage extends StatelessWidget {
  final String barcodeValue;
  final Inventory inventory;

  const BarcodeResultPage({Key? key, required this.barcodeValue, required this.inventory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Barcode Value: $barcodeValue',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text( //name
              'Tool Name: ${inventory.name}',
              style: TextStyle(fontSize: 18),
            ),
            Text( //description
              'Tool Description: ${inventory.description}',
              style: TextStyle(fontSize: 18),
            ),
            Text(  //status
              'Tool Status: ${inventory.status}',
              style: TextStyle(fontSize: 18),
            ),
            Text( //count
              'Tool Count ${inventory.count}',
              style: TextStyle(fontSize: 18),
            ),
            Text( //location
              'Tool Location ${inventory.location}',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
