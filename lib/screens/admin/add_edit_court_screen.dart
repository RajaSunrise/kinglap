import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/data_service.dart';
import '../../models/court.dart';

class AddEditCourtScreen extends StatefulWidget {
  final Court? court;

  const AddEditCourtScreen({super.key, this.court});

  @override
  State<AddEditCourtScreen> createState() => _AddEditCourtScreenState();
}

class _AddEditCourtScreenState extends State<AddEditCourtScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  late TextEditingController _featuresController; // Comma separated

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.court?.name ?? '');
    _locationController = TextEditingController(text: widget.court?.location ?? '');
    _priceController = TextEditingController(text: widget.court?.pricePerHour.toString() ?? '');
    _descriptionController = TextEditingController(text: widget.court?.description ?? '');
    _imageUrlController = TextEditingController(text: widget.court?.imageUrl ?? '');
    _featuresController = TextEditingController(text: widget.court?.features.join(', ') ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _featuresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataService = Provider.of<DataService>(context, listen: false);
    final isEditing = widget.court != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Lapangan' : 'Tambah Lapangan'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama Lapangan', border: OutlineInputBorder()),
              validator: (value) => value == null || value.isEmpty ? 'Nama wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Lokasi', border: OutlineInputBorder()),
              validator: (value) => value == null || value.isEmpty ? 'Lokasi wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Harga per Jam (Rp)', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Harga wajib diisi';
                if (int.tryParse(value) == null) return 'Harga harus berupa angka';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _imageUrlController,
              decoration: const InputDecoration(labelText: 'URL Gambar', border: OutlineInputBorder()),
              validator: (value) => value == null || value.isEmpty ? 'URL Gambar wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Deskripsi', border: OutlineInputBorder()),
              maxLines: 3,
              validator: (value) => value == null || value.isEmpty ? 'Deskripsi wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _featuresController,
              decoration: const InputDecoration(
                labelText: 'Fasilitas (pisahkan dengan koma)',
                border: OutlineInputBorder(),
                hintText: 'Indoor, AC, Parkir Luas',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final features = _featuresController.text
                      .split(',')
                      .map((e) => e.trim())
                      .where((e) => e.isNotEmpty)
                      .toList();

                  final court = Court(
                    id: isEditing ? widget.court!.id : DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _nameController.text,
                    location: _locationController.text,
                    rating: isEditing ? widget.court!.rating : 0.0, // Default rating 0 for new
                    pricePerHour: int.parse(_priceController.text),
                    imageUrl: _imageUrlController.text,
                    description: _descriptionController.text,
                    features: features,
                  );

                  if (isEditing) {
                    dataService.updateCourt(court);
                  } else {
                    dataService.addCourt(court);
                  }

                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(isEditing ? 'Simpan Perubahan' : 'Tambah Lapangan'),
            ),
          ],
        ),
      ),
    );
  }
}
