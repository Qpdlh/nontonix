import 'package:flutter/material.dart';

void main() {
  runApp(const NontonixApp());
}

const _background = Color(0xFF0B1511);
const _surface = Color(0xFF17251F);
const _green = Color(0xFF39D98A);

class NontonixApp extends StatelessWidget {
  const NontonixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nontonix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _green,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class Movie {
  const Movie({
    required this.title,
    required this.genre,
    required this.year,
    required this.rating,
    required this.description,
    required this.imagePath,
    required this.color,
  });

  final String title;
  final String genre;
  final String year;
  final String rating;
  final String description;
  final String imagePath;
  final Color color;
}

const _movies = [
  Movie(
    title: 'Spider-Man: Into the Spider-Verse',
    genre: 'Action · Adventure',
    year: '2018',
    rating: '8.4',
    description:
        'Miles Morales menemukan kekuatan baru dan bertemu para Spider-Man dari semesta lain.',
    imagePath: 'assets/images/poster1.jpg',
    color: Color(0xFF312B62),
  ),
  Movie(
    title: "JoJo's Bizarre Adventure: Steel Ball Run",
    genre: 'Action · Adventure',
    year: '2026',
    rating: '8.8',
    description:
        'Johnny Joestar dan Gyro Zeppeli mengikuti balapan lintas Amerika yang penuh bahaya.',
    imagePath: 'assets/images/poster2.jpg',
    color: Color(0xFF5A3428),
  ),
  Movie(
    title: 'Godzilla Minus Zero',
    genre: 'Sci-Fi · Action',
    year: '2026',
    rating: '8.7',
    description:
        'Ancaman Godzilla kembali menguji keberanian dan harapan umat manusia.',
    imagePath: 'assets/images/poster3.png',
    color: Color(0xFF315444),
  ),
  Movie(
    title: 'Your Name',
    genre: 'Romance · Fantasy',
    year: '2016',
    rating: '8.4',
    description:
        'Dua remaja yang belum pernah bertemu terhubung melalui pertukaran tubuh yang misterius.',
    imagePath: 'assets/images/poster4.jpg',
    color: Color(0xFF38284D),
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.78);
  int _selectedMovie = 0;
  int _selectedCategory = 0;
  int _selectedTab = 0;
  bool _isSaved = false;

  static const _categories = ['Untukmu', 'Film', 'Serial', 'Koleksi'];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movie = _movies[_selectedMovie];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 16, 22, 0),
                child: _buildHeader(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 28, 22, 16),
                child: _buildCategories(),
              ),
            ),
            SliverToBoxAdapter(child: _buildMovieSlider()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: _buildMovieDetails(movie),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 34, 22, 14),
                child: _buildSectionTitle('Pilihan untukmu', 'Lihat semua'),
              ),
            ),
            SliverToBoxAdapter(child: _buildMovieRow()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 30, 22, 14),
                child: _buildSectionTitle('Sedang populer', 'Lihat semua'),
              ),
            ),
            SliverToBoxAdapter(
              child: _buildMovieRow(reverse: true),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: _green,
            borderRadius: BorderRadius.circular(11),
          ),
          child: const Icon(
            Icons.play_arrow_rounded,
            color: Color(0xFF0B1511),
            size: 25,
          ),
        ),
        const SizedBox(width: 9),
        const Text(
          'nontonix',
          style: TextStyle(
            color: Color(0xFFE6F4EC),
            fontSize: 21,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.cast_rounded, size: 22),
          tooltip: 'Hubungkan perangkat',
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search_rounded, size: 25),
          tooltip: 'Cari film',
        ),
        const SizedBox(width: 4),
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFF264235),
            borderRadius: BorderRadius.circular(11),
          ),
          child: const Icon(Icons.person_rounded, size: 21),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final selected = _selectedCategory == index;
          return ChoiceChip(
            label: Text(_categories[index]),
            selected: selected,
            onSelected: (_) => setState(() => _selectedCategory = index),
            showCheckmark: false,
            labelStyle: TextStyle(
              color: selected ? Colors.white : const Color(0xFFB7B7BE),
              fontSize: 13,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
            backgroundColor: _surface,
            selectedColor: const Color(0xFF245B40),
            side: BorderSide(
              color: selected ? _green : const Color(0xFF293B32),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMovieSlider() {
    return SizedBox(
      height: 390,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _movies.length,
        onPageChanged: (index) {
          setState(() {
            _selectedMovie = index;
            _isSaved = false;
          });
        },
        itemBuilder: (context, index) {
          final movie = _movies[index];
          return AnimatedPadding(
            duration: const Duration(milliseconds: 220),
            padding: EdgeInsets.symmetric(
              horizontal: 7,
              vertical: _selectedMovie == index ? 0 : 13,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _MovieImage(movie: movie),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.05),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.76),
                        ],
                        stops: const [0, 0.38, 1],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _green,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Text(
                        'PILIHAN FILM',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.genre.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10,
                            letterSpacing: 1.4,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFE2DDEB),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          movie.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 27,
                            height: 1.08,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFFFC857),
                              size: 17,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              movie.rating,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              movie.year,
                              style: const TextStyle(
                                color: Color(0xFFD8D4DD),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.hd_rounded,
                              color: Color(0xFFD8D4DD),
                              size: 18,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMovieDetails(Movie movie) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_movies.length, (index) {
            final selected = index == _selectedMovie;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: selected ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: selected ? _green : const Color(0xFF526159),
                borderRadius: BorderRadius.circular(5),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        Text(
          movie.description,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFFB8B8C0),
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow_rounded, size: 22),
                label: const Text(
                  'Putar',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => setState(() => _isSaved = !_isSaved),
                icon: Icon(
                  _isSaved ? Icons.check_rounded : Icons.add_rounded,
                  size: 20,
                ),
                label: Text(
                  _isSaved ? 'Tersimpan' : 'Daftar Saya',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF42434B)),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, String action) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            color: Color(0xFFB1B1B9),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(
          Icons.chevron_right_rounded,
          color: Color(0xFFB1B1B9),
          size: 17,
        ),
      ],
    );
  }

  Widget _buildMovieRow({bool reverse = false}) {
    final movies = reverse ? _movies.reversed.toList() : _movies;
    return SizedBox(
      height: 153,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return SizedBox(
            width: 112,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _MovieImage(movie: movie),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.75),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 8,
                          bottom: 7,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Color(0xFFFFC857),
                                size: 13,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                movie.rating,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigation() {
    const items = [
      (icon: Icons.home_rounded, label: 'Beranda'),
      (icon: Icons.explore_outlined, label: 'Jelajah'),
      (icon: Icons.video_library_outlined, label: 'Unduhan'),
      (icon: Icons.person_outline_rounded, label: 'Profil'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF101B16),
        border: Border(top: BorderSide(color: Color(0xFF26372E))),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 62,
          child: Row(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final selected = _selectedTab == index;
              return Expanded(
                child: InkWell(
                  onTap: () => setState(() => _selectedTab = index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.icon,
                        size: 21,
                        color: selected ? _green : const Color(0xFF9BA9A0),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 9,
                          color: selected
                              ? const Color(0xFFE6F4EC)
                              : const Color(0xFF9BA9A0),
                          fontWeight:
                              selected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _MovieImage extends StatelessWidget {
  const _MovieImage({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      movie.imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [movie.color, const Color(0xFF12131A)],
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.local_movies_outlined,
              color: Colors.white30,
              size: 42,
            ),
          ),
        );
      },
    );
  }
}
