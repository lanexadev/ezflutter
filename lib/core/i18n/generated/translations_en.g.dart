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
	late final TranslationsProductsEn products = TranslationsProductsEn._(_root);
	late final TranslationsAddProductEn addProduct = TranslationsAddProductEn._(_root);
	late final TranslationsCartEn cart = TranslationsCartEn._(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
	late final TranslationsCategoriesEn categories = TranslationsCategoriesEn._(_root);
}

// Path: app
class TranslationsAppEn {
	TranslationsAppEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'EzShop'
	String get name => 'EzShop';
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

	/// en: 'Search...'
	String get search => 'Search...';
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

	/// en: 'EzShop'
	String get title => 'EzShop';

	/// en: 'Welcome to EzShop!'
	String get welcome => 'Welcome to EzShop!';

	/// en: 'Welcome back, {name}!'
	String get welcomeBack => 'Welcome back, {name}!';

	/// en: '{count} products available'
	String get productsAvailable => '{count} products available';

	/// en: 'Browse All'
	String get browseAll => 'Browse All';

	/// en: 'Add Product'
	String get addProduct => 'Add Product';

	/// en: 'Featured Products'
	String get featured => 'Featured Products';

	/// en: 'Sign in to manage products'
	String get signInPrompt => 'Sign in to manage products';
}

// Path: products
class TranslationsProductsEn {
	TranslationsProductsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Products'
	String get title => 'Products';

	/// en: 'No products yet. Add your first!'
	String get empty => 'No products yet. Add your first!';

	/// en: 'In Stock'
	String get inStock => 'In Stock';

	/// en: 'Sold Out'
	String get soldOut => 'Sold Out';

	/// en: 'Added to cart'
	String get addToCart => 'Added to cart';

	/// en: 'Product Details'
	String get details => 'Product Details';

	/// en: 'Product Name'
	String get name => 'Product Name';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'Price'
	String get price => 'Price';

	/// en: 'Category'
	String get category => 'Category';

	/// en: 'Image URL'
	String get imageUrl => 'Image URL';

	/// en: 'Added On'
	String get addedOn => 'Added On';
}

// Path: addProduct
class TranslationsAddProductEn {
	TranslationsAddProductEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add Product'
	String get title => 'Add Product';

	/// en: 'Add Product'
	String get submit => 'Add Product';

	/// en: 'Describe your product...'
	String get descriptionHint => 'Describe your product...';

	/// en: 'https://...'
	String get imageHint => 'https://...';
}

// Path: cart
class TranslationsCartEn {
	TranslationsCartEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cart'
	String get title => 'Cart';

	/// en: 'Your cart is empty'
	String get empty => 'Your cart is empty';

	/// en: 'Total'
	String get total => 'Total';

	/// en: 'Checkout'
	String get checkout => 'Checkout';

	/// en: 'Checkout not implemented — this is a demo!'
	String get checkoutDemo => 'Checkout not implemented — this is a demo!';
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

	/// en: 'Appearance'
	String get appearance => 'Appearance';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Logout'
	String get logout => 'Logout';
}

// Path: categories
class TranslationsCategoriesEn {
	TranslationsCategoriesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Electronics'
	String get electronics => 'Electronics';

	/// en: 'Sports'
	String get sports => 'Sports';

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Stationery'
	String get stationery => 'Stationery';

	/// en: 'Fashion'
	String get fashion => 'Fashion';

	/// en: 'Food'
	String get food => 'Food';

	/// en: 'Other'
	String get other => 'Other';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'EzShop',
			'common.ok' => 'OK',
			'common.cancel' => 'Cancel',
			'common.error' => 'Error',
			'common.retry' => 'Retry',
			'common.loading' => 'Loading...',
			'common.noInternet' => 'No internet connection',
			'common.save' => 'Save',
			'common.delete' => 'Delete',
			'common.edit' => 'Edit',
			'common.search' => 'Search...',
			'auth.login' => 'Login',
			'auth.logout' => 'Logout',
			'auth.email' => 'Email',
			'auth.password' => 'Password',
			'auth.loginButton' => 'Sign In',
			'auth.logoutButton' => 'Sign Out',
			'auth.loginSuccess' => 'Welcome back!',
			'auth.loginError' => 'Invalid credentials',
			'auth.loggedOut' => 'You have been logged out',
			'home.title' => 'EzShop',
			'home.welcome' => 'Welcome to EzShop!',
			'home.welcomeBack' => 'Welcome back, {name}!',
			'home.productsAvailable' => '{count} products available',
			'home.browseAll' => 'Browse All',
			'home.addProduct' => 'Add Product',
			'home.featured' => 'Featured Products',
			'home.signInPrompt' => 'Sign in to manage products',
			'products.title' => 'Products',
			'products.empty' => 'No products yet. Add your first!',
			'products.inStock' => 'In Stock',
			'products.soldOut' => 'Sold Out',
			'products.addToCart' => 'Added to cart',
			'products.details' => 'Product Details',
			'products.name' => 'Product Name',
			'products.description' => 'Description',
			'products.price' => 'Price',
			'products.category' => 'Category',
			'products.imageUrl' => 'Image URL',
			'products.addedOn' => 'Added On',
			'addProduct.title' => 'Add Product',
			'addProduct.submit' => 'Add Product',
			'addProduct.descriptionHint' => 'Describe your product...',
			'addProduct.imageHint' => 'https://...',
			'cart.title' => 'Cart',
			'cart.empty' => 'Your cart is empty',
			'cart.total' => 'Total',
			'cart.checkout' => 'Checkout',
			'cart.checkoutDemo' => 'Checkout not implemented — this is a demo!',
			'settings.title' => 'Settings',
			'settings.theme' => 'Theme',
			'settings.language' => 'Language',
			'settings.themeLight' => 'Light',
			'settings.themeDark' => 'Dark',
			'settings.themeSystem' => 'System',
			'settings.appearance' => 'Appearance',
			'settings.account' => 'Account',
			'settings.logout' => 'Logout',
			'categories.electronics' => 'Electronics',
			'categories.sports' => 'Sports',
			'categories.home' => 'Home',
			'categories.stationery' => 'Stationery',
			'categories.fashion' => 'Fashion',
			'categories.food' => 'Food',
			'categories.other' => 'Other',
			_ => null,
		};
	}
}
