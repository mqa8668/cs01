# Implement Command

Execute an implementation plan with verification at each step.

## Usage
```
/implement "plan-name or task description"
```

## Arguments
- `$ARGUMENTS` - Name of an existing plan file OR a task to implement directly

## Instructions

You are implementing features for a **Flutter mobile app** with **Firebase/Supabase backend**.

### Pre-Implementation Checklist

1. **Locate the Plan**
   - Check `.claude/docs/plans/` for a matching plan file
   - If no plan exists and task is complex, suggest running `/plan` first
   - For simple tasks, proceed directly

2. **Verify Prerequisites**
   - Required packages installed in `pubspec.yaml`
   - Firebase/Supabase properly configured
   - Related features are in working state

3. **Set Up Tracking**
   - Use TodoWrite to track implementation steps
   - Mark each step as you progress

### Implementation Guidelines

#### Flutter Best Practices

```dart
// File structure for a feature
lib/features/feature_name/
├── data/
│   ├── models/          # Data classes
│   ├── repositories/    # Data access layer
│   └── sources/         # Remote/local data sources
├── domain/
│   ├── entities/        # Business entities
│   └── usecases/        # Business logic
├── presentation/
│   ├── bloc/            # State management
│   ├── screens/         # Full screens
│   └── widgets/         # Feature-specific widgets
└── feature_name.dart    # Barrel file
```

#### Code Quality Standards

1. **Null Safety**: Use proper null handling (`?`, `!`, `??`)
2. **Const Constructors**: Use `const` where possible for performance
3. **Widget Keys**: Add keys for list items and animated widgets
4. **Error Handling**: Wrap Firebase calls in try-catch with proper error states
5. **Documentation**: Add dartdoc comments for public APIs

#### Animation Guidelines (Critical for this app)

```dart
// Use AnimationController for smooth 60fps animations
late final AnimationController _controller = AnimationController(
  duration: const Duration(milliseconds: 300),
  vsync: this,
);

// Use CustomPainter for Neural Map and Mind Garden
class NeuralMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Glow effect for nodes
  }
}
```

#### Firebase/Supabase Patterns

```dart
// Repository pattern for data access
class TestResultRepository {
  final FirebaseFirestore _firestore;

  Future<void> saveResult(TestResult result) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('test_results')
        .add(result.toJson());
  }
}
```

### Implementation Process

1. **For Each Step in the Plan:**
   - Read the step requirements
   - Implement the code changes
   - Run `flutter analyze` to check for issues
   - Test the implementation
   - Mark step as complete

2. **After Each Major Component:**
   - Run widget tests if applicable
   - Test on both iOS and Android simulators
   - Verify animations are smooth (60fps)

3. **Verification Commands:**
   ```bash
   # Check for issues
   flutter analyze

   # Run tests
   flutter test

   # Format code
   dart format lib/

   # Check on device
   flutter run
   ```

### Error Recovery

If implementation fails:
1. Check error message carefully
2. Verify dependencies in `pubspec.yaml`
3. Run `flutter clean && flutter pub get`
4. Check Firebase/Supabase configuration
5. Review related code for breaking changes

### Commit Strategy

After completing each logical unit:
```bash
git add .
git commit -m "feat(feature_name): description of change"
```

Follow conventional commits:
- `feat`: New feature
- `fix`: Bug fix
- `refactor`: Code refactoring
- `style`: Formatting, no code change
- `test`: Adding tests
- `docs`: Documentation

### Output

After implementation:
1. Update plan status to "Completed" or note blockers
2. List all files created/modified
3. Provide testing instructions
4. Note any follow-up tasks discovered

Begin implementing: $ARGUMENTS
