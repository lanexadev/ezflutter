///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsAppEn app = TranslationsAppEn._(_root);
	late final TranslationsCommonEn common = TranslationsCommonEn._(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn._(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
}

// Path: app
class TranslationsAppEn {
	TranslationsAppEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'EzFlutter'
	String get name => 'EzFlutter';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Error'
	String get error => 'Error';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'No internet connection'
	String get noInternet => 'No internet connection';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Edit'
	String get edit => 'Edit';
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Login'
	String get login => 'Login';

	/// en: 'Logout'
	String get logout => 'Logout';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Sign In'
	String get loginButton => 'Sign In';

	/// en: 'Sign Out'
	String get logoutButton => 'Sign Out';

	/// en: 'Welcome back!'
	String get loginSuccess => 'Welcome back!';

	/// en: 'Invalid credentials'
	String get loginError => 'Invalid credentials';

	/// en: 'You have been logged out'
	String get loggedOut => 'You have been logged out';
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get title => 'Home';

	/// en: 'Welcome to EzFlutter!'
	String get welcome => 'Welcome to EzFlutter!';

	/// en: 'Hello, {name}!'
	String get greeting => 'Hello, {name}!';
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'Theme'
	String get theme => 'Theme';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Light'
	String get themeLight => 'Light';

	/// en: 'Dark'
	String get themeDark => 'Dark';

	/// en: 'System'
	String get themeSystem => 'System';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'EzFlutter',
			'common.ok' => 'OK',
			'common.cancel' => 'Cancel',
			'common.error' => 'Error',
			'common.retry' => 'Retry',
			'common.loading' => 'Loading...',
			'common.noInternet' => 'No internet connection',
			'common.save' => 'Save',
			'common.delete' => 'Delete',
			'common.edit' => 'Edit',
			'auth.login' => 'Login',
			'auth.logout' => 'Logout',
			'auth.email' => 'Email',
			'auth.password' => 'Password',
			'auth.loginButton' => 'Sign In',
			'auth.logoutButton' => 'Sign Out',
			'auth.loginSuccess' => 'Welcome back!',
			'auth.loginError' => 'Invalid credentials',
			'auth.loggedOut' => 'You have been logged out',
			'home.title' => 'Home',
			'home.welcome' => 'Welcome to EzFlutter!',
			'home.greeting' => 'Hello, {name}!',
			'settings.title' => 'Settings',
			'settings.theme' => 'Theme',
			'settings.language' => 'Language',
			'settings.themeLight' => 'Light',
			'settings.themeDark' => 'Dark',
			'settings.themeSystem' => 'System',
			_ => null,
		};
	}
}
