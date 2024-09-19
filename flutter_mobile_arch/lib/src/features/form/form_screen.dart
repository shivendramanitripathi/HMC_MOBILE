import 'package:flutter/material.dart';
import 'package:flutter_mobile_arch/src/features/form/provider/visitor_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final visitorProvider = Provider.of<VisitorProvider>(context);

    final borderStyle = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black, width: 2.0),
      borderRadius: BorderRadius.circular(12),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: borderStyle,
                focusedBorder: borderStyle,
                enabledBorder: borderStyle,
                errorBorder: borderStyle.copyWith(
                  borderSide:
                      BorderSide(color: Colors.red.shade400, width: 2.0),
                ),
                focusedErrorBorder: borderStyle.copyWith(
                  borderSide:
                      BorderSide(color: Colors.red.shade400, width: 2.0),
                ),
              ),
              onChanged: (value) {
                visitorProvider.updateName(value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: borderStyle,
                focusedBorder: borderStyle,
                enabledBorder: borderStyle,
                errorBorder: borderStyle.copyWith(
                  borderSide:
                      BorderSide(color: Colors.red.shade400, width: 2.0),
                ),
                focusedErrorBorder: borderStyle.copyWith(
                  borderSide:
                      BorderSide(color: Colors.red.shade400, width: 2.0),
                ),
              ),
              onChanged: (value) {
                visitorProvider.updatePhoneNumber(value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              value: visitorProvider.purpose,
              items: const [
                DropdownMenuItem(value: 'Interview', child: Text('Interview')),
                DropdownMenuItem(
                    value: 'Maintenance', child: Text('Maintenance')),
                DropdownMenuItem(value: 'Delivery', child: Text('Delivery')),
              ],
              onChanged: (value) {
                visitorProvider.updatePurpose(value!);
              },
              decoration: InputDecoration(
                labelText: 'Purpose',
                border: borderStyle,
                focusedBorder: borderStyle,
                enabledBorder: borderStyle,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Visiting Date',
                border: borderStyle,
                focusedBorder: borderStyle,
                enabledBorder: borderStyle,
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  visitorProvider.updateVisitingDate(pickedDate);
                }
              },
              controller:
                  TextEditingController(text: visitorProvider.visitingDate),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                await visitorProvider.saveVisitor();
                GoRouter.of(context).go('/formScreen/formList');
              },
              child: Container(
                height: 50,
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Center(
                  child: Text(
                    "Generate Pass",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
