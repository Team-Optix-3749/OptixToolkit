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
        title: Center(
          child: Text(
            'Barcode Result',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              backgroundColor: Colors.blue  //Must fix
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Barcode Value: $barcodeValue',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            buildAttributeRow('Tool Name', inventory.name, context),
            buildAttributeRow('Tool Description', inventory.description, context),
            buildAttributeRow('Tool Status', inventory.status, context),
            buildAttributeRow('Tool Count', inventory.count.toString(), context),
            buildAttributeRow('Tool Location', inventory.location, context),
          ],
        ),
      ),
    );
  }

  Widget buildAttributeRow(String attributeName, String attributeValue, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$attributeName:',
          style: TextStyle(fontSize: 18),
        ),
        Row(
          children: [
            Text(
              attributeValue,
              style: TextStyle(fontSize: 18),
            ),
            TextButton(
              onPressed: () => _handleAttributeChange(context, attributeName, attributeValue),
              child: Text('Change'),
            ),
          ],
        ),
      ],
    );
  }

  void _handleAttributeChange(BuildContext context, String attributeName, String currentValue) async {
    TextEditingController newValueController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change $attributeName'),
          content: TextField(
            controller: newValueController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Enter new $attributeName'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newValue = newValueController.text.trim();
                if (newValue.isNotEmpty) {
                  // You can add logic here to update the attribute in the database or any other action
                  print('New $attributeName: $newValue');
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  print("Please enter a valid value");
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
