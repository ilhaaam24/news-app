import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/routes/my_router.dart';
import 'package:news_app/features/article/presentation/bloc/article_bloc.dart';
import 'package:news_app/injection.dart';
import 'package:news_app/observer.dart';

void main() async {
  await init();
  Bloc.observer = MyObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => myInjection.get<ArticleBloc>()),
      ],
      child: MaterialApp.router(
        
        routerConfig: MyRouter().router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
