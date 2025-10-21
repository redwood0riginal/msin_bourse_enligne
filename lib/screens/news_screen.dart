import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/news.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;

  // Sample data for each section
  final List<MarketNews> _agendaItems = [];
  final List<MarketNews> _newsItems = [];
  final List<MarketNews> _publicationItems = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadSampleData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadSampleData() {
    // Agenda items
    _agendaItems.addAll([
      MarketNews(
        headline: 'Assemblée Générale Ordinaire - Attijariwafa Bank',
        linesOfText: [
          'Date: 25 Octobre 2025',
          'Heure: 10h00',
          'Lieu: Siège social, Casablanca',
        ],
        urgency: 'high',
        urlLink: 'https://example.com/agenda/1',
      ),
      MarketNews(
        headline: 'Publication des résultats trimestriels - Maroc Telecom',
        linesOfText: [
          'Date: 28 Octobre 2025',
          'Résultats du T3 2025',
        ],
        urgency: 'medium',
        urlLink: 'https://example.com/agenda/2',
      ),
      MarketNews(
        headline: 'Conseil d\'Administration - BCP',
        linesOfText: [
          'Date: 30 Octobre 2025',
          'Ordre du jour: Stratégie 2026',
        ],
        urgency: 'low',
        urlLink: 'https://example.com/agenda/3',
      ),
    ]);

    // News items
    _newsItems.addAll([
      MarketNews(
        headline: 'La Bourse de Casablanca clôture en hausse, le MASI gagne 0,93%',
        linesOfText: [
          'Le Marché Actions de Casablanca a terminé la séance en territoire positif.',
          'Les volumes d\'échanges ont atteint 850M MAD.',
          'Les valeurs bancaires ont tiré le marché vers le haut.',
        ],
        urgency: 'high',
        urlLink: 'https://example.com/news/1',
      ),
      MarketNews(
        headline: 'Attijariwafa Bank annonce des résultats record pour 2025',
        linesOfText: [
          'Le bénéfice net atteint 7,2 milliards de dirhams.',
          'Une croissance de 12% par rapport à l\'année précédente.',
          'Le conseil propose un dividende de 15 MAD par action.',
        ],
        urgency: 'high',
        urlLink: 'https://example.com/news/2',
      ),
      MarketNews(
        headline: 'Le secteur immobilier marocain en pleine expansion',
        linesOfText: [
          'Les ventes de logements ont augmenté de 18% au T3.',
          'Les prix restent stables dans les grandes villes.',
        ],
        urgency: 'medium',
        urlLink: 'https://example.com/news/3',
      ),
      MarketNews(
        headline: 'Maroc Telecom investit 2 milliards dans la 5G',
        linesOfText: [
          'Déploiement prévu dans 15 villes d\'ici fin 2025.',
          'Partenariat stratégique avec des équipementiers internationaux.',
        ],
        urgency: 'medium',
        urlLink: 'https://example.com/news/4',
      ),
    ]);

    // Publication items
    _publicationItems.addAll([
      MarketNews(
        headline: 'Rapport Annuel 2024 - Attijariwafa Bank',
        linesOfText: [
          'Document: Rapport_Annuel_2024.pdf',
          'Pages: 156',
          'Publié le: 15 Mars 2025',
        ],
        urgency: 'low',
        urlLink: 'https://example.com/publications/1',
      ),
      MarketNews(
        headline: 'États Financiers Consolidés - Maroc Telecom Q3 2025',
        linesOfText: [
          'Document: Etats_Financiers_Q3_2025.pdf',
          'Pages: 45',
          'Publié le: 10 Octobre 2025',
        ],
        urgency: 'low',
        urlLink: 'https://example.com/publications/2',
      ),
      MarketNews(
        headline: 'Guide de l\'investisseur - Bourse de Casablanca 2025',
        linesOfText: [
          'Document: Guide_Investisseur_2025.pdf',
          'Pages: 89',
          'Publié le: 5 Janvier 2025',
        ],
        urgency: 'low',
        urlLink: 'https://example.com/publications/3',
      ),
    ]);
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDarkMode ? AppColors.surfaceDark : AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Actualités',
          style: TextStyle(
            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDarkMode ? AppColors.borderDark : AppColors.borderLight,
                  width: 1,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              labelColor: AppColors.primary,
              unselectedLabelColor: isDarkMode
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'Agenda'),
                Tab(text: 'Actualités'),
                Tab(text: 'Publications'),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: AppColors.primary,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildNewsList(_agendaItems, isDarkMode, Icons.event_rounded),
            _buildNewsList(_newsItems, isDarkMode, Icons.article_rounded),
            _buildNewsList(_publicationItems, isDarkMode, Icons.description_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsList(List<MarketNews> items, bool isDarkMode, IconData icon) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    }

    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: isDarkMode
                  ? AppColors.textTertiaryDark
                  : AppColors.textTertiaryLight,
            ),
            const SizedBox(height: 24),
            Text(
              'Aucun élément',
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Les éléments seront affichés ici',
              style: TextStyle(
                color: isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildNewsItem(item, isDarkMode, icon);
      },
    );
  }

  Widget _buildNewsItem(MarketNews news, bool isDarkMode, IconData icon) {
    Color urgencyColor = AppColors.info;
    if (news.urgency == 'high') {
      urgencyColor = AppColors.error;
    } else if (news.urgency == 'medium') {
      urgencyColor = AppColors.warning;
    }

    return GestureDetector(
      onTap: () {
        _showNewsDetail(news, isDarkMode);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.cardDark : AppColors.cardLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDarkMode ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: urgencyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: urgencyColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    news.headline ?? 'Sans titre',
                    style: TextStyle(
                      color: isDarkMode
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: isDarkMode
                      ? AppColors.textTertiaryDark
                      : AppColors.textTertiaryLight,
                ),
              ],
            ),
            if (news.linesOfText != null && news.linesOfText!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppColors.backgroundDark
                      : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: news.linesOfText!
                      .take(3)
                      .map(
                        (line) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 6),
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  line,
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondaryLight,
                                    fontSize: 13,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showNewsDetail(MarketNews news, bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.surfaceDark : AppColors.backgroundLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? AppColors.textTertiaryDark
                    : AppColors.textTertiaryLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.headline ?? 'Sans titre',
                      style: TextStyle(
                        color: isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (news.linesOfText != null && news.linesOfText!.isNotEmpty)
                      ...news.linesOfText!.map(
                        (line) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            line,
                            style: TextStyle(
                              color: isDarkMode
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                              fontSize: 16,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ),
                    if (news.urlLink != null) ...[
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.link_rounded,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                news.urlLink!,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
