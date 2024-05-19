class DashboardNavigationSate {
  int i;
  DashboardNavigationSate(this.i);
  @override
  bool operator ==(covariant DashboardNavigationSate other) {
    return other.i == i;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => i.hashCode;
}

// class DashboardNavigationDashboardState extends DashboardNavigationSate {
//   DashboardNavigationDashboardState() : super(0);
// }

// class DashboardNavigationCategoryState extends DashboardNavigationSate {
//   DashboardNavigationCategoryState() : super(1);
// }

// class DashboardNavigationProductState extends DashboardNavigationSate {
//   DashboardNavigationProductState() : super(2);
// }
// class DashboardNavigationInventoryState extends DashboardNavigationSate {
//   DashboardNavigationInventoryState() : super(2);
// }