// Dependencies
import 'package:get/get.dart';

class FeedController extends GetxController {
  var posts = [].obs;
  var isLoading = true.obs;
  var savedPosts = <int>{}.obs; // Set para manejar posts guardados por su ID.

  @override
  void onInit() {
    super.onInit();
    fetchPosts(); // Llamar a la función para cargar los posts.
  }

  // Simulamos los datos de los posts.
  Future<void> fetchPosts() async {
    try {
      isLoading(true);

      // Lista simulada de posts
      var postList = [
        {
          'id': 1,
          'userId': 1,
          'userPhoto': 'https://media.licdn.com/dms/image/v2/C4E03AQEp55lSR4WuIw/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1657679721882?e=2147483647&v=beta&t=JEDBdZmahqY1tiw1kWegxfx20OOG6QIDfUdtU3EBTiE',
          'userName': 'Estiven Hurtado',
          'typePost': 'missing',
          'imageUrl': 'https://media.ambito.com/p/7a9a5068b64700e970d5a55ecd90dfaa/adjuntos/239/imagenes/040/287/0040287673/730x0/smart/imagepng.png', // Imagen de post 1.
          'description': 'Se perdió Pinky en la zona de Palermo. Por favor, si alguien la ve, comunicarse al 123456789.',
          'timePosted': '28 minutes ago',
        },
        /*
        {
          'id': 2,
          'userId': 1,
          'userPhoto': 'https://media.ambito.com/p/7a9a5068b64700e970d5a55ecd90dfaa/adjuntos/239/imagenes/040/287/0040287673/730x0/smart/imagepng.png',
          'userName': 'Estiven Hurtado',
          'typePost': 'adoption',
          'imageUrl': 'https://instagram.flim39-1.fna.fbcdn.net/v/t51.29350-15/277159164_715532719866458_7063308023723645805_n.webp?stp=dst-jpg_e35&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3VybGdlbi4xMDgweDEzNTAuc2RyLmYyOTM1MC5kZWZhdWx0X2ltYWdlIn0&_nc_ht=instagram.flim39-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=AvrGD6nAoAcQ7kNvgHCcHil&_nc_gid=d981f239959f443c94e870c29b196bf2&edm=APoiHPcBAAAA&ccb=7-5&ig_cache_key=MjgwMTAzNTIzNjY0NzU3MDYwNw%3D%3D.3-ccb7-5&oh=00_AYAeCq1EhXR0YADJTw7FVE62uxa0hpIT6lzV2VkoAx3w4w&oe=672B0491&_nc_sid=22de04', // Imagen de post 1.
          'description': 'Doy en adopción a este perrito. Tiene 2 años y es muy juguetón.',
          'timePosted': '6 hours ago',
        },*/
        {
          'id': 3,
          'userId': 2,
          'userPhoto': 'https://media.licdn.com/dms/image/v2/D4E03AQEL-8AjvXhfYQ/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1722552583098?e=2147483647&v=beta&t=2EdLp5LdIIHouEsDi0Un0_EWXHhrDz5LnDh43BzK1wk',
          'userName': 'Akira Salvador',
          'typePost': 'adoption',
          'imageUrl': 'https://media.ambito.com/p/7a9a5068b64700e970d5a55ecd90dfaa/adjuntos/239/imagenes/040/287/0040287673/730x0/smart/imagepng.png', // Imagen de post 1.
          'description': 'Doy en adopción a este perrito. Tiene 2 años y es muy juguetón.',
          'timePosted': '6 hours ago',
        },
      ];

      posts.assignAll(postList);
    } finally {
      isLoading(false); // Indicamos que la carga ha terminado.
    }
  }

  // Alternar posts guardados
  void toggleSaved(int postId) {
    if (savedPosts.contains(postId)) {
      savedPosts.remove(postId);
    } else {
      savedPosts.add(postId);
    }
  }
}