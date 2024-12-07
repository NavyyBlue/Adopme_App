import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/presentation/screens/feed/feed_controller.dart';
import 'package:url_launcher/url_launcher.dart';


import 'dart:convert';  // Para convertir la respuesta JSON
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';



class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  var facebookData;
  var completeData;

  // Método para obtener datos de "noticias facebook"
  Future<void> fetchFacebookData() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/noticias/noticias_facebook/'));
      if (response.statusCode == 200) {
        setState(() {
          final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
          facebookData = decodedResponse;
        });
      } else {
        print('Error Facebook: ${response.statusCode}');
      }
    } catch (e) {
      print('Error Facebook: $e');
    }
  }

  // Método para obtener datos de "noticias completas"
  Future<void> fetchCompleteData() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/noticias/noticias_completas/'));
      if (response.statusCode == 200) {
        setState(() {
          final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
          completeData = decodedResponse;
        });
      } else {
        print('Error Completo: ${response.statusCode}');
      }
    } catch (e) {
      print('Error Completo: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFacebookData();
    fetchCompleteData();
  }

  Widget buildFacebookTab() {
    return Center(
      child: facebookData == null
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: facebookData['noticias'].length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    final url = facebookData['noticias'][index]['imagenURL'];
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'No se pudo abrir el enlace: $url';
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.all(15),
                    child: SizedBox(
                      child: Row(
                        children: [
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(facebookData['noticias'][index]['resu_noticia'],
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(facebookData['noticias'][index]['date_noticia']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget buildCompleteTab() {
    return Center(
      child: completeData == null
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: completeData['noticias'].length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    final url = completeData['noticias'][index]['link'];
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'No se pudo abrir el enlace: $url';
                    }
                  },
                  child: Card(
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              completeData['noticias'][index]['imagen'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(completeData['noticias'][index]['titulo'],
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(completeData['noticias'][index]['fecha'] +
                                    ' ' +
                                    completeData['noticias'][index]['hora']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('AdoptMe'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Noticias Facebook'),
              Tab(text: 'Noticias Diarios'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildFacebookTab(),
            buildCompleteTab(),
          ],
        ),
      ),
    );
  }
}


/*
// crea una clase FeedScreen que extiende un StatelessWidget
class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  // Esta variable almacenará los datos obtenidos de la API
  var data;

  // Método asíncrono para obtener los datos de la API
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/noticias/noticias_completas/'));
      if (response.statusCode == 200) {
        setState(() {
          // Decodifica el JSON y actualiza el estado
          final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
          data = decodedResponse;
        });
        //print('--------------------');
        //print(data); // Imprime la respuesta en consola
        //print('--------------------');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Llama a fetchData() cuando la pantalla se construye
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('AdoptMe'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          /*
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Acción para refrescar la lista si se desea.
              controller.fetchPosts();
            },
          ),
          */
        ],
      ),
      
      body: Center(
        child: data == null
            ? CircularProgressIndicator()  // Muestra un indicador de carga mientras los datos se obtienen
            : ListView.builder(
                itemCount: data['noticias'].length,
                itemBuilder: (context, index) {
                  /*
                  return ListTile(
                    contentPadding: EdgeInsets.all(12.0),  // Espaciado dentro del ListTile
                    title: Text(
                      data['noticias'][index]['titulo'],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),  // Estilo de texto del título
                    ),
                    subtitle: Text(
                      data['noticias'][index]['fecha'] + ' ' + data['noticias'][index]['hora'],
                      style: TextStyle(color: Colors.grey[700]),  // Estilo de texto para la fecha y hora
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),  // Esquinas redondeadas en la imagen
                      child: Image.network(
                        data['noticias'][index]['imagen'],
                        width: 50,  // Tamaño de la imagen
                        height: 50,
                        fit: BoxFit.cover,  // Ajustar imagen
                      ),
                    ),
                  );
                  */
                  return InkWell(
                    onTap: () async {
                      final url = data['noticias'][index]['link']; // Reemplaza con el enlace que deseas
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'No se pudo abrir el enlace: $url';
                      }
                    },
                    child: Card(
                      child: SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                data['noticias'][index]['imagen'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(data['noticias'][index]['titulo'],
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(data['noticias'][index]['fecha'] + ' ' + data['noticias'][index]['hora']),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                },
              ),
      ),
      
    );
  }
}
*/


/*
// crea una clase FeedScreen que extiende un StatelessWidget
class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}


class _FeedScreenState extends State<FeedScreen> {
  // Esta variable almacenará los datos obtenidos de la API
  var data;

  // Método asíncrono para obtener los datos de la API
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/noticias/noticias_facebook/'));
      if (response.statusCode == 200) {
        setState(() {
          // Decodifica el JSON y actualiza el estado
          final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
          data = decodedResponse;
        });
        //print('--------------------');
        //print(data); // Imprime la respuesta en consola
        //print('--------------------');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Llama a fetchData() cuando la pantalla se construye
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('AdoptMe'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          /*
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Acción para refrescar la lista si se desea.
              controller.fetchPosts();
            },
          ),
          */
        ],
      ),
      
      body: Center(
        child: data == null
            ? CircularProgressIndicator()  // Muestra un indicador de carga mientras los datos se obtienen
            : ListView.builder(
                itemCount: data['noticias'].length,
                itemBuilder: (context, index) {
                  /*
                  return ListTile(
                    contentPadding: EdgeInsets.all(12.0),  // Espaciado dentro del ListTile
                    title: Text(
                      data['noticias'][index]['titulo'],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),  // Estilo de texto del título
                    ),
                    subtitle: Text(
                      data['noticias'][index]['fecha'] + ' ' + data['noticias'][index]['hora'],
                      style: TextStyle(color: Colors.grey[700]),  // Estilo de texto para la fecha y hora
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),  // Esquinas redondeadas en la imagen
                      child: Image.network(
                        data['noticias'][index]['imagen'],
                        width: 50,  // Tamaño de la imagen
                        height: 50,
                        fit: BoxFit.cover,  // Ajustar imagen
                      ),
                    ),
                  );
                  */
                  return InkWell(
                    onTap: () async {
                      final url = data['noticias'][index]['imagenURL']; // Reemplaza con el enlace que deseas
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'No se pudo abrir el enlace: $url';
                      }
                    },
                    
                    child: Card(
                      // separar cada card por 15 pixeles
                      margin: EdgeInsets.all(15),
                      child: SizedBox(
                        //height: 100,
                        child: Row(
                          children: [
                            
                            /*
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                data['noticias'][index]['imagenURL'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            */
                            
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                
                                children: [
                                  Text(data['noticias'][index]['resu_noticia'],
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(data['noticias'][index]['date_noticia']),
                                ],
                                
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                },
              ),
      ),
      
    );
  }
}
*/


/*
class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedController>(
      init: FeedController(),
      builder: (controller) {
        return Scaffold(
          
          appBar: AppBar(
            title: Text('AdoptMe'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  // Acción para refrescar la lista si se desea.
                  controller.fetchPosts();
                },
              ),
            ],
          ),

          body: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.posts.isEmpty) {
              return Center(child: Text('No posts available.'));
            } else {

              return ListView.builder(
                itemCount: controller.posts.length,
                itemBuilder: (context, index) {
                  var post = controller.posts[index];
                  
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(post['userPhoto']),
                            ),
                            //title: Text(post['userName']),
                            //title: Text(post['userName'] + ' posted a ' + post['typePost'] + ' pet.'),
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${post['userName']} ', // Nombre del usuario en negrita
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black, // Color del texto en negrita
                                    ),
                                  ),
                                  if (post['typePost'] == 'missing')
                                    TextSpan(
                                      text: 'posted a missing pet.', // Texto de publicación de mascota perdida
                                      style: TextStyle(
                                        color: Colors.black, // Color del texto
                                      ),
                                    )
                                  else if (post['typePost'] == 'adoption')
                                    TextSpan(
                                      text: 'posted a pet for adoption.', // Texto de publicación de mascota en adopción
                                      style: TextStyle(
                                        color: Colors.black, // Color del texto
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            subtitle: Text(post['timePosted']),
                            trailing: IconButton(
                              // icono de guardar un post de red social, no de favorito
                              icon: Icon(controller.savedPosts.contains(post['id']) ? Icons.bookmark : Icons.bookmark_border),
                              onPressed: () {
                                controller.toggleSaved(post['id']);
                              },
                            ),
                          ),
                          Image.network(
                            post['imageUrl'],
                            // width y height para la imagen del post del mismo tamaño
                            height: 400,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(post['description']),
                          ),
                        ],
                      ),
                    ),
                  );
                  
                },
              );
              
            }
          }),
        );
      },
    );
  }
}
*/