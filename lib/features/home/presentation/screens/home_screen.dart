import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/providers/app_providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentBottomNavIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onBottomNavTapped(int index) {
    if (index == 0) return;
    if (index == 1) context.push('/services');
    if (index == 2) context.push('/requests');
    if (index == 3) context.push('/projects');
    if (index == 4) context.push('/settings');
  }

  @override
  Widget build(BuildContext context) {
    final services = ref.watch(servicesListProvider);
    final projects = ref.watch(projectsListProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.primaryNavy,
                borderRadius: AppRadius.roundedMd,
                border: Border.all(
                  color: AppColors.accentGreen.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                AppAssets.logo,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    'جـ',
                    style: TextStyle(
                      color: AppColors.accentGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppConstants.appDisplayName,
                  style: AppTypography.headlineMedium.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  AppConstants.companyAddress,
                  style: AppTypography.caption.copyWith(
                    color: isDark ? Colors.white60 : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone_in_talk_rounded, color: AppColors.accentGreen),
            tooltip: 'اتصال مباشر',
            onPressed: () => launchUrl(Uri.parse('tel:${AppConstants.phoneUnified}')),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'عن الشركة',
            onPressed: () => context.push('/about'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        onTap: _onBottomNavTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.accentGreen,
        unselectedItemColor: isDark ? Colors.white60 : Colors.black45,
        selectedLabelStyle: AppTypography.labelSmall,
        unselectedLabelStyle: AppTypography.caption,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'الخدمات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'طلباتي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center_outlined),
            label: 'مشاريعنا',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_rounded),
            label: 'المزيد',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 13. HERO SECTION - Single large, premium Hero Container
            _buildHeroContainer(context, isDark),

            const SizedBox(height: AppSpacing.lg),

            // Services Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'خدماتنا الرئيسية',
                  style: AppTypography.headlineLarge,
                ),
                TextButton(
                  onPressed: () => context.push('/services'),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('عرض الكل'),
                      Icon(Icons.chevron_left_rounded, size: 18),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.sm),

            // Services List Preview
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: services.take(4).length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final srv = services[index];
                return InkWell(
                  onTap: () => context.push('/service/${srv.id}'),
                  borderRadius: AppRadius.roundedLg,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.cardDark : AppColors.cardLight,
                      borderRadius: AppRadius.roundedLg,
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.accentGreen.withOpacity(0.12),
                            borderRadius: AppRadius.roundedMd,
                          ),
                          child: const Icon(
                            Icons.cleaning_services_rounded,
                            color: AppColors.accentGreen,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                srv.title,
                                style: AppTypography.labelLarge,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                srv.shortDescription,
                                style: AppTypography.caption,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_left_rounded,
                          color: AppColors.textMutedLight,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: AppSpacing.lg),

            // Free Inspection Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [AppColors.surfaceDark, AppColors.primaryNavyDark]
                      : [const Color(0xFFE8F5E9), const Color(0xFFC8E6C9)],
                ),
                borderRadius: AppRadius.roundedLg,
                border: Border.all(
                  color: AppColors.accentGreen.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.verified_rounded, color: AppColors.accentGreen, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        'خدمة المعاينة الميدانية المجانية',
                        style: AppTypography.labelLarge.copyWith(color: AppColors.accentGreen),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'هل ترغب في فحص ميداني شامل لمنشأتك أو عقارك؟',
                    style: AppTypography.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'يقوم مهندسونا المتخصصون بزيارة الموقع لتحديد نطاق العمل والتقرير الفني مجاناً.',
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context.push('/inspection-request'),
                    child: const Text('طلب معاينة فورية'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Why Aljawad (لماذا الجواد؟)
            Text(
              'لماذا الجواد؟',
              style: AppTypography.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            _buildWhyPillars(isDark),

            const SizedBox(height: AppSpacing.lg),

            // Featured Projects
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('مشاريعنا المنفذة', style: AppTypography.headlineLarge),
                    Text(
                      AppConstants.completedProjectsCount,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.accentGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => context.push('/projects'),
                  child: const Text('عرض المزيد'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ...projects.take(2).map((proj) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(proj.title, style: AppTypography.labelLarge),
                        const SizedBox(height: 4),
                        Text(proj.location, style: AppTypography.caption),
                        const SizedBox(height: 4),
                        Text(proj.shortDescription, style: AppTypography.bodyMedium),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroContainer(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryNavyDark,
        borderRadius: AppRadius.roundedXl,
        border: Border.all(color: Colors.white12),
        boxShadow: AppShadows.cardDark,
      ),
      child: Stack(
        children: [
          // Background Hero Image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: AppRadius.roundedXl,
              child: Image.asset(
                AppAssets.homeHero,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),
          ),

          // Multi-stage Dark Gradient Overlay ensuring 100% text readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: AppRadius.roundedXl,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryNavy.withOpacity(0.85),
                    AppColors.primaryNavyDark.withOpacity(0.96),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Headline
                Text(
                  AppConstants.mainHeadline,
                  style: AppTypography.displayMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  AppConstants.mainSubheadline,
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),

                // 15. Search Bar inside Hero Card
                TextField(
                  controller: _searchController,
                  onSubmitted: (query) {
                    if (query.isNotEmpty) {
                      context.push('/services?query=$query');
                    }
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'ماذا تحتاج؟',
                    hintStyle: const TextStyle(color: Colors.white54, fontSize: 13),
                    prefixIcon: const Icon(Icons.search, color: AppColors.accentGreen),
                    filled: true,
                    fillColor: Colors.black26,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: AppRadius.roundedMd,
                      borderSide: const BorderSide(color: Colors.white24),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: AppRadius.roundedMd,
                      borderSide: const BorderSide(color: Colors.white24),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: AppRadius.roundedMd,
                      borderSide: const BorderSide(color: AppColors.accentGreen, width: 1.5),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // 16. Two Hero Buttons inside the same Container
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => context.push('/service-request'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('اطلب خدمة'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.push('/quotation-request'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white60),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('طلب عرض سعر'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyPillars(bool isDark) {
    final pillars = [
      {'title': 'فرق متخصصة', 'desc': 'كوادر مؤهلة ومدربة بمعايير سلامة صارمة.'},
      {'title': 'حلول متكاملة', 'desc': 'خدمات تشغيل وصيانة شاملة تحت سقف واحد.'},
      {'title': 'معدات حديثة', 'desc': 'أحدث الرافعات وآليات النظافة الصناعية.'},
      {'title': 'خبرة كبرى', 'desc': 'إنجاز مئات المشاريع للشركات والمنشآت.'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: pillars.length,
      itemBuilder: (context, index) {
        final p = pillars[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardDark : AppColors.cardLight,
            borderRadius: AppRadius.roundedMd,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                p['title']!,
                style: AppTypography.labelLarge.copyWith(color: AppColors.accentGreen),
              ),
              const SizedBox(height: 2),
              Text(
                p['desc']!,
                style: AppTypography.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
