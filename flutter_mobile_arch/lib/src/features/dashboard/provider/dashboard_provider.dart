import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_arch/src/utils/pagination_mixin.dart';
import 'package:workmanager/workmanager.dart';
import '../../../models/task_model.dart';
import '../../../services/api_routes.dart';
import '../../../services/api_service.dart';
import '../../../services/http_interceptor.dart';

class DashboardSupportProvider extends ChangeNotifier
    with PaginationController {
  final ApiService _apiService = ApiService(HttpInterceptor());
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<dynamic> dataList = [];
  bool _hasInternet = true;
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  DashboardSupportProvider() {
    _initialize();
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
    Workmanager().registerOneOffTask(task.id, "simpleTask");
  }

  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) {
      // print("Background task executed: $task");

      return Future.value(true);
    });
  }

  void _initialize() async {
    await _checkInternetConnection();
    WidgetsBinding.instance.addPostFrameCallback((_) => reloadData());
  }

  Future<void> _checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _hasInternet = ConnectivityResult.none != connectivityResult;
    notifyListeners();
  }

  @override
  Future<void> reloadData() async {
    if (_isLoading || !_hasInternet) {
      if (!_hasInternet) {
        return;
      }
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _apiService
          .get('${ApiRoutes.baseUrl}/posts?_page=$currentPage&_limit=$limit');
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        if (currentPage == 1) {
          dataList = data;
        } else {
          dataList.addAll(data);
        }
        currentPage++;
        notifyListeners();
      } else {
        throw ApiException(response.statusCode, 'Failed to load data');
      }
    } catch (e) {
      log('Error loading data:$e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void loadMoreData() async {
    if (!isPaginating) {
      isPaginating = true;
      await reloadData();
      isPaginating = false;
    }
  }
}
