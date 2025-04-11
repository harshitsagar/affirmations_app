import 'package:affirmations_app/app/modules/authentication/profile/journal/bindings/journal_binding.dart';
import 'package:affirmations_app/app/modules/authentication/profile/journal/views/journal_reminder.dart';
import 'package:affirmations_app/app/modules/authentication/profile/journal/views/journal_view1.dart';
import 'package:affirmations_app/app/modules/authentication/profile/journal/views/journal_view2.dart';
import 'package:get/get.dart';

import '../modules/authentication/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/authentication/forgot_password/views/forgot_password_view.dart';
import '../modules/authentication/login/bindings/login_binding.dart';
import '../modules/authentication/login/views/login_view.dart';
import '../modules/authentication/profile/affirmation_reminder/bindings/affirmation_reminder_binding.dart';
import '../modules/authentication/profile/affirmation_reminder/views/affirmation_reminder_view.dart';
import '../modules/authentication/profile/affirmations/bindings/affirmations_binding.dart';
import '../modules/authentication/profile/affirmations/views/affirmations_view.dart';
import '../modules/authentication/profile/hear_about/bindings/hear_about_binding.dart';
import '../modules/authentication/profile/hear_about/views/hear_about_view.dart';
import '../modules/authentication/profile/profile_screen/bindings/profile_screen_binding.dart';
import '../modules/authentication/profile/profile_screen/views/profile_screen_view1.dart';
import '../modules/authentication/profile/subscription_screen/bindings/subscription_screen_binding.dart';
import '../modules/authentication/profile/subscription_screen/views/subscription_screen_view.dart';
import '../modules/authentication/profile/themes/bindings/themes_binding.dart';
import '../modules/authentication/profile/themes/views/themes_view.dart';
import '../modules/authentication/signup/bindings/signup_binding.dart';
import '../modules/authentication/signup/views/signup_view.dart';
import '../modules/authentication/splash/bindings/splash_binding.dart';
import '../modules/authentication/splash/views/splash_view.dart';
import '../modules/screens/common/add_entry/bindings/add_entry_binding.dart';
import '../modules/screens/common/add_entry/views/add_entry_view.dart';
import '../modules/screens/common/app_settings/about_edit/bindings/about_edit_binding.dart';
import '../modules/screens/common/app_settings/about_edit/views/about_edit_view.dart';
import '../modules/screens/common/app_settings/affirmation_types/bindings/affirmation_types_binding.dart';
import '../modules/screens/common/app_settings/affirmation_types/views/affirmation_types_view.dart';
import '../modules/screens/common/app_settings/app_themes/bindings/app_themes_binding.dart';
import '../modules/screens/common/app_settings/app_themes/views/app_themes_view.dart';
import '../modules/screens/common/app_settings/contact_admin/bindings/contact_admin_binding.dart';
import '../modules/screens/common/app_settings/contact_admin/views/contact_admin_view.dart';
import '../modules/screens/common/app_settings/reminders/bindings/reminders_binding.dart';
import '../modules/screens/common/app_settings/reminders/views/reminders_view.dart';
import '../modules/screens/common/app_settings/settings/bindings/settings_binding.dart';
import '../modules/screens/common/app_settings/settings/views/settings_view.dart';
import '../modules/screens/common/share_screen/bindings/share_screen_binding.dart';
import '../modules/screens/common/share_screen/views/share_screen_view.dart';
import '../modules/screens/guest/bindings/guest_binding.dart';
import '../modules/screens/guest/views/guest_view.dart';
import '../modules/screens/onboarding/bindings/onboarding_binding.dart';
import '../modules/screens/onboarding/views/onboarding_view.dart';
import '../modules/screens/user/home/bindings/home_binding.dart';
import '../modules/screens/user/home/views/home_view.dart';
import '../modules/screens/user/journal/filter/bindings/filter_binding.dart';
import '../modules/screens/user/journal/filter/views/filter_view.dart';
import '../modules/screens/user/my_List/favorites/bindings/favorites_binding.dart';
import '../modules/screens/user/my_List/favorites/views/favorites_view.dart';
import '../modules/screens/user/my_List/myList/bindings/my_list_binding.dart';
import '../modules/screens/user/my_List/myList/views/my_list_view.dart';
import '../modules/screens/user/streak/freeze/bindings/freeze_binding.dart';
import '../modules/screens/user/streak/freeze/views/freeze_view.dart';
import '../modules/screens/user/streak/restore/bindings/restore_binding.dart';
import '../modules/screens/user/streak/restore/views/restore_view.dart';
import '../modules/screens/user/streak/streak_screen/bindings/streak_screen_binding.dart';
import '../modules/screens/user/streak/streak_screen/views/streak_screen_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static var INITIAL = Routes.SETTINGS;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SCREEN,
      page: () => const ProfileScreenView1(),
      binding: ProfileScreenBinding(),
    ),
    GetPage(
      name: _Paths.AFFIRMATIONS,
      page: () => const AffirmationsView(),
      binding: AffirmationsBinding(),
    ),
    GetPage(
      name: _Paths.THEMES,
      page: () => const ThemesView(),
      binding: ThemesBinding(),
    ),
    GetPage(
      name: _Paths.HEAR_ABOUT,
      page: () => const HearAboutView(),
      binding: HearAboutBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION_SCREEN,
      page: () => const SubscriptionScreenView(),
      binding: SubscriptionScreenBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ENTRY,
      page: () => const AddEntryView(),
      binding: AddEntryBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SHARE_SCREEN,
      page: () => const ShareScreenView(),
      binding: ShareScreenBinding(),
    ),
    GetPage(
      name: _Paths.STREAK_SCREEN,
      page: () => const StreakScreenView(),
      binding: StreakScreenBinding(),
    ),
    GetPage(
      name: _Paths.RESTORE,
      page: () => const RestoreView(),
      binding: RestoreBinding(),
    ),
    GetPage(
      name: _Paths.FREEZE,
      page: () => const FreezeView(),
      binding: FreezeBinding(),
    ),
    GetPage(
      name: _Paths.FILTER,
      page: () => const FilterView(),
      binding: FilterBinding(),
    ),
    GetPage(
      name: _Paths.MY_LIST,
      page: () => const MyListView(),
      binding: MyListBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITES,
      page: () => const FavoritesView(),
      binding: FavoritesBinding(),
    ),
    GetPage(
      name: _Paths.GUEST,
      page: () => const GuestView(),
      binding: GuestBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_EDIT,
      page: () => AboutEditView(),
      binding: AboutEditBinding(),
    ),
    GetPage(
      name: _Paths.AFFIRMATION_TYPES,
      page: () => const AffirmationTypesView(),
      binding: AffirmationTypesBinding(),
    ),
    GetPage(
      name: _Paths.REMINDERS,
      page: () => const RemindersView(),
      binding: RemindersBinding(),
    ),
    GetPage(
      name: _Paths.APP_THEMES,
      page: () => const AppThemesView(),
      binding: AppThemesBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_ADMIN,
      page: () => const ContactAdminView(),
      binding: ContactAdminBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.AFFIRMATION_REMINDER,
      page: () => const AffirmationReminderView(),
      binding: AffirmationReminderBinding(),
    ),
    GetPage(
      name: _Paths.JOURNAL1,
      page: () => const JournalView1(),
      binding: JournalBinding(),
    ),
    GetPage(
      name: _Paths.JOURNAL2,
      page: () => JournalView2(),
      binding: JournalBinding(),
    ),
    GetPage(
      name: _Paths.JOURNAL_REMINDER,
      page: () => const JournalReminder(),
      binding: JournalBinding(),
    ),
  ];
}
