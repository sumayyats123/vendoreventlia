import 'package:flutter/material.dart';
import 'package:vendoreventlia/view/screens/services/servicemodel.dart';

class AddEditServiceItemScreen extends StatefulWidget {
  final String categoryId;
  final ServiceItem? service;

  const AddEditServiceItemScreen({Key? key, required this.categoryId, this.service}) : super(key: key);

  @override
  _AddEditServiceItemScreenState createState() => _AddEditServiceItemScreenState();
}

class _AddEditServiceItemScreenState extends State<AddEditServiceItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _imageUrlController; // New controller for imageUrl
  List<String> workImages = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.service?.name ?? '');
    _descriptionController = TextEditingController(text: widget.service?.description ?? '');
    _priceController = TextEditingController(text: widget.service?.price.toString() ?? '');
    _imageUrlController = TextEditingController(text: widget.service?.imageUrl ?? ''); // Initialize with imageUrl
    workImages = widget.service?.workImages ?? [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose(); // Dispose of controller
    super.dispose();
  }

  void _saveService() {
    if (_formKey.currentState!.validate()) {
      final newService = ServiceItem(
        id: widget.service?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        imageUrl: _imageUrlController.text, // Include imageUrl
        workImages: workImages,
      );

      // TODO: Save to Firestore or perform any other necessary actions
      Navigator.pop(context, true); // Indicate success
    }
  }

  void _addImage() {
    // TODO: Functionality to add a new image to workImages
  }

  void _removeImage(int index) {
    setState(() {
      workImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.service != null ? 'Edit Service' : 'Add Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Service Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a service name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Main Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text('Work Images'),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _addImage,
                    child: const Text('Add Image'),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: workImages.map((image) {
                          final index = workImages.indexOf(image);
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 8.0),
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => _removeImage(index),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveService,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
