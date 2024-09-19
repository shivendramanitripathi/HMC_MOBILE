import 'package:flutter/material.dart';
import 'package:flutter_mobile_arch/src/features/form/provider/visitor_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class FromListScreen extends StatelessWidget {
  const FromListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final visitorProvider = Provider.of<VisitorProvider>(context);
    final visitors = visitorProvider.getAllVisitors();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form List'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go('/formScreen');
          },
        ),
      ),
      body: ListView.builder(
        itemCount: visitors.length,
        itemBuilder: (context, index) {
          final visitor = visitors[index];
          return Column(
            children: [
              Text("Name: ${visitor.name}"),
              Text(
                  'Purpose: ${visitor.purpose}, Date: ${visitor.visitingDate}'),
              QrImageView(
                data:
                    'Visitor: ${visitor.name}, Purpose: ${visitor.purpose}, Date: ${visitor.visitingDate}',
                size: 200,
                version: QrVersions.auto,
              ),
            ],
          );
        },
      ),
    );
  }
}
