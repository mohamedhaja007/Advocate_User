class StorageService {
  static String selectedLanguage = 'English';
  static bool isLoggedIn = true;
  static String selectedLocation = 'Chennai';
  static double walletBalance = 1250.0;

  static void addWalletBalance(double amount) => walletBalance += amount;
  static void deductWalletBalance(double amount) => walletBalance -= amount;
}
