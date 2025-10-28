import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({super.key});

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {
  // Mock data de historias
  final List<_Story> _stories = [
    _Story(
      id: '1',
      title: 'Nueva Colección Primavera',
      description: 'Descubre las últimas tendencias de la temporada. Colores vibrantes y diseños únicos que te harán destacar.',
      imageUrl: 'https://picsum.photos/seed/story1/1080/1920',
      author: 'Kaiho Style',
      date: 'Hace 2 horas',
    ),
    _Story(
      id: '2',
      title: 'Tendencias 2024',
      description: 'Lo mejor de la moda este año. Estilo, comodidad y elegancia en cada prenda.',
      imageUrl: 'https://picsum.photos/seed/story2/1080/1920',
      author: 'Fashion Kaiho',
      date: 'Hace 5 horas',
    ),
    _Story(
      id: '3',
      title: 'Sostenibilidad en la Moda',
      description: 'Moda consciente y responsable. Cuidamos el planeta sin sacrificar el estilo.',
      imageUrl: 'https://picsum.photos/seed/story3/1080/1920',
      author: 'Kaiho Green',
      date: 'Hace 1 día',
    ),
    _Story(
      id: '4',
      title: 'Estilo Casual',
      description: 'Comodidad y estilo para el día a día. Perfectos para cualquier ocasión.',
      imageUrl: 'https://picsum.photos/seed/story4/1080/1920',
      author: 'Kaiho Casual',
      date: 'Hace 2 días',
    ),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Modo inmersivo pero respetando los gestos del sistema
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [],
    );
  }

  @override
  void dispose() {
    // Restaurar las barras del sistema al salir
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _stories.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return _StoryFullScreen(
            story: _stories[index],
            currentIndex: index,
            totalCount: _stories.length,
            onClose: () => Navigator.pop(context),
          );
        },
      ),
    );
  }
}

class _Story {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String author;
  final String date;

  _Story({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.author,
    required this.date,
  });
}

class _StoryFullScreen extends StatefulWidget {
  final _Story story;
  final int currentIndex;
  final int totalCount;
  final VoidCallback onClose;

  const _StoryFullScreen({
    required this.story,
    required this.currentIndex,
    required this.totalCount,
    required this.onClose,
  });

  @override
  State<_StoryFullScreen> createState() => _StoryFullScreenState();
}

class _StoryFullScreenState extends State<_StoryFullScreen> {
  bool _isLiked = false;
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Imagen/Video de fondo que ocupa toda la pantalla
        Image.network(
          widget.story.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[900],
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 80,
                  color: Colors.white54,
                ),
              ),
            );
          },
        ),

        // Gradiente oscuro en la parte superior e inferior
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.6),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.8),
                ],
                stops: const [0.0, 0.3, 0.6, 1.0],
              ),
            ),
          ),
        ),

        // Contenido superpuesto
        SafeArea(
          child: Column(
            children: [
              // Header con info del autor y botón cerrar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: const Color(0xFF00B4D8),
                      child: Text(
                        widget.story.author[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.story.author,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            widget.story.date,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      color: Colors.white,
                      onPressed: widget.onClose,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Barra lateral de acciones (derecha)
              Padding(
                padding: EdgeInsets.only(
                  right: 12,
                  bottom: 120 + MediaQuery.of(context).padding.bottom,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Like
                      _ActionButton(
                        icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                        color: _isLiked ? Colors.red : Colors.white,
                        label: '1.2K',
                        onTap: () {
                          setState(() {
                            _isLiked = !_isLiked;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      // Comentarios
                      _ActionButton(
                        icon: Icons.chat_bubble_outline,
                        color: Colors.white,
                        label: '234',
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                      // Compartir
                      _ActionButton(
                        icon: Icons.share_outlined,
                        color: Colors.white,
                        label: 'Compartir',
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                      // Guardar
                      _ActionButton(
                        icon: _isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: _isSaved ? const Color(0xFF00B4D8) : Colors.white,
                        label: '',
                        onTap: () {
                          setState(() {
                            _isSaved = !_isSaved;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Descripción en la parte inferior
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 16, 80, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.story.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.story.description,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Indicador de progreso
              if (widget.totalCount > 1)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.currentIndex + 1} / ${widget.totalCount}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

              // Espacio adicional para respetar la barra de navegación del sistema
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          if (label.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
