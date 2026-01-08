# Neural Map App - Development Workflows

This document describes the workflow commands for developing the Neural Map wellness app.

## Project Overview

| Aspect | Choice |
|--------|--------|
| **Framework** | Flutter (Dart) |
| **Backend** | Firebase/Supabase |
| **Platforms** | iOS + Android |
| **Aesthetic** | Pastel/cosmic fantasy, soft & calming |

### Features (MVP)
- **Neural Map**: 35 nodes with glow animations
- **Test + Scoring**: Multiple-choice tests, history by date
- **Mind Garden**: 31 flowers, dark mode, particle effects
- **Mini Diary**: Daily notes linked to garden
- **Care Drops**: 1:1 messaging via QR/ID

## Quick Start

```bash
# Research existing code or architecture
/research "how does the Neural Map animation work?"

# Plan a new feature
/plan "implement Neural Map with 35 nodes"

# Implement a planned feature
/implement "neural-map"

# Run quality assurance
/qa

# Do everything at once
/oneshot "add Google Sign-In authentication"
```

## Workflow Commands

### /research

**Purpose**: Document and explore the codebase to answer questions.

**Usage**:
```bash
/research "your question"
```

**Examples**:
```bash
/research "How is authentication implemented?"
/research "What's the Firebase schema for test results?"
/research "Mind Garden flower animation system"
```

**Output**: Creates documentation in `.claude/docs/research/YYYY-MM-DD-topic.md`

---

### /plan

**Purpose**: Create detailed implementation plans before coding.

**Usage**:
```bash
/plan "feature description"
```

**Examples**:
```bash
/plan "Implement Neural Map with 35 nodes and glow animation"
/plan "Add Google/Apple SSO authentication"
/plan "Build Care Drops QR code sharing flow"
```

**Output**: Creates plan in `.claude/docs/plans/YYYY-MM-DD-feature-name.md`

**Plan Structure**:
- Overview & Requirements
- Technical Approach (Architecture, Data Model, UI)
- Implementation Steps with acceptance criteria
- Testing Strategy
- Dependencies & Risks

---

### /implement

**Purpose**: Execute implementation plans with verification.

**Usage**:
```bash
/implement "plan-name"
# or
/implement "task description"
```

**Examples**:
```bash
/implement "neural-map"
/implement "Add loading spinner to test results screen"
```

**Process**:
1. Loads existing plan (or creates one for simple tasks)
2. Implements step-by-step with tracking
3. Runs `flutter analyze` and tests
4. Commits changes with conventional commit format

---

### /qa

**Purpose**: Validate implementation quality.

**Usage**:
```bash
/qa                      # Full QA
/qa "neural-map"         # Feature-specific QA
```

**Checks**:
- Code quality (`flutter analyze`, formatting)
- Test coverage
- Performance (60fps animations)
- Platform-specific (iOS/Android builds)
- Firebase/Supabase integration
- Feature-specific requirements
- Localization (EN/VN)
- Accessibility

**Output**: Creates report in `.claude/docs/qa-reports/YYYY-MM-DD-qa-report.md`

---

### /oneshot

**Purpose**: Complete workflow (research + plan + implement + QA) in one command.

**Usage**:
```bash
/oneshot "complete feature description"
```

**Examples**:
```bash
/oneshot "Add Google Sign-In authentication with Firebase"
/oneshot "Fix Mind Garden flower animation stuttering"
```

**Best for**: Well-defined features where requirements are clear.

---

## Project Structure (Recommended)

```
lib/
├── main.dart
├── app.dart                    # App configuration
├── core/
│   ├── constants/             # App-wide constants
│   ├── theme/                 # Pastel/cosmic theme
│   ├── utils/                 # Helpers
│   └── widgets/               # Shared widgets
├── features/
│   ├── auth/                  # Authentication
│   ├── neural_map/            # Neural Map feature
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── screens/
│   │       └── widgets/
│   ├── tests/                 # Test + Scoring
│   ├── mind_garden/           # Mind Garden
│   ├── diary/                 # Mini Diary
│   └── care_drops/            # Care Drops
├── l10n/                      # Localization (EN/VN)
└── services/
    ├── firebase/              # Firebase services
    └── local_storage/         # Local persistence
```

## Animation Guidelines

This app requires beautiful, smooth animations. Follow these patterns:

### Neural Map Node Glow
```dart
// Use CustomPainter for glow effects
class NodeGlowPainter extends CustomPainter {
  final double glowIntensity;
  final Color nodeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = nodeColor.withOpacity(glowIntensity)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20);
    canvas.drawCircle(center, radius * 1.5, paint);
  }
}
```

### Mind Garden Particles
```dart
// Use AnimationController for smooth 60fps
class FlowerSwayAnimation extends StatefulWidget {
  @override
  State<FlowerSwayAnimation> createState() => _FlowerSwayAnimationState();
}

class _FlowerSwayAnimationState extends State<FlowerSwayAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

## Documentation Locations

| Type | Location |
|------|----------|
| Workflow commands | `.claude/commands/` |
| Research docs | `.claude/docs/research/` |
| Implementation plans | `.claude/docs/plans/` |
| QA reports | `.claude/docs/qa-reports/` |
| This guide | `.claude/WORKFLOWS.md` |

## Useful Flutter Commands

```bash
# Development
flutter run                    # Run on connected device
flutter run --profile          # Run in profile mode (performance)

# Quality
flutter analyze               # Static analysis
flutter test                  # Run tests
flutter test --coverage       # With coverage report
dart format lib/              # Format code

# Build
flutter build ios --debug     # iOS debug build
flutter build apk --debug     # Android debug build
flutter build ios --release   # iOS release build
flutter build appbundle       # Android App Bundle

# Dependencies
flutter pub get               # Install packages
flutter pub upgrade           # Upgrade packages
flutter pub outdated          # Check for updates

# Clean
flutter clean                 # Clean build artifacts
flutter pub cache repair      # Repair pub cache
```

## Commit Convention

Use conventional commits:
- `feat(feature_name)`: New feature
- `fix(feature_name)`: Bug fix
- `refactor(feature_name)`: Code refactoring
- `style(feature_name)`: Formatting only
- `test(feature_name)`: Adding tests
- `docs(feature_name)`: Documentation

Examples:
```bash
git commit -m "feat(neural_map): add 35 nodes with glow animation"
git commit -m "fix(mind_garden): resolve flower animation jank on older devices"
git commit -m "refactor(auth): extract Firebase auth to repository pattern"
```

## Weekly Demo Checklist

Per the proposal milestones:
- [ ] W1: Setup + Auth + DB schema + base UI
- [ ] W2: Neural Map core + test flow basic
- [ ] W3: Test scoring complete + map update + history
- [ ] W4: Mind Garden core + quick questions + animations
- [ ] W5: Mini diary + local + cloud sync
- [ ] W6: Care Drops (QR/ID) + messaging + block/report
- [ ] W7: Admin CRUD + EN/VN + polish
- [ ] W8: QA + bugfix + TestFlight/Play Internal release
