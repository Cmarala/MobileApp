import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('te'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'MobileApp'**
  String get appTitle;

  /// No description provided for @voterSearch.
  ///
  /// In en, this message translates to:
  /// **'Voter Search'**
  String get voterSearch;

  /// No description provided for @survey.
  ///
  /// In en, this message translates to:
  /// **'Survey'**
  String get survey;

  /// No description provided for @pollingLive.
  ///
  /// In en, this message translates to:
  /// **'Polling Live'**
  String get pollingLive;

  /// No description provided for @sync.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get sync;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @voterDetails.
  ///
  /// In en, this message translates to:
  /// **'Voter Details'**
  String get voterDetails;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noData;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @epicId.
  ///
  /// In en, this message translates to:
  /// **'EPIC ID'**
  String get epicId;

  /// No description provided for @section.
  ///
  /// In en, this message translates to:
  /// **'Section'**
  String get section;

  /// No description provided for @booth.
  ///
  /// In en, this message translates to:
  /// **'Booth'**
  String get booth;

  /// No description provided for @favorability.
  ///
  /// In en, this message translates to:
  /// **'Favorability'**
  String get favorability;

  /// No description provided for @isDead.
  ///
  /// In en, this message translates to:
  /// **'Is Dead'**
  String get isDead;

  /// No description provided for @isShifted.
  ///
  /// In en, this message translates to:
  /// **'Is Shifted'**
  String get isShifted;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @sms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get sms;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get whatsapp;

  /// No description provided for @print.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get print;

  /// No description provided for @voterSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Voter saved successfully'**
  String get voterSavedSuccessfully;

  /// No description provided for @errorSavingVoter.
  ///
  /// In en, this message translates to:
  /// **'Error saving voter'**
  String get errorSavingVoter;

  /// No description provided for @surveySubmitted.
  ///
  /// In en, this message translates to:
  /// **'Survey Saved!'**
  String get surveySubmitted;

  /// No description provided for @errorSubmittingSurvey.
  ///
  /// In en, this message translates to:
  /// **'Error submitting survey'**
  String get errorSubmittingSurvey;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @local.
  ///
  /// In en, this message translates to:
  /// **'Local Language'**
  String get local;

  /// No description provided for @headerSettings.
  ///
  /// In en, this message translates to:
  /// **'Header Settings'**
  String get headerSettings;

  /// No description provided for @footerSettings.
  ///
  /// In en, this message translates to:
  /// **'Footer Settings'**
  String get footerSettings;

  /// No description provided for @showHeader.
  ///
  /// In en, this message translates to:
  /// **'Add Header in Message'**
  String get showHeader;

  /// No description provided for @showFooter.
  ///
  /// In en, this message translates to:
  /// **'Add Footer in Message'**
  String get showFooter;

  /// No description provided for @selectHeaderImage.
  ///
  /// In en, this message translates to:
  /// **'Select Header Image'**
  String get selectHeaderImage;

  /// No description provided for @enterFooterText.
  ///
  /// In en, this message translates to:
  /// **'Enter Footer Text'**
  String get enterFooterText;

  /// No description provided for @polled.
  ///
  /// In en, this message translates to:
  /// **'POLLED'**
  String get polled;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'UNDO'**
  String get undo;

  /// No description provided for @voted.
  ///
  /// In en, this message translates to:
  /// **'VOTED'**
  String get voted;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @noVotersFound.
  ///
  /// In en, this message translates to:
  /// **'No voters found'**
  String get noVotersFound;

  /// No description provided for @allVotersPolled.
  ///
  /// In en, this message translates to:
  /// **'All voters polled or no matches found'**
  String get allVotersPolled;

  /// No description provided for @noOneVotedYet.
  ///
  /// In en, this message translates to:
  /// **'No one has voted yet.'**
  String get noOneVotedYet;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @boothDashboard.
  ///
  /// In en, this message translates to:
  /// **'Polling Live Dashboard'**
  String get boothDashboard;

  /// No description provided for @respondentName.
  ///
  /// In en, this message translates to:
  /// **'Respondent Name'**
  String get respondentName;

  /// No description provided for @respondentPhone.
  ///
  /// In en, this message translates to:
  /// **'Respondent Phone'**
  String get respondentPhone;

  /// No description provided for @submitSurvey.
  ///
  /// In en, this message translates to:
  /// **'SUBMIT SURVEY'**
  String get submitSurvey;

  /// No description provided for @respondentDetails.
  ///
  /// In en, this message translates to:
  /// **'Respondent Details'**
  String get respondentDetails;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter full name'**
  String get enterFullName;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @respondentNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Respondent name is required'**
  String get respondentNameRequired;

  /// No description provided for @noActiveCampaignFound.
  ///
  /// In en, this message translates to:
  /// **'No active campaign found'**
  String get noActiveCampaignFound;

  /// No description provided for @featureNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'{feature} feature is not yet available'**
  String featureNotAvailable(String feature);

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageChanged.
  ///
  /// In en, this message translates to:
  /// **'Language changed successfully'**
  String get languageChanged;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @headerImage.
  ///
  /// In en, this message translates to:
  /// **'Header Image'**
  String get headerImage;

  /// No description provided for @noHeaderSelected.
  ///
  /// In en, this message translates to:
  /// **'No header selected'**
  String get noHeaderSelected;

  /// No description provided for @selectHeader.
  ///
  /// In en, this message translates to:
  /// **'Select Header'**
  String get selectHeader;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @footerText.
  ///
  /// In en, this message translates to:
  /// **'Footer Text'**
  String get footerText;

  /// No description provided for @footerSaved.
  ///
  /// In en, this message translates to:
  /// **'Footer saved successfully'**
  String get footerSaved;

  /// No description provided for @voterInformation.
  ///
  /// In en, this message translates to:
  /// **'Voter Information'**
  String get voterInformation;

  /// No description provided for @boothName.
  ///
  /// In en, this message translates to:
  /// **'Booth Name'**
  String get boothName;

  /// No description provided for @partSerial.
  ///
  /// In en, this message translates to:
  /// **'Part/Serial'**
  String get partSerial;

  /// No description provided for @houseNo.
  ///
  /// In en, this message translates to:
  /// **'House No'**
  String get houseNo;

  /// No description provided for @relationName.
  ///
  /// In en, this message translates to:
  /// **'Relation Name'**
  String get relationName;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @shiftedHouseNo.
  ///
  /// In en, this message translates to:
  /// **'Shifted House No'**
  String get shiftedHouseNo;

  /// No description provided for @shiftedAddress.
  ///
  /// In en, this message translates to:
  /// **'Shifted Address'**
  String get shiftedAddress;

  /// No description provided for @locationInfo.
  ///
  /// In en, this message translates to:
  /// **'Location Information'**
  String get locationInfo;

  /// No description provided for @getLocation.
  ///
  /// In en, this message translates to:
  /// **'Get Location'**
  String get getLocation;

  /// No description provided for @showDirections.
  ///
  /// In en, this message translates to:
  /// **'Show Directions'**
  String get showDirections;

  /// No description provided for @latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get latitude;

  /// No description provided for @longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get longitude;

  /// No description provided for @sectionVoters.
  ///
  /// In en, this message translates to:
  /// **'Section Voters'**
  String get sectionVoters;

  /// No description provided for @boothVoters.
  ///
  /// In en, this message translates to:
  /// **'Booth Voters'**
  String get boothVoters;

  /// No description provided for @part.
  ///
  /// In en, this message translates to:
  /// **'Part'**
  String get part;

  /// No description provided for @srno.
  ///
  /// In en, this message translates to:
  /// **'Sr.No'**
  String get srno;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'te'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
