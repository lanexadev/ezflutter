///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsFr with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsAppFr app = _TranslationsAppFr._(_root);
	@override late final _TranslationsCommonFr common = _TranslationsCommonFr._(_root);
	@override late final _TranslationsAuthFr auth = _TranslationsAuthFr._(_root);
	@override late final _TranslationsHomeFr home = _TranslationsHomeFr._(_root);
	@override late final _TranslationsSettingsFr settings = _TranslationsSettingsFr._(_root);
}

// Path: app
class _TranslationsAppFr implements TranslationsAppEn {
	_TranslationsAppFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'EzFlutter';
}

// Path: common
class _TranslationsCommonFr implements TranslationsCommonEn {
	_TranslationsCommonFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get ok => 'OK';
	@override String get cancel => 'Annuler';
	@override String get error => 'Erreur';
	@override String get retry => 'Réessayer';
	@override String get loading => 'Chargement...';
	@override String get noInternet => 'Pas de connexion internet';
	@override String get save => 'Enregistrer';
	@override String get delete => 'Supprimer';
	@override String get edit => 'Modifier';
}

// Path: auth
class _TranslationsAuthFr implements TranslationsAuthEn {
	_TranslationsAuthFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get login => 'Connexion';
	@override String get logout => 'Déconnexion';
	@override String get email => 'Email';
	@override String get password => 'Mot de passe';
	@override String get loginButton => 'Se connecter';
	@override String get logoutButton => 'Se déconnecter';
	@override String get loginSuccess => 'Bon retour !';
	@override String get loginError => 'Identifiants invalides';
	@override String get loggedOut => 'Vous avez été déconnecté';
}

// Path: home
class _TranslationsHomeFr implements TranslationsHomeEn {
	_TranslationsHomeFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Accueil';
	@override String get welcome => 'Bienvenue sur EzFlutter !';
	@override String get greeting => 'Bonjour, {name} !';
}

// Path: settings
class _TranslationsSettingsFr implements TranslationsSettingsEn {
	_TranslationsSettingsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Paramètres';
	@override String get theme => 'Thème';
	@override String get language => 'Langue';
	@override String get themeLight => 'Clair';
	@override String get themeDark => 'Sombre';
	@override String get themeSystem => 'Système';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'EzFlutter',
			'common.ok' => 'OK',
			'common.cancel' => 'Annuler',
			'common.error' => 'Erreur',
			'common.retry' => 'Réessayer',
			'common.loading' => 'Chargement...',
			'common.noInternet' => 'Pas de connexion internet',
			'common.save' => 'Enregistrer',
			'common.delete' => 'Supprimer',
			'common.edit' => 'Modifier',
			'auth.login' => 'Connexion',
			'auth.logout' => 'Déconnexion',
			'auth.email' => 'Email',
			'auth.password' => 'Mot de passe',
			'auth.loginButton' => 'Se connecter',
			'auth.logoutButton' => 'Se déconnecter',
			'auth.loginSuccess' => 'Bon retour !',
			'auth.loginError' => 'Identifiants invalides',
			'auth.loggedOut' => 'Vous avez été déconnecté',
			'home.title' => 'Accueil',
			'home.welcome' => 'Bienvenue sur EzFlutter !',
			'home.greeting' => 'Bonjour, {name} !',
			'settings.title' => 'Paramètres',
			'settings.theme' => 'Thème',
			'settings.language' => 'Langue',
			'settings.themeLight' => 'Clair',
			'settings.themeDark' => 'Sombre',
			'settings.themeSystem' => 'Système',
			_ => null,
		};
	}
}
