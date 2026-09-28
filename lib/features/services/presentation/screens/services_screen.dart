import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/providers/app_providers.dart';

class ServicesScreen extends ConsumerStatefulWidget {
  const ServicesScreen({super.key});

  @override
  ConsumerState<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends ConsumerState<ServicesScreen> {
  String _selectedCategory = 'all';
  String _searchQuery = '';

  final List<String> _categories = [
    'all',
    'نظافة',
    'واجهات',
    'صناعي',
    'مسابح',
    'مكافحة',
    'عزل',
    'صيانة',
    'عمالة',
    'تشغيل',
    'معدات',
    'مقاولات',
  ];

  @override
  Widget build(BuildContext context) {
    final services = ref.watch(servicesListProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filtered = services.where((s) {
      final matchesCategory = _selectedCategory == 'all' || s.category == _selectedCategory;
      final matchesQuery = _searchQuery.isEmpty ||
          s.title.contains(_searchQuery) ||
          s.shortDescription.contains(_searchQuery);
      return matchesCategory && matchesQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('دليل الخدمات والتشغيل'),
      ),
      body: Column(
        children: [
          // Search & Filter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: 'ابحث في الخدمات...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                border: OutlineInputBorder(
                  borderRadius: AppRadius.roundedMd,
                  borderSide: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),

          // Categories chips
          SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategory == cat;
                return ChoiceChip(
                  label: Text(cat == 'all' ? 'كافة الخدمات' : cat),
                  selected: isSelected,
                  selectedColor: AppColors.accentGreen,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  onSelected: (val) {
                    if (val) setState(() => _selectedCategory = cat);
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // List
          Expanded(
            child: filtered.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final srv = filtered[index];
                      return InkWell(
                        onTap: () => context.push('/service/${srv.id}'),
                        borderRadius: AppRadius.roundedLg,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.cardDark : AppColors.cardLight,
                            borderRadius: AppRadius.roundedLg,
                            border: Border.all(
                              color: isDark ? AppColors.borderDark : AppColors.borderLight,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.accentGreen.withOpacity(0.15),
                                      borderRadius: AppRadius.roundedSm,
                                    ),
                                    child: Text(
                                      srv.category,
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.accentGreen,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(srv.title, style: AppTypography.headlineMedium),
                              const SizedBox(height: 4),
                              Text(
                                srv.shortDescription,
                                style: AppTypography.bodyMedium.copyWith(
                                  color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('لم يتم العثور على خدمات مطابقة للبحث'),
                  ),
          ),
        ],
      ),
    );
  }
}
