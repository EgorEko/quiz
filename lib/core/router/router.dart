import 'package:go_router/go_router.dart';

import '../../features/history/screens/history_screen.dart';
import '../../features/quiz/presentation/screens/quiz_screen.dart';
import '../../features/result/screens/result_screen.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.history.path,
  routes: [
    GoRoute(
      path: AppRoutes.history.path,
      builder: (context, state) => const HistoryScreen(),
    ),
    GoRoute(
      path: AppRoutes.quiz.path,
      builder: (context, state) => const QuizScreen(),
    ),
    GoRoute(
      path: AppRoutes.result.path,
      builder: (context, state) => const ResultScreen(),
    ),
  ],
);
