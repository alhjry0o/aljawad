import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/service_repository.dart';
import '../../data/repositories/request_repository.dart';
import '../../data/models/service_model.dart';
import '../../data/models/project_model.dart';
import '../../data/models/request_model.dart';

final serviceRepositoryProvider = Provider<IServiceRepository>((ref) {
  return LocalServiceRepository();
});

final requestRepositoryProvider = Provider<IRequestRepository>((ref) {
  return LocalRequestRepository();
});

final servicesListProvider = Provider<List<ServiceModel>>((ref) {
  final repo = ref.watch(serviceRepositoryProvider);
  return repo.getAllServices();
});

final projectsListProvider = Provider<List<ProjectModel>>((ref) {
  final repo = ref.watch(serviceRepositoryProvider);
  return repo.getAllProjects();
});

class RequestsNotifier extends StateNotifier<AsyncValue<List<RequestModel>>> {
  final IRequestRepository _repo;

  RequestsNotifier(this._repo) : super(const AsyncValue.loading()) {
    loadRequests();
  }

  Future<void> loadRequests() async {
    try {
      final list = await _repo.getRequests();
      state = AsyncValue.data(list);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addRequest(RequestModel request) async {
    await _repo.saveRequest(request);
    await loadRequests();
  }

  Future<void> removeRequest(String id) async {
    await _repo.deleteRequest(id);
    await loadRequests();
  }
}

final requestsNotifierProvider =
    StateNotifierProvider<RequestsNotifier, AsyncValue<List<RequestModel>>>((ref) {
  final repo = ref.watch(requestRepositoryProvider);
  return RequestsNotifier(repo);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system);

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});
