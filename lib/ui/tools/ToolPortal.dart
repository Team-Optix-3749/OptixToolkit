import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ToolsPage extends StatefulWidget {
  @override
  _ToolsPageState createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  List<dynamic> tools = []; // List to hold the tools data

  @override
  void initState() {
    super.initState();
    fetchTools(); // Fetch tools when the page loads
  }

  Future<void> fetchTools() async {
    final url = Uri.parse('https://your-backend-url.com/tools');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          tools = jsonDecode(response.body); // Update the list of tools
        });
      } else {
        print('Failed to load tools: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching tools: $e');
    }
  }

  Future<void> deleteTool(String toolId) async {
    final url = Uri.parse('https://your-backend-url.com/tools/$toolId');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        setState(() {
          tools.removeWhere((tool) => tool['id'] == toolId); // Remove the tool from the list
        });
        print('Tool deleted successfully');
      } else {
        print('Failed to delete tool: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting tool: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tools List'),
      ),
      body: tools.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching
          : ListView.builder(
              itemCount: tools.length,
              itemBuilder: (context, index) {
                final tool = tools[index];
                return ListTile(
                  title: Text(tool['name']),
                  subtitle: Text('ID: ${tool['id']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteTool(tool['id']), // Call deleteTool with the tool's ID
                  ),
                );
              },
            ),
    );
  }
}