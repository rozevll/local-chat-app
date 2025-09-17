import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  User? _user;
  String? _token;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _token != null && _user != null;

  // 로그인
  Future<bool> login(String username, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final request = LoginRequest(username: username, password: password);
      final response = await _apiService.login(request);
      
      _user = response.user;
      _token = response.token;
      
      // 로컬 저장소에 저장
      await StorageService.saveLoginInfo(_token!, _user!.id, _user!.username);
      
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // 회원가입
  Future<bool> register(String username, String password, {String? email}) async {
    _setLoading(true);
    _clearError();

    try {
      final request = RegisterRequest(username: username, password: password, email: email);
      final response = await _apiService.register(request);
      
      _user = response.user;
      _token = response.token;
      
      // 로컬 저장소에 저장
      await StorageService.saveLoginInfo(_token!, _user!.id, _user!.username);
      
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // 로그아웃
  Future<void> logout() async {
    _user = null;
    _token = null;
    _clearError();
    
    await StorageService.logout();
    notifyListeners();
  }

  // 저장된 로그인 정보 확인
  Future<void> checkAuthStatus() async {
    final token = await StorageService.getToken();
    final userId = await StorageService.getUserId();
    final username = await StorageService.getUsername();
    
    if (token != null && userId != null && username != null) {
      _token = token;
      _user = User(
        id: userId,
        username: username,
        createdAt: DateTime.now(), // 실제로는 서버에서 가져와야 함
      );
      notifyListeners();
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }
}
