mixin ApiConstants {

  //auth ....
  static const String signUp = 'user/signup';
  static const String signIn = 'user/login';
  static const String forgotPassword = 'user/resendVerification';
  static const String socialLogin = 'user/socialLogin';

  // settings ....
  static const String appDetails = 'appDetail/list';
  static const String faqList = 'faq/list';
  static const String contactAdmin = 'user/contactAdmin';
  static const String deleteAccount = 'user/delete';
  static const String logout = 'user/logout';
  static const String affirmationTypes = 'affirmation/types';

  // my list ....
  static const String favList = 'affirmation/favList';
  static const String likeAffirmation = 'affirmation/like';
  static const String newList = 'affirmation/myList';
  static const String addAffirmation = 'affirmation/add';
  static const String getAffirmationList = 'affirmation/list';

  // user ...
  static const String userDetails = 'user/details';
  static const String editProfile = 'user/update';
  static const String home = 'user/home';

  // setup profile ....
  static const String listTheme = 'user/listTheme';

  // journal .....
  static const String journalDetails = 'user/journalDetails';
  static const String addJournal = 'user/addJournal';

}
