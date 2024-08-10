import 'package:flutter/material.dart';
import 'package:vendoreventlia/view/screens/services/addservice.dart';
import 'package:vendoreventlia/view/screens/services/firestoreservice.dart';
import 'package:vendoreventlia/view/screens/services/servicemodel.dart';

class ServicesListScreen extends StatefulWidget {
  final String categoryId;
  final String vendorId;  // You need to use this field if it's relevant

  const ServicesListScreen({
    Key? key,
    required this.categoryId,
    required this.vendorId,
  }) : super(key: key);

  @override
  _ServicesListScreenState createState() => _ServicesListScreenState();
}

class _ServicesListScreenState extends State<ServicesListScreen> {
  late Future<List<ServiceItem>> _servicesFuture;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _servicesFuture = _firestoreService.fetchServices(widget.categoryId);
  }

  Future<void> _refreshServices() async {
    setState(() {
      _servicesFuture = _firestoreService.fetchServices(widget.categoryId);
    });
  }

  void _navigateToAddEditService(ServiceItem? service) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditServiceItemScreen(
          categoryId: widget.categoryId,
          service: service,
        ),
      ),
    );

    if (result == true) {
      _refreshServices();
    }
  }

  Future<void> _deleteService(String serviceId) async {
    try {
      await _firestoreService.deleteService(widget.categoryId, serviceId);
      _refreshServices();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error deleting service: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      ),
      body: FutureBuilder<List<ServiceItem>>(
        future: _servicesFuture,  // Use _servicesFuture
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No services available'));
          } else {
            final services = snapshot.data!;
            return ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];

                return ListTile(
                  leading: Image.network(
                    service.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);  // Placeholder icon for broken image
                    },
                  ),
                  title: Text(service.name),
                  subtitle: Text('Price: \$${service.price.toStringAsFixed(2)}'),
                  onTap: () => _navigateToAddEditService(service),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteService(service.id),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEditService(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
