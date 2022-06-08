import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smct/gameselect/gameselect.dart';
import 'package:smct/home/home.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
    BlocProvider<GameSelectBloc>(create: (_) => GameSelectBloc()),
  ], child: const MentalCalc()));
}

class MentalCalc extends StatelessWidget {
  const MentalCalc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      theme: ThemeData.from(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          // Primary
          primary: Color(0xffFFB77E),
          onPrimary: Color(0xff4F2500),
          primaryContainer: Color(0xff703800),
          onPrimaryContainer: Color(0xffFFDCC2),
          // Secondary
          secondary: Color(0xffE3BFA6),
          onSecondary: Color(0xff422B1A),
          secondaryContainer: Color(0xff5A412F),
          onSecondaryContainer: Color(0xffFFDCC2),
          // Tertiary
          tertiary: Color(0xffC6CA95),
          onTertiary: Color(0xff2F330B),
          tertiaryContainer: Color(0xff464A21),
          onTertiaryContainer: Color(0xffE3E7AF),
          // Error
          error: Color(0xffFFB4A9),
          onError: Color(0xff680003),
          errorContainer: Color(0xff930006),
          onErrorContainer: Color(0xffFFDAD4),
          // Background
          background: Color(0xffECE0DA),
          onBackground: Color(0xff201A17),
          surface: Color(0xffECE0DA),
          onSurface: Color(0xff201A17),
        ),
        useMaterial3: true,
        textTheme: TextTheme(
            displaySmall: GoogleFonts.oswald(
              fontSize: 36,
              fontWeight: FontWeight.w400,
            ),
            headlineMedium: GoogleFonts.oswald(
              fontSize: 28,
              fontWeight: FontWeight.w400,
            ),
            labelLarge: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
      ),
    );
  }
}
