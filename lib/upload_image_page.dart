import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:image/image.dart' as img;

class UploadImagePage extends StatefulWidget {
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  File? _image;
  bool _isUploading = false;
  Map<String, dynamic>? _responseData; // Para almacenar la respuesta de la API

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage(File image) async {
    setState(() {
      _isUploading = true;
    });

    final url = 'http://192.168.1.11:3000/r2/upload'; // URL de tu API en NestJS

    // Leer los bytes de la imagen
    final bytes = await image.readAsBytes();

    // Comprimir la imagen
    img.Image? originalImage = img.decodeImage(bytes);
    img.Image resizedImage = img.copyResize(originalImage!, width: 800); // Cambia el ancho según sea necesario

    // Obtener los bytes de la imagen comprimida
    final compressedBytes = img.encodeJpg(resizedImage, quality: 85); // Ajusta la calidad según sea necesario
    final base64Image = base64Encode(compressedBytes);

    // Crear un objeto JSON con el nombre y los bytes de la imagen
    final data = jsonEncode({
      'filename': image.path.split('/').last, // Nombre de la imagen
      'file': base64Image, // Imagen en formato Base64
    });

    // Realizar la petición POST
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: data,
    );

    setState(() {
      _isUploading = false;
    });

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      print('Upload successful: $jsonResponse');

      // Guardar la respuesta para mostrarla
      setState(() {
        _responseData = jsonResponse; // Almacenar la respuesta
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload successful')));
    } else {
      print('Upload failed: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image to NestJS API'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: _image == null || _isUploading ? null : () => _uploadImage(_image!),
              child: _isUploading ? CircularProgressIndicator() : Text('Upload Image'),
            ),
            // Mostrar los datos de la respuesta
            if (_responseData != null) ...[
              SizedBox(height: 20),
              Text('Status: ${_responseData!['status']}'),
              Text('Especie: ${_responseData!['data']['Especie']}'),
              Text('Raza: ${_responseData!['data']['Raza']}'),
              Text('Edad: ${_responseData!['data']['Edad aproximada']}'),
              Text('Peso: ${_responseData!['data']['Peso']}'),
              Text('Color: ${_responseData!['data']['Color']}'),
              Text('Tamaño: ${_responseData!['data']['Tamaño']}'),
              Text('Image URL: ${_responseData!['imageUrl']}'),
            ],
          ],
        ),
      ),
    );
  }
}
