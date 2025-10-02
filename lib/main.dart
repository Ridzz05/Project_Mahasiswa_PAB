// melakukan import package material.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/bottomnav.dart';
import 'components/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyek Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _titles = const ['Beranda', 'Jelajah', 'Agenda', 'Profil'];
  final List<String> _subtitles = const [
    'Selamat datang kembali, ayo cek aktivitas terbaru.',
    'Temukan informasi kampus yang kamu butuhkan.',
    'Lihat jadwal kegiatan dan deadline penting.',
    'Kelola informasi pribadi dan preferensi kamu.',
  ];

  int _selectedIndex = 0;

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(
        title: _titles[_selectedIndex],
        subtitle: _subtitles[_selectedIndex],
        onLeadingTap: () {},
        onActionTap: () {},
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _buildPageContent(_selectedIndex),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onItemSelected: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return _HomeSection(key: ValueKey(index));
      case 1:
        return _ExploreSection(key: ValueKey(index));
      case 2:
        return _AgendaSection(key: ValueKey(index));
      case 3:
      default:
        return _ProfileSection(key: ValueKey(index));
    }
  }
}

class _HomeSection extends StatelessWidget {
  const _HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final products = _demoProducts;
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return SafeArea(
      child: ColoredBox(
        color: surfaceColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            padding: const EdgeInsets.only(top: 20, bottom: 24),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.7,
              mainAxisSpacing: 20,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) => _ProductCard(
              product: products[index],
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}

class _ExploreSection extends StatelessWidget {
  const _ExploreSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cards = [
      _InfoCard(
        title: 'Pusat Informasi Akademik',
        description: 'Kumpulan panduan akademik, tata cara KRS, hingga kalender akademik terbaru.',
        icon: Icons.school_outlined,
      ),
      _InfoCard(
        title: 'Event Kampus',
        description: 'Tetap update dengan kegiatan kampus, seminar, dan diskusi yang sedang berlangsung.',
        icon: Icons.event_outlined,
      ),
      _InfoCard(
        title: 'Forum Mahasiswa',
        description: 'Berbagi pengetahuan dan berdiskusi dengan mahasiswa dari berbagai jurusan.',
        icon: Icons.forum_outlined,
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: cards.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: index == cards.length - 1 ? 0 : 16),
        child: cards[index],
      ),
    );
  }
}

class _AgendaSection extends StatelessWidget {
  const _AgendaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: 4,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final backgroundColor = index.isEven
            ? colorScheme.primaryContainer
            : colorScheme.secondaryContainer;
        final foregroundColor = index.isEven
            ? colorScheme.onPrimaryContainer
            : colorScheme.onSecondaryContainer;

        return Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: foregroundColor.withOpacity(0.1),
                foregroundColor: foregroundColor,
                child: const Icon(Icons.schedule_rounded),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kegiatan ${index + 1}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: foregroundColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Detail kegiatan dan lokasi pelaksanaan akan ditampilkan di sini.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: foregroundColor.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.chevron_right_rounded, color: foregroundColor),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: colorScheme.primaryContainer,
              child: Text(
                'RM',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ridzz Dev',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  'Teknik Informatika • Angkatan 2021',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text('Pengaturan Akun', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12),
        const _ProfileTile(
          icon: Icons.lock_outline,
          title: 'Keamanan dan Privasi',
          subtitle: 'Kelola kata sandi dan autentikasi dua faktor',
        ),
        const _ProfileTile(
          icon: Icons.notifications_outlined,
          title: 'Notifikasi',
          subtitle: 'Atur preferensi pemberitahuan aplikasi',
        ),
        const _ProfileTile(
          icon: Icons.help_outline,
          title: 'Pusat Bantuan',
          subtitle: 'Ajukan pertanyaan dan hubungi tim bantuan',
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.onPressed,
  });

  final _HomeProduct product;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.02,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF979797).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.images.first,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.title,
            style: theme.textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rp${product.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFF7643),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(6),
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    color: product.isFavourite
                        ? const Color(0xFFFF7643).withOpacity(0.15)
                        : const Color(0xFF979797).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.string(
                    _heartIconSvg,
                    colorFilter: ColorFilter.mode(
                      product.isFavourite
                          ? const Color(0xFFFF4848)
                          : const Color(0xFFDBDEE4),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HomeProduct {
  const _HomeProduct({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });

  final int id;
  final String title;
  final String description;
  final List<String> images;
  final List<Color> colors;
  final double rating;
  final double price;
  final bool isFavourite;
  final bool isPopular;
}

const List<_HomeProduct> _demoProducts = [
  _HomeProduct(
    id: 1,
    images: ['https://i.postimg.cc/c19zpJ6f/Image-Popular-Product-1.png'],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Wireless Controller for PS4™',
    price: 64.99,
    description: _productDescription,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  _HomeProduct(
    id: 2,
    images: ['https://i.postimg.cc/CxD6nH74/Image-Popular-Product-2.png'],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Nike Sport White - Man Pant',
    price: 50.5,
    description: _productDescription,
    rating: 4.1,
    isPopular: true,
  ),
  _HomeProduct(
    id: 3,
    images: ['https://i.postimg.cc/1XjYwvbv/glap.png'],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Gloves XC Omega - Polygon',
    price: 36.55,
    description: _productDescription,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  _HomeProduct(
    id: 4,
    images: ['https://i.postimg.cc/d1QWXMYW/Image-Popular-Product-3.png'],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Game Controller Limited Edition',
    price: 72.4,
    description: _productDescription,
    rating: 4.4,
    isPopular: true,
  ),
];

const String _heartIconSvg = '''<svg width="18" height="16" viewBox="0 0 18 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M16.5266 8.61383L9.27142 15.8877C9.12207 16.0374 8.87889 16.0374 8.72858 15.8877L1.47343 8.61383C0.523696 7.66069 0 6.39366 0 5.04505C0 3.69644 0.523696 2.42942 1.47343 1.47627C2.45572 0.492411 3.74438 0 5.03399 0C6.3236 0 7.61225 0.492411 8.59454 1.47627C8.81857 1.70088 9.18143 1.70088 9.40641 1.47627C11.3691 -0.491451 14.5629 -0.491451 16.5266 1.47627C17.4763 2.42846 18 3.69548 18 5.04505C18 6.39366 17.4763 7.66165 16.5266 8.61383Z" fill="#DBDEE4"/>
</svg>
''';

const String _productDescription =
    'Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …';

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceVariant,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(icon, color: colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
          foregroundColor: theme.colorScheme.primary,
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodySmall,
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: () {},
      ),
    );
  }
}
