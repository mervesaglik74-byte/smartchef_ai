import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const SmartChefApp());
}

class SmartChefApp extends StatelessWidget {
  const SmartChefApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dijital Mutfak Şefi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bg,
        fontFamily: 'Arial',
        useMaterial3: true,
      ),
      home: const SmartChefHome(),
    );
  }
}

class AppColors {
  static const bg = Color(0xFF060807);
  static const card = Color(0xFF111311);
  static const card2 = Color(0xFF171A17);
  static const green = Color(0xFF84F779);
  static const greenSoft = Color(0xFFB8FF9D);
  static const orange = Color(0xFFFF8A12);
  static const red = Color(0xFFFF6B6B);
  static const textMuted = Color(0xFF8E978E);
  static const border = Color(0xFF202420);
}

Future<void> openYoutube(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

void showDemoSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.card2,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}

/* =========================
   ANA KONTROL
========================= */

class SmartChefHome extends StatefulWidget {
  const SmartChefHome({super.key});

  @override
  State<SmartChefHome> createState() => _SmartChefHomeState();
}

class _SmartChefHomeState extends State<SmartChefHome> {
  int index = 0;
  Recipe currentRecipe = Recipe.somon();

  void createRecipe(String text) {
    final input = text.toLowerCase();

    if (input.contains('tavuk')) {
      currentRecipe = Recipe.tavuk();
    } else if (input.contains('makarna')) {
      currentRecipe = Recipe.makarna();
    } else if (input.contains('omlet') || input.contains('yumurta')) {
      currentRecipe = Recipe.omlet();
    } else {
      currentRecipe = Recipe.somon();
    }

    setState(() {
      index = 2;
    });
  }

  void selectRecipe(Recipe recipe) {
    setState(() {
      currentRecipe = recipe;
      index = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      ExplorePage(onStart: () => setState(() => index = 1)),
      ScanPage(onRecipe: createRecipe),
      RecipePage(recipe: currentRecipe, onSelectRecipe: selectRecipe),
      ShoppingListPage(recipe: currentRecipe),
      const ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: pages[index],
      bottomNavigationBar: PremiumBottomBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
      ),
    );
  }
}

/* =========================
   HEADER
========================= */

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.menu, color: AppColors.green, size: 18),
        const SizedBox(width: 10),
        const Expanded(
          child: GradientAppTitle(text: 'Dijital Mutfak Şefi'),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.green.withOpacity(.08),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.notifications,
            color: AppColors.green,
            size: 17,
          ),
        ),
      ],
    );
  }
}

class GradientAppTitle extends StatefulWidget {
  final String text;

  const GradientAppTitle({super.key, required this.text});

  @override
  State<GradientAppTitle> createState() => _GradientAppTitleState();
}

class _GradientAppTitleState extends State<GradientAppTitle>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                0.0,
                0.45 + (controller.value * 0.18),
                1.0,
              ],
              colors: const [
                AppColors.green,
                AppColors.greenSoft,
                AppColors.orange,
              ],
            ).createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            );
          },
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.5,
              fontWeight: FontWeight.w900,
              letterSpacing: .2,
            ),
          ),
        );
      },
    );
  }
}

/* =========================
   KEŞFET
========================= */

class ExplorePage extends StatelessWidget {
  final VoidCallback onStart;

  const ExplorePage({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
        children: [
          const TopBar(),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 17),
            decoration: premiumGradientBox(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MiniBadge(text: 'YAPAY ZEKA DESTEKLİ'),
                const SizedBox(height: 12),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Buzdolabında\n',
                        style: TextStyle(
                          fontSize: 25,
                          height: 1.02,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'ne var?',
                        style: TextStyle(
                          fontSize: 25,
                          height: 1.02,
                          fontWeight: FontWeight.w900,
                          color: AppColors.greenSoft,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 9),
                const Text(
                  'Malzemelerinizi anında tarayarak hedeflerinize uygun, şef elinden çıkmış kişiselleştirilmiş tariflere ulaşın.',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12.2,
                    height: 1.32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: SizedBox(
                    width: 214,
                    height: 45,
                    child: ElevatedButton.icon(
                      onPressed: onStart,
                      icon: const Icon(Icons.document_scanner_outlined, size: 18),
                      label: const Text('Malzemeleri Tara'),
                      style: premiumButton(AppColors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const HeroFridgeImage(),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const StatCard(
            icon: Icons.local_fire_department,
            title: 'GÜNLÜK TÜKETİM',
            value: '1.420',
            suffix: 'kcal',
            progress: 0.64,
            color: AppColors.orange,
            footer: '2.200 kcal hedefinizin %65’i',
          ),
          const StatCard(
            icon: Icons.water_drop,
            title: 'SU TÜKETİMİ',
            value: '1,8',
            suffix: 'litre',
            progress: 0.72,
            color: AppColors.green,
            footer: 'Bugün için 4 bardak kaldı',
          ),
          const SizedBox(height: 4),
          const AITipPanel(),
          const SizedBox(height: 22),
          sectionHeader(
            title: 'Size Özel Tarifler',
            subtitle: 'Beslenme profilinize göre şefler\ntarafından hazırlandı',
            action: 'Tümünü\ngör',
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 252,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                FoodCard(
                  title: 'Akdeniz Enerji Tabağı',
                  image: 'assets/images/mediterranean_bowl.png',
                  time: '15dk',
                  level: 'Kolay',
                  tag1: 'YÜKSEK PROTEİN',
                  tag2: 'KETO DOSTU',
                ),
                FoodCard(
                  title: 'Protein Omlet',
                  image: 'assets/images/omelette_plate.png',
                  time: '12dk',
                  level: 'Kolay',
                  tag1: 'PRATİK',
                  tag2: 'DOYURUCU',
                ),
                FoodCard(
                  title: 'Sebzeli Makarna',
                  image: 'assets/images/vegetable_pasta.png',
                  time: '20dk',
                  level: 'Kolay',
                  tag1: 'EKONOMİK',
                  tag2: 'SEBZE DOSTU',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Son Kullanma\nYaklaşanlar',
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.08,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                'STOK\nYÖNETİMİ',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                  height: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const ExpireItem(name: 'Organik Ispanak', date: '2 gün içinde tüketilmeli'),
          const ExpireItem(name: 'Süzme Yoğurt', date: 'Yarın son tüketim'),
        ],
      ),
    );
  }
}

/* =========================
   TARA
========================= */

class ScanPage extends StatefulWidget {
  final Function(String) onRecipe;

  const ScanPage({super.key, required this.onRecipe});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final controller = TextEditingController(text: 'somon, avokado, pirinç');

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 6),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
          margin: const EdgeInsets.fromLTRB(14, 0, 14, 18),
          padding: EdgeInsets.zero,
          content: const SmartSnackBar(),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
        children: [
          const TopBar(),
          const SizedBox(height: 22),
          const Text(
            'GÜNLÜK ALIM',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.8,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Odağını Besle.',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const SizedBox(height: 20),
          const DailyIntakeCard(),
          const SizedBox(height: 16),
          const OrangeAnalysisCard(),
          const SizedBox(height: 18),
          const Row(
            children: [
              MacroBox(title: 'PROTEİN', value: '112g', color: AppColors.green),
              SizedBox(width: 12),
              MacroBox(title: 'KARBONHİDRAT', value: '195g', color: AppColors.orange),
            ],
          ),
          const SizedBox(height: 12),
          const MacroBox(
            title: 'YAĞ',
            value: '54g',
            color: AppColors.orange,
            full: true,
          ),
          const SizedBox(height: 22),
          const Text(
            'Malzemelerini Yaz',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            minLines: 4,
            maxLines: 5,
            style: const TextStyle(fontWeight: FontWeight.w700),
            decoration: darkInput('Örn: somon, avokado, pirinç'),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () => widget.onRecipe(controller.text),
              style: premiumButton(AppColors.green, radius: 18),
              child: const Text(
                'Akşam Yemeği Planını Analiz Et',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Son Kayıtlar',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
              ),
              TextButton(
                onPressed: () {
                  showDemoSnack(
                    context,
                    'Son kayıtlar ekranı demo sürümünde yakında aktif olacak.',
                  );
                },
                child: const Text(
                  'Tümünü Gör',
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const RecentRecordCard(
            image: 'assets/images/mediterranean_bowl.png',
            badge: 'YAPAY ZEKA İLE\nANALİZ EDİLDİ',
            title: 'Akdeniz Gücü\nSalatası',
            subtitle: 'Öğle Yemeği · 13:15',
            kcal: '450',
            macro: '+18g\nProtein',
            macroColor: AppColors.orange,
          ),
          const RecentRecordCard(
            image: null,
            badge: 'MANUEL GİRİŞ',
            title: 'Yulaf Sütlü\nLatte',
            subtitle: 'Kahvaltı · 08:45',
            kcal: '120',
            macro: '+14g\nKarb',
            macroColor: AppColors.orange,
            icon: Icons.coffee,
          ),
          const RecentRecordCard(
            image: 'assets/images/vegetable_pasta.png',
            badge: 'YAPAY ZEKA İLE\nANALİZ EDİLDİ',
            title: 'Orman Meyveli\nSmoothie Kasesi',
            subtitle: 'Ara Öğün · 15:20',
            kcal: '380',
            macro: '+52g\nKarb',
            macroColor: AppColors.orange,
          ),
        ],
      ),
    );
  }
}

/* =========================
   TARİFLER
========================= */

class RecipePage extends StatelessWidget {
  final Recipe recipe;
  final ValueChanged<Recipe> onSelectRecipe;

  const RecipePage({
    super.key,
    required this.recipe,
    required this.onSelectRecipe,
  });

  @override
  Widget build(BuildContext context) {
    final suggested = Recipe.all().where((e) => e.title != recipe.title).toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
        children: [
          const TopBar(),
          const SizedBox(height: 18),
          RecipeHeroCard(recipe: recipe),
          const SizedBox(height: 16),
          AITipCard(text: recipe.tip),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 1.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              NutrientInfoCard(value: recipe.calorie, label: 'KALORİ', color: AppColors.green),
              NutrientInfoCard(value: recipe.protein, label: 'PROTEİN', color: AppColors.orange),
              NutrientInfoCard(value: recipe.carb, label: 'KARB', color: AppColors.orange),
              NutrientInfoCard(value: recipe.fat, label: 'YAĞ', color: Colors.white),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Malzeme\nTabağı',
                      style: TextStyle(
                        fontSize: 24,
                        height: 1,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Envanterinizi\nkontrol edin',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                        height: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDemoSnack(
                      context,
                      'Eksik malzemeler demo alışveriş listesine eklendi.',
                    );
                  },
                  icon: const Icon(Icons.playlist_add_check, size: 18),
                  label: const Text('Eksikleri\nListeye Ekle'),
                  style: premiumButton(AppColors.orange, radius: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 170,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recipe.ingredients.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                return IngredientCard(ingredient: recipe.ingredients[i]);
              },
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Hazırlanış Aşamaları',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 14),
          ...recipe.steps.asMap().entries.map(
                (entry) => StepTimelineTile(
              number: entry.key + 1,
              title: entry.value.title,
              text: entry.value.text,
              isLast: entry.key == recipe.steps.length - 1,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CookingGuidePage(recipe: recipe),
                  ),
                );
              },
              icon: const Icon(Icons.restaurant_menu),
              label: const Text('Adım Adım Pişirme Rehberi'),
              style: premiumButton(AppColors.green, radius: 16),
            ),
          ),
          const SizedBox(height: 26),
          const Text(
            'Önerilen Tarifler',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 190,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: suggested.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, i) {
                final item = suggested[i];
                return SuggestedRecipeCard(
                  recipe: item,
                  onTap: () => onSelectRecipe(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/* =========================
   PİŞİRME REHBERİ
========================= */

class CookingGuidePage extends StatelessWidget {
  final Recipe recipe;

  const CookingGuidePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final missing = recipe.ingredients.where((e) => !e.available).length;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 22),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: AppColors.green),
                ),
                const Expanded(child: GradientAppTitle(text: 'Pişirme Rehberi')),
                const Icon(Icons.timer_outlined, color: AppColors.green),
              ],
            ),
            const SizedBox(height: 14),
            CookingVideoPreview(recipe: recipe),
            const SizedBox(height: 18),
            Text(
              recipe.title,
              style: const TextStyle(
                fontSize: 27,
                height: 1.05,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Toplam süre yaklaşık ${recipe.totalTime}. Eksik malzeme: $missing. Adımları sırayla takip edersen tarifi rahatça çıkarırsın.',
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 13,
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => openYoutube(recipe.youtubeUrl),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: premiumBox(),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: AppColors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        recipe.videoTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.3,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const Icon(Icons.open_in_new, color: AppColors.green, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ön Hazırlık',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            PrepChecklist(items: recipe.prepItems),
            const SizedBox(height: 22),
            const Text(
              'Adım Adım Yapılış',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 14),
            ...recipe.guideSteps.asMap().entries.map(
                  (entry) => GuideStepBlock(
                number: entry.key + 1,
                step: entry.value,
                isLast: entry.key == recipe.guideSteps.length - 1,
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF101C12),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.green.withOpacity(.22)),
              ),
              child: Text(
                recipe.chefNote,
                style: const TextStyle(
                  color: AppColors.greenSoft,
                  fontSize: 13,
                  height: 1.45,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  showDemoSnack(
                    context,
                    'Afiyet olsun. Tarif tamamlandı olarak işaretlendi.',
                  );
                },
                icon: const Icon(Icons.check_circle),
                label: const Text('Tarifi Tamamladım'),
                style: premiumButton(AppColors.green, radius: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* =========================
   LİSTE
========================= */

class ShoppingListPage extends StatefulWidget {
  final Recipe recipe;

  const ShoppingListPage({super.key, required this.recipe});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  bool fabOpen = false;

  @override
  Widget build(BuildContext context) {
    final vegetableItems = [
      InventoryListItem(
        name: 'Organik Bebek Ispanak',
        label: 'TARİF İÇİN GEREKLİ',
        amount: '1 Büyük Paket',
        image: null,
        checked: false,
        ai: false,
      ),
      InventoryListItem(
        name: 'Kırmızı Soğan',
        label: 'ÖZEL',
        amount: '2 adet',
        image: null,
        checked: false,
        ai: false,
      ),
      InventoryListItem(
        name: 'Taze Zencefil Kökü',
        label: 'AI ÖNERİSİ',
        amount: 'Acılı Miso Ramen için',
        image: null,
        checked: true,
        ai: true,
      ),
    ];

    final pantryItems = [
      InventoryListItem(
        name: 'Kavrulmuş Susam Yağı',
        label: 'TARİF İÇİN GEREKLİ',
        amount: '1 Şişe',
        image: null,
        checked: false,
        ai: false,
      ),
      InventoryListItem(
        name: 'Miso Macunu',
        label: 'EKSİK MALZEME',
        amount: '1 küçük paket',
        image: null,
        checked: false,
        ai: true,
      ),
    ];

    return SafeArea(
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 118),
            children: [
              const TopBar(),
              const SizedBox(height: 18),
              const PremiumListHero(),
              const SizedBox(height: 18),
              const ListSearchBox(),
              const SizedBox(height: 12),
              const ListActionRow(),
              const SizedBox(height: 22),
              const ShoppingCategoryHeader(
                title: 'Sebze &\nMeyve',
                count: '4\nÖğe',
                action: 'Kategoriyi tamamlandı\nişaretle',
                color: AppColors.green,
              ),
              const SizedBox(height: 12),
              ...vegetableItems.map((item) => InventoryTile(item: item)),
              const SizedBox(height: 20),
              const ShoppingCategoryHeader(
                title: 'Kiler',
                count: '2 Öğe',
                action: '',
                color: AppColors.orange,
              ),
              const SizedBox(height: 12),
              ...pantryItems.map((item) => InventoryTile(item: item)),
              const SizedBox(height: 18),
              const StoreFindCard(),
              const SizedBox(height: 16),
              const EcoImpactCard(),
              const SizedBox(height: 16),
              const FamilySyncCard(),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 18,
            child: SmartAddButton(
              open: fabOpen,
              onTap: () {
                setState(() {
                  fabOpen = !fabOpen;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

/* =========================
   PROFİL
========================= */

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final badges = [
      ('7', 'Günlük seri'),
      ('24', 'Tarif'),
      ('3.8kg', 'İsraf önlendi'),
    ];

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 22),
        children: [
          const TopBar(),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: premiumGradientBox(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColors.green, AppColors.orange],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.green.withOpacity(.22),
                            blurRadius: 22,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.person, color: AppColors.bg, size: 40),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Merve Sağlık',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Dengeli beslenme modu aktif',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          MiniBadge(text: 'PREMIUM DEMO'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: badges.map((item) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.20),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.white.withOpacity(.05)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              item.$1,
                              style: const TextStyle(
                                color: AppColors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.$2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const ProfileGoalCard(),
          const SizedBox(height: 16),
          const ProfileMenuCard(
            icon: Icons.local_fire_department,
            title: 'Beslenme Hedefleri',
            subtitle: 'Kalori, protein ve su hedeflerini düzenle',
            accent: AppColors.orange,
          ),
          const ProfileMenuCard(
            icon: Icons.restaurant_menu,
            title: 'Favori Tarifler',
            subtitle: 'Kaydettiğin tarifleri ve haftalık planı görüntüle',
            accent: AppColors.green,
          ),
          const ProfileMenuCard(
            icon: Icons.inventory_2,
            title: 'Mutfak Envanteri',
            subtitle: 'Dolaptaki ürünleri, son kullanma tarihlerini yönet',
            accent: AppColors.greenSoft,
          ),
          const ProfileMenuCard(
            icon: Icons.family_restroom,
            title: 'Aile Senkronizasyonu',
            subtitle: 'Listeyi ev halkıyla ortak kullan',
            accent: AppColors.orange,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF101C12),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.green.withOpacity(.22)),
            ),
            child: const Row(
              children: [
                Icon(Icons.eco, color: AppColors.green),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Bu ay alışveriş planlamasıyla tahmini 3.8kg gıda israfını önlediniz.',
                    style: TextStyle(
                      color: AppColors.greenSoft,
                      fontSize: 13,
                      height: 1.35,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* =========================
   ALT MENÜ
========================= */

class PremiumBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PremiumBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      NavItem(Icons.explore_outlined, Icons.explore, 'KEŞFET'),
      NavItem(Icons.document_scanner_outlined, Icons.document_scanner, 'TARA'),
      NavItem(Icons.menu_book_outlined, Icons.menu_book, 'TARİFLER'),
      NavItem(Icons.shopping_cart_outlined, Icons.shopping_cart, 'LİSTE'),
      NavItem(Icons.person_outline, Icons.person, 'PROFİL'),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0B0D0B),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF1A1D1A)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.35),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (i) {
            final active = i == currentIndex;
            final item = items[i];

            return GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: active ? AppColors.green : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      active ? item.activeIcon : item.icon,
                      size: 20,
                      color: active ? AppColors.bg : Colors.white70,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        color: active ? AppColors.bg : Colors.white60,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  NavItem(this.icon, this.activeIcon, this.label);
}

/* =========================
   ORTAK WIDGETLAR
========================= */

class HeroFridgeImage extends StatelessWidget {
  const HeroFridgeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 138,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xFF111411),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.35),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/images/fridge_scan.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.58),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white.withOpacity(.08)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(radius: 4, backgroundColor: AppColors.green),
                SizedBox(width: 7),
                Text(
                  'GÖRÜNTÜLEME HAZIR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MiniBadge extends StatelessWidget {
  final String text;

  const MiniBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.green.withOpacity(.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.greenSoft,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: .7,
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String suffix;
  final double progress;
  final Color color;
  final String footer;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.suffix,
    required this.progress,
    required this.color,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: premiumBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withOpacity(.12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFB9C0B9),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  suffix,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFF293129),
            color: color,
            minHeight: 5,
            borderRadius: BorderRadius.circular(100),
          ),
          const SizedBox(height: 8),
          Text(
            footer,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class AITipPanel extends StatelessWidget {
  const AITipPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.orange.withOpacity(.20),
            const Color(0xFF1A1510),
            const Color(0xFF111311),
          ],
        ),
        border: Border.all(color: AppColors.orange.withOpacity(.22)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MiniBadge(text: 'YAPAY ZEKA ANALİZİ'),
          SizedBox(height: 10),
          Text(
            '"Bugün protein alımınız biraz düşük çıktı. Dolap taramanıza göre, ızgara somon salatası harika bir akşam yemeği tercihi olabilir."',
            style: TextStyle(
              color: Color(0xFFD8D0C5),
              fontSize: 12.5,
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Tüm detayları gör  →',
            style: TextStyle(
              color: AppColors.orange,
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final String title;
  final String image;
  final String time;
  final String level;
  final String tag1;
  final String tag2;

  const FoodCard({
    super.key,
    required this.title,
    required this.image,
    required this.time,
    required this.level,
    required this.tag1,
    required this.tag2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 228,
      margin: const EdgeInsets.only(right: 16),
      decoration: premiumBox(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 125,
                  width: double.infinity,
                  child: Image.asset(image, fit: BoxFit.cover),
                ),
                Positioned(
                  left: 12,
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.55),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.bolt, color: AppColors.green, size: 14),
                        SizedBox(width: 4),
                        Text(
                          '%98 Uyumlu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 11, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: AppColors.textMuted),
                      const SizedBox(width: 5),
                      Text(
                        time,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.bar_chart, size: 14, color: AppColors.textMuted),
                      const SizedBox(width: 5),
                      Text(
                        level,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      RecipeTag(text: tag1),
                      const SizedBox(width: 8),
                      RecipeTag(text: tag2),
                    ],
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

class RecipeTag extends StatelessWidget {
  final String text;

  const RecipeTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.055),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9.5,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class ExpireItem extends StatelessWidget {
  final String name;
  final String date;

  const ExpireItem({super.key, required this.name, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: premiumBox(),
      child: Row(
        children: [
          const Icon(Icons.eco, color: AppColors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 3),
                Text(
                  date,
                  style: const TextStyle(
                    color: AppColors.orange,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.more_horiz, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

/* =========================
   TARA WIDGET
========================= */

class SmartSnackBar extends StatelessWidget {
  const SmartSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF151B15),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.green.withOpacity(.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.green.withOpacity(.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, color: AppColors.green, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.4,
                  height: 1.28,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(text: 'Acıktın mı? Kalan 560 kcal hedefin için sana '),
                  TextSpan(
                    text: 'Somonlu ve Kuşkonmazlı Sote',
                    style: TextStyle(
                      color: AppColors.green,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(text: ' öneririm.'),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            icon: const Icon(Icons.close, color: AppColors.textMuted, size: 18),
          ),
        ],
      ),
    );
  }
}

class DailyIntakeCard extends StatelessWidget {
  const DailyIntakeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: premiumBox(),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1.640',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 2),
                Text(
                  '/ 2.200 kcal',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12),
                MiniBadge(text: '%75 TAMAMLANDI'),
              ],
            ),
          ),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.green.withOpacity(.24),
                  Colors.transparent,
                ],
              ),
              border: Border.all(color: AppColors.green, width: 6),
            ),
            child: const Icon(Icons.bolt, color: AppColors.green, size: 34),
          ),
        ],
      ),
    );
  }
}

class OrangeAnalysisCard extends StatelessWidget {
  const OrangeAnalysisCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFF9B22),
            Color(0xFFFF8A12),
            Color(0xFFE66B00),
          ],
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.restaurant, color: AppColors.bg),
          SizedBox(height: 12),
          Text(
            'YAPAY ZEKA ANALİZİ\nProtein İhtiyacı',
            style: TextStyle(
              color: AppColors.bg,
              fontWeight: FontWeight.w900,
              fontSize: 12,
              height: 1.15,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '"Bugün 24g protein eksik kaldın. Akşam yemeğine nohut veya süzme yoğurt eklemeyi düşünebilirsin."',
            style: TextStyle(
              color: AppColors.bg,
              fontSize: 13,
              height: 1.35,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class MacroBox extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final bool full;

  const MacroBox({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    this.full = false,
  });

  @override
  Widget build(BuildContext context) {
    final child = Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: color.withOpacity(.7), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: AppColors.textMuted, fontSize: 10)),
          const SizedBox(height: 18),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: .7,
            color: color,
            backgroundColor: const Color(0xFF2C332C),
          ),
        ],
      ),
    );

    if (full) return child;
    return Expanded(child: child);
  }
}

class RecentRecordCard extends StatelessWidget {
  final String? image;
  final String badge;
  final String title;
  final String subtitle;
  final String kcal;
  final String macro;
  final Color macroColor;
  final IconData? icon;

  const RecentRecordCard({
    super.key,
    required this.image,
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.kcal,
    required this.macro,
    required this.macroColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: premiumBox(),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: const Color(0xFF262926),
              borderRadius: BorderRadius.circular(18),
            ),
            child: image != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(image!, fit: BoxFit.cover),
            )
                : Icon(icon ?? Icons.restaurant, color: AppColors.textMuted, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  badge,
                  style: TextStyle(
                    color: badge.contains('YAPAY') ? AppColors.green : AppColors.textMuted,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .8,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15.5,
                    height: 1.08,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(kcal, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              const Text(
                'kcal',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                macro,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: macroColor,
                  fontSize: 10.5,
                  height: 1.05,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* =========================
   TARİF WIDGET
========================= */

class RecipeHeroCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeHeroCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 196,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        image: DecorationImage(
          image: AssetImage(recipe.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(.82),
              Colors.black.withOpacity(.15),
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MiniBadge(text: 'AKILLI ÖNERİ'),
                const SizedBox(height: 10),
                Text(
                  recipe.title,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  recipe.shortText,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.85),
                    fontSize: 12.7,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AITipCard extends StatelessWidget {
  final String text;

  const AITipCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: premiumBox(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: AppColors.green,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: AppColors.green.withOpacity(.5), blurRadius: 10),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI İPUCU',
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.45,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NutrientInfoCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const NutrientInfoCard({
    super.key,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: premiumBox(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 17.5,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class IngredientCard extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientCard({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: ingredient.available
              ? AppColors.green.withOpacity(.28)
              : AppColors.red.withOpacity(.28),
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 96,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                decoration: BoxDecoration(
                  color: AppColors.card2,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ingredient.image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(ingredient.image!, fit: BoxFit.cover),
                )
                    : Center(
                  child: Icon(
                    ingredient.available ? Icons.inventory_2 : Icons.close,
                    color: ingredient.available ? AppColors.green : AppColors.red,
                    size: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ingredient.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ingredient.stock,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: ingredient.available ? AppColors.green : AppColors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                ingredient.available ? Icons.check : Icons.close,
                size: 14,
                color: AppColors.bg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StepTimelineTile extends StatelessWidget {
  final int number;
  final String title;
  final String text;
  final bool isLast;

  const StepTimelineTile({
    super.key,
    required this.number,
    required this.title,
    required this.text,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return timelineShell(
      number: number,
      isLast: isLast,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
            const SizedBox(height: 6),
            Text(
              text,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 13,
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuggestedRecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  const SuggestedRecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 168,
        decoration: premiumBox(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Image.asset(recipe.image, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${recipe.calorie} kcal',
                      style: const TextStyle(
                        color: AppColors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* =========================
   PİŞİRME REHBERİ WIDGET
========================= */

class CookingVideoPreview extends StatelessWidget {
  final Recipe recipe;

  const CookingVideoPreview({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openYoutube(recipe.youtubeUrl),
      child: Container(
        height: 206,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          image: DecorationImage(
            image: AssetImage(recipe.image),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.38),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(.82),
                Colors.black.withOpacity(.10),
              ],
            ),
          ),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(.94),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.green.withOpacity(.35),
                      blurRadius: 28,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.bg,
                  size: 44,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.ondemand_video, color: AppColors.red, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      recipe.videoTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        height: 1.25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrepChecklist extends StatelessWidget {
  final List<String> items;

  const PrepChecklist({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: premiumBox(),
      child: Column(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: AppColors.green, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class GuideStepBlock extends StatelessWidget {
  final int number;
  final CookingGuideStep step;
  final bool isLast;

  const GuideStepBlock({
    super.key,
    required this.number,
    required this.step,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return timelineShell(
      number: number,
      isLast: isLast,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: premiumBox(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    step.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.green.withOpacity(.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    step.duration,
                    style: const TextStyle(
                      color: AppColors.green,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              step.detail,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 13,
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              step.temperature,
              style: const TextStyle(
                color: AppColors.orange,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* =========================
   LİSTE WIDGET
========================= */

class PremiumListHero extends StatelessWidget {
  const PremiumListHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: premiumGradientBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MiniBadge(text: 'AI AKILLI ÖNERİ'),
          const SizedBox(height: 12),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Acılı Miso Ramen\n',
                  style: TextStyle(
                    color: AppColors.orange,
                    fontSize: 23,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextSpan(
                  text: 'için hazır mısın?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Dijital Sous-Chef planladığın akşam yemeği için 4 eksik malzeme tespit etti. Listeyi mağaza reyonlarına göre düzenledi.',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 13,
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                height: 42,
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDemoSnack(
                      context,
                      'Eksik malzemeler alışveriş listesine eklendi.',
                    );
                  },
                  icon: const Icon(Icons.add_circle, size: 18),
                  label: const Text('Eksikleri Ekle'),
                  style: premiumButton(AppColors.green),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.05),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white.withOpacity(.06)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.schedule, color: AppColors.textMuted, size: 16),
                    SizedBox(width: 6),
                    Text(
                      '12 dk rota',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ListSearchBox extends StatelessWidget {
  const ListSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(decoration: darkInput('Listende ara...'));
  }
}

class ListActionRow extends StatelessWidget {
  const ListActionRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 46,
            child: ElevatedButton.icon(
              onPressed: () {
                showDemoSnack(
                  context,
                  'Online market entegrasyonu demo sürümünde yakında aktif olacak.',
                );
              },
              icon: const Icon(Icons.shopping_bag_outlined, size: 18),
              label: const Text('Instacart Hazır'),
              style: premiumButton(AppColors.orange, radius: 14),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 52,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: const Icon(Icons.tune, color: Colors.white),
        ),
      ],
    );
  }
}

class ShoppingCategoryHeader extends StatelessWidget {
  final String title;
  final String count;
  final String action;
  final Color color;

  const ShoppingCategoryHeader({
    super.key,
    required this.title,
    required this.count,
    required this.action,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              height: 1.08,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Text(
          count,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 12,
            height: 1.15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 14),
        if (action.isNotEmpty)
          Text(
            action,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: AppColors.green,
              fontSize: 11,
              height: 1.15,
              fontWeight: FontWeight.w900,
            ),
          ),
      ],
    );
  }
}

class InventoryListItem {
  final String name;
  final String label;
  final String amount;
  final String? image;
  final bool checked;
  final bool ai;

  InventoryListItem({
    required this.name,
    required this.label,
    required this.amount,
    required this.image,
    required this.checked,
    required this.ai,
  });
}

class InventoryTile extends StatefulWidget {
  final InventoryListItem item;

  const InventoryTile({super.key, required this.item});

  @override
  State<InventoryTile> createState() => _InventoryTileState();
}

class _InventoryTileState extends State<InventoryTile> {
  late bool checked;

  @override
  void initState() {
    super.initState();
    checked = widget.item.checked;
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: item.ai ? const Color(0xFF102016) : AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: item.ai ? AppColors.green.withOpacity(.28) : const Color(0xFF1D231D),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                checked = !checked;
              });
            },
            child: Icon(
              checked ? Icons.check_box : Icons.check_box_outline_blank,
              color: checked ? AppColors.green : AppColors.green.withOpacity(.8),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.green.withOpacity(.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        item.label,
                        style: const TextStyle(
                          color: AppColors.green,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.amount,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (item.ai)
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.green.withOpacity(.14),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.auto_awesome, color: AppColors.green, size: 18),
            ),
          const SizedBox(width: 8),
          if (item.ai)
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.check, color: AppColors.bg, size: 18),
            )
          else
            const Icon(Icons.delete_outline, color: AppColors.textMuted, size: 20),
        ],
      ),
    );
  }
}

class StoreFindCard extends StatelessWidget {
  const StoreFindCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: premiumBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.orange.withOpacity(.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.location_on, color: AppColors.orange, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Mağazada Bul',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Listeniz Whole Foods Market reyon düzenine göre optimize edildi.',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 12.5,
              height: 1.35,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            height: 126,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: const DecorationImage(
                image: AssetImage('assets/images/market_aisle.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(.72),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Expanded(
                    child: Text(
                      'Reyon 4: Sebze & Salatalar',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'GİT',
                      style: TextStyle(
                        color: AppColors.bg,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EcoImpactCard extends StatelessWidget {
  const EcoImpactCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF101C12),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.green.withOpacity(.22)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.eco, color: AppColors.green, size: 18),
              SizedBox(width: 8),
              Text(
                'Ekolojik Etki',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Önlenen Atık',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '1.2kg',
                style: TextStyle(
                  color: AppColors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: .78,
            backgroundColor: Color(0xFF263126),
            color: AppColors.green,
          ),
          SizedBox(height: 10),
          Text(
            'Sadece bu tarif için ihtiyacınız olanları alarak israfı %25 oranında azaltıyorsunuz.',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 11.5,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class FamilySyncCard extends StatelessWidget {
  const FamilySyncCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: premiumBox(),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aile Senkronizasyonu',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 14),
          Row(
            children: [
              CircleAvatar(radius: 13, backgroundColor: AppColors.orange),
              SizedBox(width: 4),
              CircleAvatar(radius: 13, backgroundColor: AppColors.green),
              SizedBox(width: 4),
              CircleAvatar(
                radius: 13,
                backgroundColor: Color(0xFF222822),
                child: Text(
                  '+2',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: AppColors.green,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'Sarah tarafından 15 dk önce güncellendi',
            style: TextStyle(color: AppColors.textMuted, fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}

class SmartAddButton extends StatelessWidget {
  final bool open;
  final VoidCallback onTap;

  const SmartAddButton({
    super.key,
    required this.open,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedScale(
          scale: open ? 1 : .85,
          duration: const Duration(milliseconds: 220),
          child: AnimatedOpacity(
            opacity: open ? 1 : 0,
            duration: const Duration(milliseconds: 220),
            child: open
                ? Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.green.withOpacity(.18)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.42),
                    blurRadius: 26,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  _FabMenuItem(icon: Icons.camera_alt, text: 'Ürünü Tara'),
                  SizedBox(height: 10),
                  _FabMenuItem(icon: Icons.edit_note, text: 'Elle Ekle'),
                  SizedBox(height: 10),
                  _FabMenuItem(icon: Icons.auto_awesome, text: 'AI Öner'),
                ],
              ),
            )
                : const SizedBox.shrink(),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: open
                    ? [AppColors.green, AppColors.greenSoft]
                    : [AppColors.orange, const Color(0xFFFFA53E)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: (open ? AppColors.green : AppColors.orange).withOpacity(.35),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: AnimatedRotation(
              turns: open ? .125 : 0,
              duration: const Duration(milliseconds: 220),
              child: Icon(
                open ? Icons.close : Icons.add,
                color: AppColors.bg,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FabMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FabMenuItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 116,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.045),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.green, size: 17),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

/* =========================
   PROFİL WIDGET
========================= */

class ProfileGoalCard extends StatelessWidget {
  const ProfileGoalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: premiumBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bugünkü Hedefler',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 14),
          goalRow('Kalori', '1.640 / 2.200 kcal', .74, AppColors.orange),
          const SizedBox(height: 13),
          goalRow('Protein', '112 / 120g', .86, AppColors.green),
          const SizedBox(height: 13),
          goalRow('Su', '1.8 / 2.5 litre', .68, AppColors.greenSoft),
        ],
      ),
    );
  }

  Widget goalRow(String title, String value, double progress, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          color: color,
          backgroundColor: const Color(0xFF273027),
          minHeight: 6,
          borderRadius: BorderRadius.circular(99),
        ),
      ],
    );
  }
}

class ProfileMenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  const ProfileMenuCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: premiumBox(),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: accent.withOpacity(.12),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: accent, size: 21),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11.8,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

/* =========================
   HELPERS
========================= */

Widget sectionHeader({
  required String title,
  required String subtitle,
  required String action,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                height: 1,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12.5,
                height: 1.25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      Builder(
        builder: (context) {
          return TextButton(
            onPressed: () {
              showDemoSnack(
                context,
                'Tüm tarifler ekranı demo sürümünde yakında aktif olacak.',
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(58, 34),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              action,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppColors.green,
                fontWeight: FontWeight.w900,
                fontSize: 13,
                height: 1.05,
              ),
            ),
          );
        },
      ),
    ],
  );
}

InputDecoration darkInput(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: AppColors.textMuted),
    prefixIcon: hint.contains('ara') ? const Icon(Icons.search, color: AppColors.textMuted) : null,
    filled: true,
    fillColor: AppColors.card,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: AppColors.green),
    ),
  );
}

ButtonStyle premiumButton(Color color, {double radius = 999}) {
  return ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: color,
    foregroundColor: AppColors.bg,
    shadowColor: color.withOpacity(.35),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    ),
    textStyle: const TextStyle(
      fontSize: 13,
      height: 1.1,
      fontWeight: FontWeight.w900,
    ),
  );
}

BoxDecoration premiumBox() {
  return BoxDecoration(
    color: AppColors.card,
    borderRadius: BorderRadius.circular(26),
    border: Border.all(color: const Color(0xFF1F241F), width: 1),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.32),
        blurRadius: 24,
        offset: const Offset(0, 10),
      ),
      BoxShadow(
        color: const Color(0xFF7AF36E).withOpacity(.04),
        blurRadius: 18,
        offset: const Offset(0, 0),
      ),
    ],
  );
}

BoxDecoration premiumGradientBox() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(28),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF151C15),
        Color(0xFF0E120E),
        Color(0xFF1A140D),
      ],
    ),
    border: Border.all(color: Color(0xFF20261F)),
    boxShadow: [
      BoxShadow(
        color: Colors.black54,
        blurRadius: 24,
        offset: Offset(0, 12),
      ),
    ],
  );
}

Widget timelineShell({
  required int number,
  required bool isLast,
  required Widget child,
}) {
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 44,
          child: Column(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: number == 1 ? AppColors.green : const Color(0xFF1A1D1A),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: number == 1 ? AppColors.green : const Color(0xFF313631),
                  ),
                ),
                child: Center(
                  child: Text(
                    '$number',
                    style: TextStyle(
                      color: number == 1 ? AppColors.bg : Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.4,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    color: const Color(0xFF242924),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: child),
      ],
    ),
  );
}

/* =========================
   DATA
========================= */

class Ingredient {
  final String name;
  final String stock;
  final String? image;
  final bool available;

  Ingredient({
    required this.name,
    required this.stock,
    required this.image,
    required this.available,
  });
}

class RecipeStep {
  final String title;
  final String text;

  RecipeStep(this.title, this.text);
}

class CookingGuideStep {
  final String title;
  final String detail;
  final String duration;
  final String temperature;

  CookingGuideStep({
    required this.title,
    required this.detail,
    required this.duration,
    required this.temperature,
  });
}

class Recipe {
  final String title;
  final String shortText;
  final String image;
  final String calorie;
  final String protein;
  final String carb;
  final String fat;
  final String tip;
  final String youtubeUrl;
  final String videoTitle;
  final String totalTime;
  final String chefNote;
  final List<String> prepItems;
  final List<Ingredient> ingredients;
  final List<RecipeStep> steps;
  final List<CookingGuideStep> guideSteps;

  Recipe({
    required this.title,
    required this.shortText,
    required this.image,
    required this.calorie,
    required this.protein,
    required this.carb,
    required this.fat,
    required this.tip,
    required this.youtubeUrl,
    required this.videoTitle,
    required this.totalTime,
    required this.chefNote,
    required this.prepItems,
    required this.ingredients,
    required this.steps,
    required this.guideSteps,
  });

  static List<Recipe> all() => [
    Recipe.somon(),
    Recipe.tavuk(),
    Recipe.makarna(),
    Recipe.omlet(),
  ];

  factory Recipe.somon() {
    return Recipe(
      title: 'Ballı Miso Soslu Somon Kasesi',
      shortText: 'Lezzetli somon, avokado, miso dokunuşu ve taze yeşilliklerin dengeli birleşimi.',
      image: 'assets/images/salmon_bowl.png',
      calorie: '542',
      protein: '42g',
      carb: '18g',
      fat: '22g',
      tip: 'Bu tarif, taranan malzemelerinizin %85’ini kullanıyor. Atıkları en aza indirmek için harika bir yol!',
      youtubeUrl: 'https://www.youtube.com/watch?v=fxlm65hdkAs',
      videoTitle: 'Somonlu Kase Tarifi - Protein dolu somon bowl',
      totalTime: '28–40 dk',
      chefNote: 'Şef notu: Somonu fazla pişirme. İç kısmı hafif nemli kalırsa kase daha lezzetli olur. Sosu en son eklemek aromayı güçlendirir.',
      prepItems: [
        'Somonu kağıt havluyla kurula. Islak yüzey tavada iyi mühürlenmez.',
        'Avokadoyu servis aşamasına yakın doğra, kararmasını önlemek için limonla hafifçe ov.',
        'Pirinç veya bulguru önceden haşlayıp sıcak tut.',
      ],
      ingredients: [
        Ingredient(name: 'Somon Fileto', stock: '250g stokta', image: 'assets/images/salmon_fillet.png', available: true),
        Ingredient(name: 'Avokado', stock: '1 adet stokta', image: 'assets/images/avocado.png', available: true),
        Ingredient(name: 'Miso Macunu', stock: 'Eksik malzeme', image: null, available: false),
        Ingredient(name: 'Kuşkonmaz', stock: 'Eksik malzeme', image: null, available: false),
      ],
      steps: [
        RecipeStep('Somonu Marine Edin', 'Miso, bal, soya sosu ve zencefili karıştırıp somonun üzerine sürün.'),
        RecipeStep('Tabanı Hazırlayın', 'Pirinç veya bulguru haşlayın. Avokadoyu dilimleyin, yeşillikleri yıkayın.'),
        RecipeStep('Mühürleyin ve Birleştirin', 'Somonu tavada pişirin. Tüm malzemeleri kaseye dengeli yerleştirin.'),
      ],
      guideSteps: [
        CookingGuideStep(
          title: 'Miso Sosunu Hazırla',
          detail: 'Bir kasede 1 yemek kaşığı miso, 1 tatlı kaşığı bal, 1 yemek kaşığı soya sosu, yarım çay kaşığı rendelenmiş zencefil ve birkaç damla limon suyunu karıştır. Sos koyuysa 1 tatlı kaşığı su ekleyip akışkan hale getir.',
          duration: '3 dk',
          temperature: 'Soğuk hazırlık',
        ),
        CookingGuideStep(
          title: 'Somonu Marine Et',
          detail: 'Somon filetoları kurulayıp sosun yarısıyla kapla. En az 15 dakika beklet. Vaktin varsa 30 dakika buzdolabında bekletmek lezzeti artırır.',
          duration: '15–30 dk',
          temperature: 'Buzdolabı',
        ),
        CookingGuideStep(
          title: 'Somonu Pişir',
          detail: 'Tavayı orta-yüksek ateşte ısıt. Çok az yağ ekle. Somonu önce derili tarafı alta gelecek şekilde 3–4 dakika pişir. Çevirip diğer tarafı 2–3 dakika pişir. Sos şekerli olduğu için yakmamaya dikkat et.',
          duration: '6–8 dk',
          temperature: 'Orta-yüksek ateş',
        ),
        CookingGuideStep(
          title: 'Kaseyi Kur',
          detail: 'Tabana pirinci koy. Yanına avokado, yeşillik ve kuşkonmaz ekle. Somonu üstüne yerleştir. Kalan sostan az gezdir, susam veya yeşil soğanla bitir.',
          duration: '4 dk',
          temperature: 'Servis',
        ),
      ],
    );
  }

  factory Recipe.tavuk() {
    return Recipe(
      title: 'Akdeniz Gücü Salatası',
      shortText: 'Izgara tavuk, avokado, yumurta ve taze yeşilliklerle yüksek proteinli hafif bir tabak.',
      image: 'assets/images/mediterranean_bowl.png',
      calorie: '450',
      protein: '38g',
      carb: '16g',
      fat: '20g',
      tip: 'Bugünkü protein hedefini tamamlamak için bu tarif oldukça güçlü bir seçim.',
      youtubeUrl: 'https://www.youtube.com/watch?v=f_NzhZVN0BY',
      videoTitle: 'Tavuklu Akdeniz salata nasıl yapılır?',
      totalTime: '20–25 dk',
      chefNote: 'Şef notu: Tavuğu dinlendirmeden kesme. 3 dakika bekletirsen suyu içinde kalır ve daha yumuşak olur.',
      prepItems: [
        'Tavuğu ince dilimle, böylece daha hızlı ve dengeli pişer.',
        'Yeşillikleri yıka ve tamamen süz. Islak yeşillik sosu sulandırır.',
        'Avokado ve yumurtayı servis aşamasında ekle.',
      ],
      ingredients: [
        Ingredient(name: 'Izgara Tavuk', stock: '200g stokta', image: 'assets/images/mediterranean_bowl.png', available: true),
        Ingredient(name: 'Avokado', stock: '1 adet stokta', image: 'assets/images/avocado.png', available: true),
        Ingredient(name: 'Roka', stock: 'Eksik malzeme', image: null, available: false),
        Ingredient(name: 'Haşlanmış Yumurta', stock: 'Eksik malzeme', image: null, available: false),
      ],
      steps: [
        RecipeStep('Tavuğu Hazırlayın', 'Tavuğu baharatlayıp tavada veya ızgarada pişirin.'),
        RecipeStep('Tabanı Kurun', 'Yeşillikleri tabağa alın. Avokado ve yumurtayı dilimleyin.'),
        RecipeStep('Sunum Yapın', 'Tavuğu dilimleyip tabağa ekleyin. Zeytinyağı ve limonla servis edin.'),
      ],
      guideSteps: [
        CookingGuideStep(
          title: 'Tavuğu Marine Et',
          detail: 'Tavuğu zeytinyağı, limon, tuz, karabiber, kekik ve az sarımsakla karıştır. En az 10 dakika beklet. Vaktin varsa 30 dakika bekletmek daha iyi sonuç verir.',
          duration: '10–30 dk',
          temperature: 'Soğuk hazırlık',
        ),
        CookingGuideStep(
          title: 'Tavuğu Pişir',
          detail: 'Tavayı iyice ısıt. Tavuğu tavaya al ve her yüzünü 4–5 dakika pişir. İç kısmı tamamen beyazlaşmalı. Çok sık çevirmemeye dikkat et.',
          duration: '8–10 dk',
          temperature: 'Orta-yüksek ateş',
        ),
        CookingGuideStep(
          title: 'Salatayı Kur',
          detail: 'Roka, marul, soğan ve avokadoyu tabağa al. Üzerine dilimlenmiş tavuğu koy. Zeytinyağı, limon ve az tuzla servis et.',
          duration: '5 dk',
          temperature: 'Servis',
        ),
      ],
    );
  }

  factory Recipe.makarna() {
    return Recipe(
      title: 'Sebzeli Makarna',
      shortText: 'Renkli sebzelerle hazırlanan pratik, ekonomik ve doyurucu bir öğün.',
      image: 'assets/images/vegetable_pasta.png',
      calorie: '510',
      protein: '18g',
      carb: '72g',
      fat: '16g',
      tip: 'Sebzeleri değerlendirmek ve hızlı bir akşam yemeği çıkarmak için iyi bir seçenek.',
      youtubeUrl: 'https://www.youtube.com/watch?v=FkTUB_dFVag',
      videoTitle: '10 Dakikada Çok Kolay Sebzeli Makarna Tarifi',
      totalTime: '15–18 dk',
      chefNote: 'Şef notu: Makarnayı süzdükten sonra sosla 1–2 dakika birlikte çevir. Bu, sosun makarnaya daha iyi tutunmasını sağlar.',
      prepItems: [
        'Sebzeleri küçük ve benzer boyutta doğra.',
        'Makarnayı haşlarken suyuna yeterli tuz ekle.',
        'Sostan önce sarımsak ve soğanı yakmadan çevir.',
      ],
      ingredients: [
        Ingredient(name: 'Makarna', stock: '1 paket stokta', image: 'assets/images/vegetable_pasta.png', available: true),
        Ingredient(name: 'Domates', stock: '2 adet stokta', image: null, available: true),
        Ingredient(name: 'Biber', stock: 'Eksik malzeme', image: null, available: false),
        Ingredient(name: 'Parmesan', stock: 'Eksik malzeme', image: null, available: false),
      ],
      steps: [
        RecipeStep('Makarnayı Haşlayın', 'Makarnayı tuzlu kaynar suda diri kıvamda haşlayın.'),
        RecipeStep('Sebzeleri Soteleyin', 'Domates, biber ve diğer sebzeleri tavada çevirin.'),
        RecipeStep('Karıştırıp Servis Edin', 'Makarnayı sebzelerle birleştirip servis edin.'),
      ],
      guideSteps: [
        CookingGuideStep(
          title: 'Makarnayı Haşla',
          detail: 'Tencereye bol su koy ve kaynat. Su kaynayınca tuz ekle. Makarnayı pakette yazan süreden 1 dakika kısa haşla; sosla birleşirken pişmeye devam edecek.',
          duration: '8–10 dk',
          temperature: 'Kaynar su',
        ),
        CookingGuideStep(
          title: 'Sebzeleri Sotele',
          detail: 'Tavaya zeytinyağı koy. Soğan ve sarımsağı 1 dakika çevir. Ardından biber, domates ve varsa kabak ekle. Sebzeler hafif yumuşayana kadar pişir.',
          duration: '6–7 dk',
          temperature: 'Orta ateş',
        ),
        CookingGuideStep(
          title: 'Sosu Bağla',
          detail: 'Makarnayı süzmeden önce yarım çay bardağı makarna suyu ayır. Makarnayı sebzelerin üzerine al, ayırdığın sudan ekle ve 1–2 dakika karıştır.',
          duration: '2 dk',
          temperature: 'Kısık ateş',
        ),
      ],
    );
  }

  factory Recipe.omlet() {
    return Recipe(
      title: 'Protein Omlet',
      shortText: 'Yumurta, sebze ve hafif eşlikçilerle hazırlanan hızlı ve doyurucu bir kahvaltı.',
      image: 'assets/images/omelette_plate.png',
      calorie: '420',
      protein: '22g',
      carb: '34g',
      fat: '18g',
      tip: 'Kahvaltı veya hafif akşam öğünü için kısa sürede hazırlanabilir.',
      youtubeUrl: 'https://www.youtube.com/watch?v=gmJpuPYCOds',
      videoTitle: 'Sporcu Omleti - 23 Gram Protein',
      totalTime: '8–10 dk',
      chefNote: 'Şef notu: Omleti yüksek ateşte pişirme. Kısık-orta ateş daha yumuşak ve düzgün sonuç verir.',
      prepItems: [
        'Yumurtaları çırpmadan önce oda sıcaklığına yakın olursa daha iyi kabarır.',
        'Tavayı fazla yağlama; ince bir tabaka yeterli.',
        'Peyniri en son ekle, böylece yanmadan erir.',
      ],
      ingredients: [
        Ingredient(name: 'Yumurta', stock: '2 adet stokta', image: 'assets/images/omelette_plate.png', available: true),
        Ingredient(name: 'Avokado', stock: '1 adet stokta', image: 'assets/images/avocado.png', available: true),
        Ingredient(name: 'Kaşar Peyniri', stock: 'Eksik malzeme', image: null, available: false),
        Ingredient(name: 'Domates', stock: 'Eksik malzeme', image: null, available: false),
      ],
      steps: [
        RecipeStep('Yumurtayı Hazırlayın', 'Yumurtaları çırpıp tuz ve karabiber ekleyin.'),
        RecipeStep('Pişirin', 'Tavaya döküp kısık ateşte pişirin.'),
        RecipeStep('Servis Edin', 'Avokado ve domates ile servis edin.'),
      ],
      guideSteps: [
        CookingGuideStep(
          title: 'Karışımı Hazırla',
          detail: 'Yumurtaları kaseye kır. Tuz, karabiber ve istersen 1 yemek kaşığı süt ekle. Çatal veya çırpıcıyla 30–40 saniye çırp.',
          duration: '2 dk',
          temperature: 'Soğuk hazırlık',
        ),
        CookingGuideStep(
          title: 'Tavada Pişir',
          detail: 'Tavayı kısık-orta ateşte ısıt. Az yağ ekle. Yumurtayı dök ve kenarları toparlanana kadar bekle. Spatula ile kenarları hafifçe içeri al.',
          duration: '4–5 dk',
          temperature: 'Kısık-orta ateş',
        ),
        CookingGuideStep(
          title: 'Katla ve Servis Et',
          detail: 'Peynir veya yeşillik ekle. Omleti ikiye katla. Avokado ve domatesle sıcak servis et.',
          duration: '2 dk',
          temperature: 'Servis',
        ),
      ],
    );
  }
}