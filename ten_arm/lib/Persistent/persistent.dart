class Persistent {
  static List<String> jobCategoryList = [
    "NIT Rourkela",
    "IIT Bhubaneswar",
    "KIIT University",
    "Trident",
    "Silicon University",
    "VSSUT Burla",
    "centurion university",
    "IIM Sambalpur",
    "GCE Kalahandi",
  ];
  static void updateJobCategoryList(List<String> newCategories) {
    jobCategoryList = newCategories;
  }
}
