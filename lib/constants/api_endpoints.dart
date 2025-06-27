class Endpoints {
  static const String login = 'auth/admin/login';
  static const String imageBaseUrl = 'http://142.93.236.128:4300/';
  static const String getAllBanners = 'banner';
  static const String support = 'support';
  static const String categories = 'products/get-filters';

  static const String ticketResponse = 'support-response/create';
  static String deleteBanner(int bannerId) => "banner/delete/$bannerId";
  static String updateSupport(int supportId) => "support/status/$supportId";
  static String updateBanner(int bannerId) => "banner/update/$bannerId";
}
