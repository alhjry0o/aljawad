import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/services/presentation/screens/services_screen.dart';
import '../../features/services/presentation/screens/service_detail_screen.dart';
import '../../features/service_request/presentation/screens/service_request_screen.dart';
import '../../features/quotation/presentation/screens/quotation_request_screen.dart';
import '../../features/inspection/presentation/screens/inspection_request_screen.dart';
import '../../features/requests/presentation/screens/my_requests_screen.dart';
import '../../features/portfolio/presentation/screens/projects_screen.dart';
import '../../features/contact/presentation/screens/contact_screen.dart';
import '../../features/about/presentation/screens/about_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/developer/presentation/screens/developer_info_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/services',
        name: 'services',
        builder: (context, state) => const ServicesScreen(),
      ),
      GoRoute(
        path: '/service/:id',
        name: 'service_detail',
        builder: (context, state) {
          final serviceId = state.pathParameters['id'] ?? '';
          return ServiceDetailScreen(serviceId: serviceId);
        },
      ),
      GoRoute(
        path: '/service-request',
        name: 'service_request',
        builder: (context, state) {
          final initialServiceId = state.uri.queryParameters['serviceId'];
          return ServiceRequestScreen(initialServiceId: initialServiceId);
        },
      ),
      GoRoute(
        path: '/quotation-request',
        name: 'quotation_request',
        builder: (context, state) {
          final initialServiceId = state.uri.queryParameters['serviceId'];
          return QuotationRequestScreen(initialServiceId: initialServiceId);
        },
      ),
      GoRoute(
        path: '/inspection-request',
        name: 'inspection_request',
        builder: (context, state) {
          final initialServiceId = state.uri.queryParameters['serviceId'];
          return InspectionRequestScreen(initialServiceId: initialServiceId);
        },
      ),
      GoRoute(
        path: '/requests',
        name: 'requests',
        builder: (context, state) => const MyRequestsScreen(),
      ),
      GoRoute(
        path: '/projects',
        name: 'projects',
        builder: (context, state) => const ProjectsScreen(),
      ),
      GoRoute(
        path: '/contact',
        name: 'contact',
        builder: (context, state) => const ContactScreen(),
      ),
      GoRoute(
        path: '/about',
        name: 'about',
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/developer',
        name: 'developer',
        builder: (context, state) => const DeveloperInfoScreen(),
      ),
    ],
  );
}
