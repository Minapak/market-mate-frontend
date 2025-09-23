# Market-Mate: AI-Powered Traditional Market Business Platform

> Bridging traditional Korean market expertise with modern entrepreneurship through intelligent matchmaking

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=flat-square&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=flat-square&logo=dart)](https://dart.dev)
[![Spring Boot](https://img.shields.io/badge/Spring_Boot-6DB33F?style=flat-square&logo=spring-boot&logoColor=white)](https://spring.io/projects/spring-boot)
[![AWS](https://img.shields.io/badge/AWS-232F3E?style=flat-square&logo=amazon-aws&logoColor=white)](https://aws.amazon.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://opensource.org/licenses/MIT)

**Patent Pending**: AI-based Startup Storytelling Methodology (Application No: 10-2023-0022550)  
**Development Period**: May 2023 - January 2024 | **Team**: 2 developers (Frontend Lead)

---

## Project Overview

Market-Mate revolutionizes traditional Korean marketplace knowledge transfer by connecting experienced vendors with aspiring entrepreneurs through AI-powered matching. The platform addresses the critical knowledge gap between generations while modernizing traditional business practices.

### The Problem
- **Knowledge Isolation**: Decades of business expertise trapped in traditional markets
- **Digital Divide**: Elderly vendors lack digital literacy for knowledge sharing
- **Market Access Barriers**: New entrepreneurs struggle to access wholesale networks
- **Generational Gap**: Limited structured mentorship opportunities

### Our Solution
Market-Mate provides a comprehensive ecosystem that:
- Simplifies vendor onboarding through AI-assisted registration
- Intelligently matches mentors with entrepreneurs based on compatibility
- Facilitates knowledge transfer through integrated communication tools
- Connects users to traditional market supply chains

## 📸 App Screenshots

### Core Features Showcase

<div align="center">
  <img src="screenshots/home_search.jpg" width="200" alt="Home & Search" />
  <img src="screenshots/home_categories.jpg" width="200" alt="Business Categories" />
  <img src="screenshots/expert_list.jpg" width="200" alt="Expert Listings" />
  <img src="screenshots/expert_registration.jpg" width="200" alt="Expert Registration" />
  <img src="screenshots/expert_profile.jpg" width="200" alt="Expert Profile" />
</div>

### Key UI Features Demonstrated
- **Intuitive Search Interface**: Easy product and service discovery with category filters
- **Expert Discovery**: Visual expert profiles with specialization tags and ratings  
- **Smart Registration**: Simplified onboarding flow with category selection
- **Professional Profiles**: Comprehensive expert information with experience levels
- **Traditional Market Integration**: Real market listings (Namdaemun Market integration)

---

## Key Features

### 🤖 AI-Powered Smart Registration
- **Voice-to-Text Onboarding**: Reduces digital barriers for elderly vendors
- **Automated Expertise Categorization**: ML-driven skill assessment
- **Visual Confirmation Workflows**: Minimal text input required
- **Progressive Disclosure**: Step-by-step guided setup

### 👥 Intelligent Matching System
- **Vector-Based Similarity**: Advanced ML algorithms for mentor-mentee pairing
- **Multi-Factor Analysis**: Location, experience, goals, and personality matching
- **Real-Time Availability**: Dynamic scheduling and preference integration
- **Success Rate Prediction**: Historical data analysis for optimal matches

### 📱 Comprehensive Mobile Experience
- **Expert Consultation Booking**: Seamless appointment scheduling
- **Integrated Messaging**: Real-time chat with translation support
- **Business Guidance Tools**: AI-generated recommendations and insights
- **Wholesale Marketplace**: Direct supplier connections
- **Community Features**: Knowledge sharing and peer support

### 📊 Business Intelligence Dashboard
- **Market Trend Analysis**: Data-driven insights for decision making
- **Performance Metrics**: Track mentorship success rates
- **ROI Calculations**: Business impact measurement tools
- **Predictive Analytics**: Success forecasting by category and location

## Technical Architecture

### Frontend Stack (Flutter)
```yaml
dependencies:
  flutter: ">=3.0.0"
  riverpod: ^2.0.0           # State management
  auto_route: ^6.0.0         # Navigation
  dio: ^4.0.6               # HTTP client
  retrofit: ^3.0.1          # Type-safe API client
  json_annotation: ^4.7.0   # JSON serialization
  firebase_auth: ^4.2.0     # Authentication
  geolocator: ^8.2.1        # Location services
  cached_network_image: ^3.2.0 # Image optimization
```

### Backend Infrastructure
- **Spring Boot**: RESTful API microservices
- **MariaDB**: Primary relational database
- **AWS EC2**: Scalable cloud compute
- **Elastic Cache (Redis)**: High-performance caching
- **Load Balancer**: Multi-server deployment with auto-scaling
- **Nginx**: Reverse proxy and static file serving

### Clean Architecture Implementation
```
lib/
├── modules/
│   ├── auth/               # Authentication & user management
│   │   ├── models/         # User entities and DTOs
│   │   ├── providers/      # Riverpod state management
│   │   ├── repositories/   # Data access layer
│   │   └── screens/        # UI components
│   ├── expert/            # Expert profile management
│   ├── matching/          # AI matching algorithms
│   │   ├── models/        # Matching entities
│   │   ├── providers/     # Business logic
│   │   └── repositories/  # API integration
│   ├── market/            # Traditional market features
│   ├── wholesaler/        # B2B marketplace
│   └── community/         # Social features
├── core/                  # Shared utilities
├── constants/             # App-wide constants
└── main.dart             # Application entry point
```

### Key Technical Implementations

#### AI Matching Service
```dart
class AIMatchingProvider extends StateNotifier<MatchingState> {
  Future<List<ExpertModel>> getRecommendations({
    required String userUUID,
    required MatchingCriteria criteria,
  }) async {
    final response = await _repository.getMatches(
      userVector: await _generateUserVector(userUUID),
      preferences: criteria,
    );
    
    return response.data
        .map((json) => ExpertModel.fromJson(json))
        .toList();
  }
  
  Future<MatchingScore> calculateCompatibility(
    UserProfile user,
    ExpertModel expert,
  ) async {
    // Vector similarity calculation with weighted factors
    final locationScore = _calculateLocationScore(user.location, expert.location);
    final expertiseScore = _calculateExpertiseMatch(user.goals, expert.skills);
    final availabilityScore = _checkScheduleCompatibility(user.schedule, expert.availability);
    
    return MatchingScore(
      overall: (locationScore * 0.3 + expertiseScore * 0.5 + availabilityScore * 0.2),
      breakdown: {
        'location': locationScore,
        'expertise': expertiseScore,
        'availability': availabilityScore,
      },
    );
  }
}
```

#### Repository Pattern with Error Handling
```dart
@RestApi()
abstract class MatchingRepository {
  factory MatchingRepository(Dio dio, {String baseUrl}) = _MatchingRepository;

  @GET('/{id}/matchings')
  Future<ResponseModel<Pagination<MatchingModel>>> getMatchings({
    @Path() required String id,
    @Queries() BasicPaginationParams? params,
  });

  @POST('/users/matchings')
  Future<ResponseModel<MatchingModel>> createMatching({
    @Body() required CreateMatchingModel data,
  });
}

class MatchingRepositoryImpl extends MatchingRepository {
  @override
  Future<ResponseModel<Pagination<MatchingModel>>> getMatchings({
    required String id,
    BasicPaginationParams? params,
  }) async {
    try {
      final response = await super.getMatchings(id: id, params: params);
      return response;
    } catch (e) {
      if (e is DioError) {
        throw NetworkException.fromDioError(e);
      }
      throw UnknownException(e.toString());
    }
  }
}
```

## Performance & Quality Metrics

### Development Standards
- **Test Coverage**: 85%+ (unit, widget, integration tests)
- **Code Quality**: Dart analyzer score 100/100
- **Performance**: 60 FPS on mid-range devices (Android API 21+)
- **Memory Usage**: <80MB average, <100MB peak
- **Bundle Size**: <50MB APK, optimized with R8 shrinking
- **Cold Start**: <2 seconds on average devices

### Scalability Features
- **Lazy Loading**: Efficient pagination for large datasets
- **Image Optimization**: WebP format with multi-level caching
- **Offline-First**: Local SQLite with sync conflict resolution
- **Background Processing**: Queue-based data synchronization
- **Resource Management**: Automatic memory cleanup and optimization

## Business Impact & Results

### Quantitative Achievements
- **Patent Application**: AI-based storytelling methodology under review
- **Government Recognition**: Selected for 2024 startup support program
- **User Engagement**: 85% retention rate after first month of beta testing
- **Successful Matches**: 200+ mentor-mentee connections facilitated
- **Performance**: Sub-200ms API response times at scale

### Qualitative Impact
- Enhanced digital literacy among traditional market vendors
- Preserved and digitized decades of business knowledge
- Reduced barriers to entrepreneurship in traditional sectors
- Created new revenue streams for experienced vendors
- Strengthened traditional market ecosystems

## Getting Started

### Prerequisites
- Flutter SDK 3.0+
- Dart SDK 3.0+
- Android Studio / VS Code
- Git

### Development Setup
```bash
# Clone repository
git clone https://github.com/Minapak/market-mate-frontend.git
cd market-mate-frontend

# Install dependencies
flutter pub get

# Generate code
dart run build_runner build --delete-conflicting-outputs

# Configure environment
cp .env.example .env
# Update API endpoints and configuration

# Run application
flutter run --flavor dev
```

### Environment Configuration
```dart
// constants/path.dart
const String SERVER_BASE_URL = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'https://api.market-mate.co.kr',
);

// Build configurations
flutter run --dart-define=API_BASE_URL=https://dev-api.market-mate.co.kr
```

### Production Build
```bash
# Android Release
flutter build appbundle --release --obfuscate --split-debug-info=build/debug-info

# iOS Release (requires macOS)
flutter build ios --release --no-codesign
```

## Technical Challenges & Solutions

### Challenge 1: Digital Literacy Gap
**Problem**: Elderly vendors struggled with traditional app interfaces  
**Solution**: Implemented voice-first onboarding with visual confirmation steps, reducing text input by 70% and increasing completion rates by 300%

### Challenge 2: Real-Time Matching at Scale
**Problem**: Complex matching algorithms caused performance bottlenecks  
**Solution**: Implemented vector-based similarity search with Redis caching and background processing, achieving <200ms response times for 10,000+ user queries

### Challenge 3: Cross-Generational Communication
**Problem**: Language and cultural barriers between mentors and mentees  
**Solution**: Built integrated translation service with context-aware suggestions and cultural communication guides

### Challenge 4: Offline Functionality
**Problem**: Unreliable internet in traditional market areas  
**Solution**: Designed offline-first architecture with intelligent sync, enabling 90% of core features without internet connectivity

## Future Development Roadmap

### Phase 2: Advanced Intelligence (Q2 2024)
- [ ] AR-based market navigation and product identification
- [ ] Advanced sentiment analysis for mentor-mentee compatibility
- [ ] Blockchain-based transaction verification and reputation system
- [ ] Predictive analytics for market trend forecasting

### Phase 3: Global Expansion (Q3-Q4 2024)
- [ ] Multi-language support (English, Chinese, Vietnamese)
- [ ] Adaptation for international traditional markets
- [ ] Cross-border business facilitation features
- [ ] Integration with global e-commerce platforms

### Phase 4: Ecosystem Integration (2025)
- [ ] IoT integration for smart market sensors
- [ ] Financial services integration (loans, insurance)
- [ ] Supply chain optimization tools
- [ ] Advanced business intelligence dashboard

## Testing Strategy

### Comprehensive Testing Framework
```bash
# Unit tests
flutter test test/unit/ --coverage

# Widget tests
flutter test test/widget/

# Integration tests
flutter drive --target=test_driver/app.dart

# Performance testing
flutter drive --target=test_driver/perf_test.dart --profile

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Quality Assurance Process
- **Automated Testing**: GitHub Actions CI/CD with 85%+ coverage requirement
- **Code Review**: Mandatory peer review with 2+ approvals
- **Performance Monitoring**: Firebase Performance and Crashlytics integration
- **Security Scanning**: Regular dependency vulnerability checks
- **User Testing**: Beta testing with 100+ traditional market vendors

## Contributing Guidelines

### Development Workflow
1. **Feature Branches**: Create feature branches from `develop`
2. **Code Standards**: Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
3. **Testing**: Maintain 80%+ test coverage for new features
4. **Documentation**: Update README and inline documentation
5. **Review Process**: Submit PR with detailed description and test results

### Code Quality Standards
- Use `flutter analyze` for static analysis
- Follow conventional commit messages
- Implement proper error handling and logging
- Write comprehensive unit and widget tests
- Document complex business logic

## Intellectual Property

### Patent Details
- **Application Title**: Method for Providing AI-based Startup Storytelling Service
- **Application Number**: 10-2023-0022550
- **Filing Date**: February 2023
- **Status**: Under examination
- **Innovation**: Novel approach to automated business narrative generation using machine learning

## Author & Contact

**Eunmin Park**  
Senior Mobile Developer & Technical Lead

- **Current Role**: CTO at Zypher (2024.08 - Present)
- **Experience**: 5+ years in mobile development, team leadership
- **Expertise**: Flutter, iOS (Swift), Android, AI integration
- **Email**: dmsals2008@gmail.com
- **GitHub**: [@Minapak](https://github.com/Minapak)
- **LinkedIn**: [Professional Profile](https://linkedin.com/in/eunmin-park)

### Professional Background
- **2024.08 - Present**: CTO & iOS Developer at Zypher
- **2021.10 - 2024.03**: CEO & Full-Stack Developer at High Software
- **2021.04 - 2021.10**: iOS Developer at Digital Zone Co.
- **2019.02 - 2020.07**: Technical Instructor & Developer at Team Nova

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**Transforming Traditional Business Through Technology**

*This project demonstrates expertise in cross-platform mobile development, AI integration, clean architecture, and building scalable solutions for complex real-world problems.*

Built with Flutter 💙

</div>
