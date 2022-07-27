// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Copiar`
  String get Copy {
    return Intl.message(
      'Copiar',
      name: 'Copy',
      desc: '',
      args: [],
    );
  }

  /// `Pegar`
  String get Paste {
    return Intl.message(
      'Pegar',
      name: 'Paste',
      desc: '',
      args: [],
    );
  }

  /// `Cortar`
  String get Cut {
    return Intl.message(
      'Cortar',
      name: 'Cut',
      desc: '',
      args: [],
    );
  }

  /// `Enero`
  String get Janaury {
    return Intl.message(
      'Enero',
      name: 'Janaury',
      desc: '',
      args: [],
    );
  }

  /// `Febrero`
  String get Febraury {
    return Intl.message(
      'Febrero',
      name: 'Febraury',
      desc: '',
      args: [],
    );
  }

  /// `Marzo`
  String get March {
    return Intl.message(
      'Marzo',
      name: 'March',
      desc: '',
      args: [],
    );
  }

  /// `Abril`
  String get April {
    return Intl.message(
      'Abril',
      name: 'April',
      desc: '',
      args: [],
    );
  }

  /// `Mayo`
  String get May {
    return Intl.message(
      'Mayo',
      name: 'May',
      desc: '',
      args: [],
    );
  }

  /// `Junio`
  String get June {
    return Intl.message(
      'Junio',
      name: 'June',
      desc: '',
      args: [],
    );
  }

  /// `Julio`
  String get July {
    return Intl.message(
      'Julio',
      name: 'July',
      desc: '',
      args: [],
    );
  }

  /// `Agosto`
  String get August {
    return Intl.message(
      'Agosto',
      name: 'August',
      desc: '',
      args: [],
    );
  }

  /// `Septiembre`
  String get September {
    return Intl.message(
      'Septiembre',
      name: 'September',
      desc: '',
      args: [],
    );
  }

  /// `Octubre`
  String get October {
    return Intl.message(
      'Octubre',
      name: 'October',
      desc: '',
      args: [],
    );
  }

  /// `Noviembre`
  String get November {
    return Intl.message(
      'Noviembre',
      name: 'November',
      desc: '',
      args: [],
    );
  }

  /// `Diciembre`
  String get December {
    return Intl.message(
      'Diciembre',
      name: 'December',
      desc: '',
      args: [],
    );
  }

  /// `Lunes`
  String get Monday {
    return Intl.message(
      'Lunes',
      name: 'Monday',
      desc: '',
      args: [],
    );
  }

  /// `Martes`
  String get Thursday {
    return Intl.message(
      'Martes',
      name: 'Thursday',
      desc: '',
      args: [],
    );
  }

  /// `Miercoles`
  String get Wednesday {
    return Intl.message(
      'Miercoles',
      name: 'Wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Jueves`
  String get Tuesday {
    return Intl.message(
      'Jueves',
      name: 'Tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Vuernes`
  String get Friday {
    return Intl.message(
      'Vuernes',
      name: 'Friday',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es', countryCode: 'CO'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
