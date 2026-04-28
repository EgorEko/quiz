import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/common/blocs/quiz_cubit.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<QuizCubit>().loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My results'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            if (state is QuizInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is QuizHistoryLoaded) {
              return _buildHistoryList(state.history);
            }

            if (state is QuizNoHistory) {
              return _buildEmptyState(context);
            }

            return _buildEmptyState(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<QuizCubit>().startQuiz();
          context.go(AppRoutes.quiz.path);
        },
        label: const Text('Get started'),
        icon: const Icon(Icons.play_arrow),
      ),
    );
  }

  Widget _buildHistoryList(List<String> history) {
    return ListView.separated(
      itemCount: history.length,
      separatorBuilder: (context, index) => 10.verticalSpace,
      itemBuilder: (context, index) {
        final item = history.reversed.toList()[index];
        return Card(
          elevation: 0,
          color: AppColors.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.check_circle_outline,
                color: AppColors.iconColor,
              ),
            ),
            title: Text(
              'Attempt №${history.length - index}',
              style: AppTextStyles.defaultTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(item, style: AppTextStyles.defaultTextStyle),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.iconColor,
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_toggle_off,
            size: 80.sp,
            color: AppColors.iconColor,
          ),
          16.verticalSpace,
          Text(
            'You haven\'t taken a quiz yet. Let\'s get started.',
            textAlign: TextAlign.center,
            style: AppTextStyles.emptyHistory,
          ),
          8.verticalSpace,
          const Text(
            'Take the quiz to see your results here.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
