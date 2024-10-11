import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/upload_image_view_model.dart';

class UploadImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UploadImageViewModel(),
      child: Consumer<UploadImageViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Anunciar mascotas'),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.mail_outline),
                  onPressed: () {},
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: viewModel.pickImage,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.blue[100],
                      child: viewModel.image == null
                          ? Center(child: Text('No image selected.'))
                          : Image.file(viewModel.image!, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: viewModel.isUploading ? null : viewModel.uploadImage,
                    child: viewModel.isUploading
                        ? CircularProgressIndicator()
                        : Text('Subir imagen'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF153D8A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  if (viewModel.responseData != null) ...[
                    const SizedBox(height: 20),
                    Text('Status: ${viewModel.responseData!.status}'),
                    Text('Especie: ${viewModel.responseData!.data['Especie']}'),
                    Text('Raza: ${viewModel.responseData!.data['Raza']}'),
                    Text('Edad: ${viewModel.responseData!.data['Edad aproximada']}'),
                    Text('Peso: ${viewModel.responseData!.data['Peso']}'),
                    Text('Color: ${viewModel.responseData!.data['Color']}'),
                    Text('Tamaño: ${viewModel.responseData!.data['Tamaño']}'),
                    Text('Image URL: ${viewModel.responseData!.imageUrl}'),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
