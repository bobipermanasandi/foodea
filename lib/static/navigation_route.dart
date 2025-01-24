enum NavigationRoute {
  mainRoute("/main"),
  detailRoute("/detail"),
  searchRoute("/search"),
  notificationRoute("/notification");

  const NavigationRoute(this.name);
  final String name;
}
