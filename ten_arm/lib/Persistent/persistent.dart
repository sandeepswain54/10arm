class Persistent {
  static List<String> jobCategoryList = [
    "odisha",
    " Bhubaneswar",
    "KIIT University",
    "puri",
    "paradip",
    " Burla",
    "centurion u",
    " Sambalpur",
    "Kalahandi",
  ];
  static void updateJobCategoryList(List<String> newCategories) {
    jobCategoryList = newCategories;
  }
}
