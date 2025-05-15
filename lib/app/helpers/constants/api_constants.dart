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

  // user
  static const String userDetails = 'user/details';
  static const String editProfile = 'user/update';

  // setup profile
  static const String listTheme = 'user/listTheme';

  // calendar
  static const String addTask = 'calendar/addTask';
  static const String editTask = 'calendar/editTask';
  static const String subjectList = 'study/listSubject';
  static const String sessionList = 'myRoutine/list';
  static const String taskList = 'calendar/listTask';
  static const String deleteTask = 'calendar/deleteTask';
  static const String calendarMonthlyDetail = 'calendar/monthlyDetail';

  // subscription
  static const String freeTrial = 'subscription/start/freeTrial';
  static const String buySubscription = 'subscription/buy';
  static const String subscriptionDetail = 'subscription/detail';

}
