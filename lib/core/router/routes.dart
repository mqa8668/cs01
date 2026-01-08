/// Route path constants
class Routes {
  Routes._();

  // Shell route (with bottom navigation)
  static const String home = '/';

  // Main features
  static const String neuralMap = '/neural-map';
  static const String testScoring = '/test';
  static const String mindGarden = '/garden';
  static const String miniDiary = '/diary';
  static const String careDrops = '/care-drops';

  // Sub-routes
  static const String testHistory = '/test/history';
  static const String diaryEntry = '/diary/:id';
  static const String careDropsChat = '/care-drops/:id';
}
