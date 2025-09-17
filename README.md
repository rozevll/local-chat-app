# 💬 Local Chat App

**지역 기반 랜덤 채팅 앱**

![Flutter](https://img.shields.io/badge/Flutter-3.9.2-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.9.2-blue.svg)
![Provider](https://img.shields.io/badge/Provider-State%20Management-orange.svg)
![WebSocket](https://img.shields.io/badge/WebSocket-Real--time-purple.svg)

## 📱 주요 기능

- [x] 🔐 **사용자 인증**: 회원가입/로그인 시스템
- [x] 🎲 **랜덤 매칭**: 최대 4명까지 랜덤 채팅방 입장
- [x] 💬 **실시간 채팅**: WebSocket을 통한 즉시 메시지 전송
- [x] 🚪 **자유로운 퇴장**: 언제든지 채팅방 나가기 가능
- [x] 📱 **크로스 플랫폼**: Android, iOS, Web 지원
- [x] 🎨 **모던 UI**: Material Design 3 기반 깔끔한 디자인

## 🚀 시작하기

### 1️⃣ 사전 요구사항

- Flutter SDK 3.9.2 이상
- Dart SDK 3.9.2 이상
- Android Studio / Xcode (모바일 개발용)
- Chrome (웹 개발용)

### 2️⃣ 설치 및 실행

```bash
# 저장소 클론
git clone <repository-url>
cd local_chat_app

# 의존성 설치
flutter pub get

# 앱 실행 (웹)
flutter run -d chrome

# 앱 실행 (Android)
flutter run -d android

# 앱 실행 (iOS)
flutter run -d ios
```

### 3️⃣ 빌드

```bash
# 웹 빌드
flutter build web

# Android APK 빌드
flutter build apk

# iOS 빌드 (macOS에서만)
flutter build ios
```

## 🔧 기술 스택

| 카테고리 | 기술 | 버전 | 설명 |
|---------|------|------|------|
| **프레임워크** | Flutter | 3.9.2 | 크로스 플랫폼 UI 프레임워크 |
| **언어** | Dart | 3.9.2 | 프로그래밍 언어 |
| **상태관리** | Provider | 6.1.1 | 상태 관리 패키지 |
| **HTTP** | http | 1.1.0 | HTTP 통신 패키지 |
| **WebSocket** | web_socket_channel | 2.4.0 | WebSocket 통신 패키지 |
| **로컬저장소** | shared_preferences | 2.2.2 | 로컬 데이터 저장 |
| **JSON** | json_annotation | 4.8.1 | JSON 직렬화 |
| **UI** | Material Design 3 | - | 구글 디자인 시스템 |

## 📖 사용법

### 🔐 1. 회원가입/로그인

1. 앱을 실행하면 로그인 화면이 나타납니다
2. "회원가입" 탭에서 새 계정을 만들거나
3. "로그인" 탭에서 기존 계정으로 로그인합니다

### 🎲 2. 랜덤 채팅방 입장

1. 로그인 후 채팅방 목록 화면에서
2. "🎲 랜덤 채팅방 입장" 버튼을 탭합니다
3. 자동으로 랜덤 채팅방에 입장됩니다

### 💬 3. 채팅하기

1. 채팅방에 입장하면 실시간으로 메시지를 주고받을 수 있습니다
2. 하단 입력창에 메시지를 입력하고 전송 버튼을 탭합니다
3. 다른 사용자들의 메시지가 실시간으로 표시됩니다

### 🚪 4. 채팅방 나가기

1. 채팅방 상단의 나가기 버튼을 탭합니다
2. 확인 대화상자에서 "나가기"를 선택합니다

## 🔌 서버 연결

앱은 다음 서버와 연결됩니다:

- **서버 주소**: `http://localhost:7070`
- **WebSocket**: `ws://localhost:7070/ws/chat`

서버가 실행 중이어야 앱이 정상적으로 작동합니다.

## 🎨 디자인 특징

- **Material Design 3**: 최신 구글 디자인 시스템 적용
- **반응형 UI**: 다양한 화면 크기에 대응
- **다크/라이트 테마**: 시스템 설정에 따른 자동 테마 변경
- **애니메이션**: 부드러운 전환 효과
- **접근성**: 스크린 리더 지원

## 🛠️ 개발 가이드

### 새로운 기능 추가

1. `models/`에 데이터 모델 정의
2. `services/`에 API 서비스 구현
3. `providers/`에 상태 관리 로직 추가
4. `screens/`에 새로운 화면 구현
5. `widgets/`에 재사용 가능한 위젯 생성

### 코드 스타일

- Dart 공식 스타일 가이드 준수
- 의미있는 변수/함수명 사용
- 주석을 통한 코드 문서화
- 에러 처리 및 예외 상황 고려
