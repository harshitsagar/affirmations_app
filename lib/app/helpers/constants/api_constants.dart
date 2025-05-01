mixin ApiConstants {
  //auth
  static const String signUp = 'user/signup';
  static const String signIn = 'user/login';
  static const String forgotPassword = 'user/resendVerification';
  static const String socialLogin = 'user/socialLogin';

  // goal
  static const String goalCardList = 'goal/listCard';
  static const String addGoal = 'goal/addGoal';
  static const String editGoal = 'goal/updateGoal';
  static const String deleteGoal = 'goal/deleteGoal';
  static const String home = 'goal/home';

  // settings
  static const String appDetails = 'appDetail/list';
  static const String faqList = 'faq/list';
  static const String contactAdmin = 'user/contactAdmin';
  static const String deleteAccount = 'user/delete';
  static const String logout = 'user/logout';

  // user
  static const String userDetails = 'user/details';
  static const String editProfile = 'user/update';

  //exercise
  static const String createSession = 'myRoutine/create';
  static const String mySessionList = 'myRoutine/list';
  static const String pastWorkoutList = 'myRoutine/pastWorkoutList';
  static const String workoutCalendar = 'myRoutine/workoutCalendar';
  static const String sessionDetails = 'myRoutine/detail';
  static const String shuffleExercise = 'myRoutine/shuffle/exercise';
  static const String exerciseProgress = 'myRoutine/progressExercise';
  static const String unitSwitch = 'unit/switch';

  static const String editSession = 'myRoutine/edit';
  static const String sessioneDelete = 'myRoutine/delete';

  static const String addExercise = 'myRoutine/addExercise';
  static const String setComplete = 'myRoutine/setComplete';
  static const String startWorkout = 'myRoutine/startWorkout';
  static const String finishWorkout = 'myRoutine/finishWorkout';
  static const String workoutAction = 'myRoutine/workoutAction';
  static const String workoutReview = 'myRoutine/workoutReview';

  static const String addSplit = 'myRoutine/addSplit';
  static const String splitDetail = 'myRoutine/detailSplit';

  static const String exerciseBankList = 'exerciseBank/list';
  static const String exerciseBankAdd = 'exerciseBank/add';
  static const String exerciseBankUpdate = 'exerciseBank/update';
  static const String exerciseBankDelete = 'exerciseBank/delete';
  static const String exerciseBankFilterList = 'exerciseBank/filterList';

  static const String recommendedList = 'recommended/list';
  static const String recommendedDetails = 'recommended/detail';
  static const String recommendedStartWorkout = 'recommended/startWorkout';

  //cardio
  static const String cardioDashboard = 'cardio/dashboard';
  static const String cardioBankList = 'cardio/cardioBankList';
  static const String quickCardioList = 'cardio/list';
  static const String finishCardio = 'cardio/add';
  static const String cardioDelete = 'cardio/delete';

  //sleep
  static const String alarmList = 'sleep/listAlarm';
  static const String addAlarm = 'sleep/addAlarm';
  static const String editAlarm = 'sleep/editAlarm';
  static const String deleteAlarm = 'sleep/deleteAlarm';
  static const String sleepSummary = 'sleep/summary';
  static const String addNap = 'sleep/addNap';
  static const String addSleepGoal = 'sleep/add';
  static const String startSleep = 'sleep/start';
  static const String stopSleep = 'sleep/stop';

  // nutrition
  static const String scanBarcode = 'barcode/fetch/data';
  static const String nutritionProgress = 'nutrition/progress';
  static const String addSupplement = 'nutrition/addSupplement';
  static const String deleteSupplement = 'nutrition/deleteSupplement';
  static const String markSupplement = 'nutrition/markSupplement';
  static const String editSupplement = 'nutrition/editSupplement';
  static const String supplementList = 'nutrition/listSupplement';
  static const String addWeight = 'nutrition/addWeight';
  static const String deleteWeight = 'nutrition/deleteWeight';
  static const String editWeight = 'nutrition/editWeight';
  static const String weightList = 'nutrition/listWeight';
  static const String graphWeightList = 'nutrition/graphWeight';
  static const String nutritionGoalList = 'nutrition/listGoalPlan';
  static const String nutritionGoalPlanDetails = 'nutrition/detailGoalPlan';
  static const String selectGoalPlan = 'nutrition/selectGoalPlan';
  static const String markGoalPlan = 'nutrition/markGoalPlan';
  static const String removeGoalItem = 'nutrition/goal/removeItem';
  static const String addInventory = 'nutrition/addInventory';
  static const String editInventory = 'nutrition/editInventory';
  static const String inventoryDetails = 'nutrition/detailInventory';
  static const String addWater = 'nutrition/addWater';

  // nutrition calculator
  static const String palList = 'calculator/listPal';
  static const String calculateNutrition = 'calculator/calculate';

  // Food
  static const String foodList = 'nutrition/listFood';
  static const String addFood = 'nutrition/addFood';
  static const String foodDetails = 'nutrition/detailFood';
  static const String editFood = 'nutrition/editFood';
  static const String deleteFood = 'nutrition/deleteFood';

  // Meal
  static const String mealList = 'nutrition/listMeal';
  static const String addMeal = 'nutrition/addMeal';
  static const String mealDetails = 'nutrition/detailMeal';
  static const String editMeal = 'nutrition/editMeal';
  static const String deleteMeal = 'nutrition/deleteMeal';
  static const String addGoalPlan = 'nutrition/addGoalPlan';
  static const String editGoalPlan = 'nutrition/editGoalPlan';
  static const String deleteGoalPlan = 'nutrition/deleteGoalPlan';

  // calendar
  static const String addTask = 'calendar/addTask';
  static const String editTask = 'calendar/editTask';
  static const String subjectList = 'study/listSubject';
  static const String sessionList = 'myRoutine/list';
  static const String taskList = 'calendar/listTask';
  static const String deleteTask = 'calendar/deleteTask';
  static const String calendarMonthlyDetail = 'calendar/monthlyDetail';

  // study
  static const String studySummary = 'study/summary';
  static const String studyStart = 'study/start';
  static const String studyAction = 'study/studyAction';
  static const String finishStudy = 'study/finish';
  static const String listSubjects = 'study/listSubject';
  static const String deleteSubject = 'study/deleteSubject';
  static const String editSubject = 'study/editSubject';
  static const String addSubject = 'study/addSubject';
  static const String addClass = 'study/subject/addClass';
  static const String editClass = 'study/subject/editClass';
  static const String deleteClass = 'study/subject/deleteClass';
  static const String subjectClassesList = 'study/subject/listClass';
  static const String subjectTopicList = 'study/subject/listTopic';
  static const String subjectTopicEdit = 'study/subject/editTopic';
  static const String subjectTopicAdd = 'study/subject/addTopic';
  static const String subjectAssessmentAdd = 'study/subject/addAssessment';
  static const String subjectAssessmentEdit = 'study/subject/editAssessment';
  static const String subjectAssessmentList = 'study/subject/listAssessment';
  static const String assessmentAction =
      'study/subject/assessment/topic/action';
  static const String deleteAssessment = 'study/subject/deleteAssessment';

  // todos
  static const String listTodos = 'toDo/list';
  static const String deleteTodo = 'toDo/delete';
  static const String editTodo = 'toDo/edit';
  static const String addTodo = 'toDo/add';

  // stats
  static const String studyStatistics = 'stats/study';
  static const String sleepStatistics = 'stats/sleep';
  static const String exerciseStatistics = 'stats/exercise';
  static const String nutritionStatistics = 'stats/nutrition';

  // subscription
  static const String freeTrial = 'subscription/start/freeTrial';
  static const String buySubscription = 'subscription/buy';
  static const String subscriptionDetail = 'subscription/detail';
}
