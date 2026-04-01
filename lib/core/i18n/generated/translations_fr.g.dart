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
	@override late final _TranslationsProductsFr products = _TranslationsProductsFr._(_root);
	@override late final _TranslationsAddProductFr addProduct = _TranslationsAddProductFr._(_root);
	@override late final _TranslationsCartFr cart = _TranslationsCartFr._(_root);
	@override late final _TranslationsSettingsFr settings = _TranslationsSettingsFr._(_root);
	@override late final _TranslationsCategoriesFr categories = _TranslationsCategoriesFr._(_root);
}

// Path: app
class _TranslationsAppFr implements TranslationsAppEn {
	_TranslationsAppFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'EzShop';
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
	@override String get search => 'Rechercher...';
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
	@override String get title => 'EzShop';
	@override String get welcome => 'Bienvenue sur EzShop !';
	@override String get welcomeBack => 'Bon retour, {name} !';
	@override String get productsAvailable => '{count} produits disponibles';
	@override String get browseAll => 'Tout parcourir';
	@override String get addProduct => 'Ajouter un produit';
	@override String get featured => 'Produits en vedette';
	@override String get signInPrompt => 'Connectez-vous pour gérer les produits';
}

// Path: products
class _TranslationsProductsFr implements TranslationsProductsEn {
	_TranslationsProductsFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Produits';
	@override String get empty => 'Aucun produit. Ajoutez le premier !';
	@override String get inStock => 'En stock';
	@override String get soldOut => 'Épuisé';
	@override String get addToCart => 'Ajouté au panier';
	@override String get details => 'Détails du produit';
	@override String get name => 'Nom du produit';
	@override String get description => 'Description';
	@override String get price => 'Prix';
	@override String get category => 'Catégorie';
	@override String get imageUrl => 'URL de l\'image';
	@override String get addedOn => 'Ajouté le';
}

// Path: addProduct
class _TranslationsAddProductFr implements TranslationsAddProductEn {
	_TranslationsAddProductFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ajouter un produit';
	@override String get submit => 'Ajouter le produit';
	@override String get descriptionHint => 'Décrivez votre produit...';
	@override String get imageHint => 'https://...';
}

// Path: cart
class _TranslationsCartFr implements TranslationsCartEn {
	_TranslationsCartFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Panier';
	@override String get empty => 'Votre panier est vide';
	@override String get total => 'Total';
	@override String get checkout => 'Commander';
	@override String get checkoutDemo => 'Commande non implémentée — ceci est une démo !';
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
	@override String get appearance => 'Apparence';
	@override String get account => 'Compte';
	@override String get logout => 'Déconnexion';
}

// Path: categories
class _TranslationsCategoriesFr implements TranslationsCategoriesEn {
	_TranslationsCategoriesFr._(this._root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get electronics => 'Électronique';
	@override String get sports => 'Sport';
	@override String get home => 'Maison';
	@override String get stationery => 'Papeterie';
	@override String get fashion => 'Mode';
	@override String get food => 'Alimentation';
	@override String get other => 'Autre';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'EzShop',
			'common.ok' => 'OK',
			'common.cancel' => 'Annuler',
			'common.error' => 'Erreur',
			'common.retry' => 'Réessayer',
			'common.loading' => 'Chargement...',
			'common.noInternet' => 'Pas de connexion internet',
			'common.save' => 'Enregistrer',
			'common.delete' => 'Supprimer',
			'common.edit' => 'Modifier',
			'common.search' => 'Rechercher...',
			'auth.login' => 'Connexion',
			'auth.logout' => 'Déconnexion',
			'auth.email' => 'Email',
			'auth.password' => 'Mot de passe',
			'auth.loginButton' => 'Se connecter',
			'auth.logoutButton' => 'Se déconnecter',
			'auth.loginSuccess' => 'Bon retour !',
			'auth.loginError' => 'Identifiants invalides',
			'auth.loggedOut' => 'Vous avez été déconnecté',
			'home.title' => 'EzShop',
			'home.welcome' => 'Bienvenue sur EzShop !',
			'home.welcomeBack' => 'Bon retour, {name} !',
			'home.productsAvailable' => '{count} produits disponibles',
			'home.browseAll' => 'Tout parcourir',
			'home.addProduct' => 'Ajouter un produit',
			'home.featured' => 'Produits en vedette',
			'home.signInPrompt' => 'Connectez-vous pour gérer les produits',
			'products.title' => 'Produits',
			'products.empty' => 'Aucun produit. Ajoutez le premier !',
			'products.inStock' => 'En stock',
			'products.soldOut' => 'Épuisé',
			'products.addToCart' => 'Ajouté au panier',
			'products.details' => 'Détails du produit',
			'products.name' => 'Nom du produit',
			'products.description' => 'Description',
			'products.price' => 'Prix',
			'products.category' => 'Catégorie',
			'products.imageUrl' => 'URL de l\'image',
			'products.addedOn' => 'Ajouté le',
			'addProduct.title' => 'Ajouter un produit',
			'addProduct.submit' => 'Ajouter le produit',
			'addProduct.descriptionHint' => 'Décrivez votre produit...',
			'addProduct.imageHint' => 'https://...',
			'cart.title' => 'Panier',
			'cart.empty' => 'Votre panier est vide',
			'cart.total' => 'Total',
			'cart.checkout' => 'Commander',
			'cart.checkoutDemo' => 'Commande non implémentée — ceci est une démo !',
			'settings.title' => 'Paramètres',
			'settings.theme' => 'Thème',
			'settings.language' => 'Langue',
			'settings.themeLight' => 'Clair',
			'settings.themeDark' => 'Sombre',
			'settings.themeSystem' => 'Système',
			'settings.appearance' => 'Apparence',
			'settings.account' => 'Compte',
			'settings.logout' => 'Déconnexion',
			'categories.electronics' => 'Électronique',
			'categories.sports' => 'Sport',
			'categories.home' => 'Maison',
			'categories.stationery' => 'Papeterie',
			'categories.fashion' => 'Mode',
			'categories.food' => 'Alimentation',
			'categories.other' => 'Autre',
			_ => null,
		};
	}
}
