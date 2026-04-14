import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../domain/entities/question.dart';
import '../blocs/quiz_cubit.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go(AppRoutes.history.path),
        ),
      ),
      body: BlocConsumer<QuizCubit, QuizState>(
        listener: (context, state) {
          if (state is QuizFinished) {
            context.go(AppRoutes.result.path);
          }
        },
        builder: (context, state) {
          if (state is QuizInProgress) {
            final question = staticQuestions[state.currentQuestionIndex];
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value:
                        (state.currentQuestionIndex + 1) /
                        staticQuestions.length,
                  ),
                  40.verticalSpace,
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(1.0, 0.0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                      child: Column(
                        key: ValueKey<int>(state.currentQuestionIndex),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            question.text,
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          40.verticalSpace,
                          ...List.generate(
                            question.options.length,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 60.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () => context
                                      .read<QuizCubit>()
                                      .submitAnswer(index),
                                  child: Text(question.options[index]),
                                ),
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
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
