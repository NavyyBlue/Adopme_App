import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/presentation/screens/feed/feed_controller.dart';

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