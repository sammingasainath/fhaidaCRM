import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project.dart';
import '../services/project_repository.dart';

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepository();
});

final projectListProvider = FutureProvider<List<Project>>((ref) async {
  final repository = ref.read(projectRepositoryProvider);
  return await repository.getProjects();
});

enum DashboardTab { all, inProgress, completed, pending, shipped }

final dashboardTabProvider =
    StateProvider<DashboardTab>((ref) => DashboardTab.all);

final filteredProjectListProvider = Provider<AsyncValue<List<Project>>>((ref) {
  final projectsAsyncValue = ref.watch(projectListProvider);
  final selectedTab = ref.watch(dashboardTabProvider);

  return projectsAsyncValue.whenData((projects) {
    switch (selectedTab) {
      case DashboardTab.inProgress:
        return projects
            .where((project) =>
                project.status == 'Sampling In Process' ||
                project.status == 'Quotation Accepted' ||
                project.status == 'Sent To Lab')
            .toList();
      case DashboardTab.completed:
        return projects
            .where((project) => project.status == 'reportRecieved')
            .toList();
      case DashboardTab.pending:
        return projects
            .where((project) =>
                project.status == 'Action Required' ||
                project.status == 'Quotation Requested' ||
                project.status == 'Quotation Sent')
            .toList();

      case DashboardTab.shipped:
        return projects
            .where((project) => project.status == 'reportShipped')
            .toList();
      case DashboardTab.all:
      default:
        return projects;
    }
  });
});
