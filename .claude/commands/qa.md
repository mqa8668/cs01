# QA Command

Validate implementation quality across the codebase.

## Usage
```
/qa [optional: specific area to check]
```

## Arguments
- `$ARGUMENTS` - (Optional) Specific feature or area to QA. If empty, runs full QA.

## Instructions

You are performing quality assurance on a **Flutter mobile app** with **Firebase/Supabase backend**.

### QA Checklist

#### 1. Code Quality

```bash
# Run Flutter analyzer
flutter analyze

# Check formatting
dart format --set-exit-if-changed lib/

# Check for unused imports/code
dart fix --dry-run
```

**Manual Code Review:**
- [ ] No hardcoded strings (use localization)
- [ ] No hardcoded colors (use theme)
- [ ] Proper error handling in async code
- [ ] No print statements in production code
- [ ] Proper dispose() calls for controllers
- [ ] Keys on list items and animated widgets

#### 2. Testing Coverage

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
```

**Test Requirements:**
- [ ] Widget tests for main screens
- [ ] Unit tests for business logic
- [ ] Repository tests with mocked data
- [ ] BLoC/Provider tests for state management

#### 3. Performance Checks

**Animation Performance (Critical for this app):**
- [ ] Neural Map: Node glow animations smooth at 60fps
- [ ] Mind Garden: Flower sway + shooting stars don't cause jank
- [ ] Transitions: Screen transitions are fluid
- [ ] Scroll: Lists scroll without lag

**Memory & Resources:**
- [ ] No memory leaks (dispose controllers, cancel streams)
- [ ] Images are properly cached
- [ ] Large lists use ListView.builder (lazy loading)

**Profile Commands:**
```bash
# Run in profile mode
flutter run --profile

# Check for rebuild issues
flutter run --debug --verbose
```

#### 4. Platform-Specific

**iOS Checks:**
- [ ] Runs on iOS Simulator
- [ ] Correct Info.plist permissions
- [ ] App icons and launch screen
- [ ] Safe area handling

**Android Checks:**
- [ ] Runs on Android Emulator
- [ ] Correct AndroidManifest permissions
- [ ] App icons and splash screen
- [ ] Back button handling

```bash
# Build for iOS
flutter build ios --debug

# Build for Android
flutter build apk --debug
```

#### 5. Firebase/Supabase Integration

- [ ] Authentication flows work (Google, Apple SSO)
- [ ] Data persists correctly to Firestore/Supabase
- [ ] Offline mode handles gracefully
- [ ] Security rules are properly configured

#### 6. Feature-Specific QA

**Neural Map:**
- [ ] All 35 nodes render correctly
- [ ] Node states update after test completion
- [ ] Glow/fade animations are smooth
- [ ] Layout matches design

**Test + Scoring:**
- [ ] Multiple choice works correctly
- [ ] Scoring calculates properly (On/Off/Mid)
- [ ] History saves and displays by date
- [ ] Results update Neural Map

**Mind Garden:**
- [ ] Dark mode displays correctly
- [ ] 31 flowers for 31 days
- [ ] Quick questions flow works
- [ ] Background animations (stars, flowers) are smooth
- [ ] Tapping flower shows diary entry

**Mini Diary:**
- [ ] Can save daily notes
- [ ] Local + cloud sync works
- [ ] Diary links to flower in garden

**Care Drops:**
- [ ] QR/ID sharing works
- [ ] Messages send and receive
- [ ] Block user works
- [ ] Report function works

#### 7. Localization (EN/VN)

- [ ] All strings are localized
- [ ] Language switching works
- [ ] No untranslated strings
- [ ] Text doesn't overflow in either language

```bash
# Check for missing translations
flutter gen-l10n
```

#### 8. Accessibility

- [ ] Semantic labels on interactive elements
- [ ] Sufficient color contrast
- [ ] Text scales with system settings
- [ ] Screen reader compatibility

### QA Report Format

Save QA results to `.claude/docs/qa-reports/YYYY-MM-DD-qa-report.md`:

```markdown
# QA Report
Date: YYYY-MM-DD

## Summary
- Total Issues: X
- Critical: X
- Major: X
- Minor: X

## Test Results
- flutter analyze: PASS/FAIL
- flutter test: X/Y passed
- iOS build: PASS/FAIL
- Android build: PASS/FAIL

## Issues Found

### Critical
1. [Issue description] - `file:line`

### Major
1. [Issue description] - `file:line`

### Minor
1. [Issue description] - `file:line`

## Performance Notes
- Neural Map FPS: XX
- Mind Garden FPS: XX
- Memory usage: XX MB

## Recommendations
1. [Recommendation]
2. [Recommendation]

## Sign-off
- [ ] Ready for TestFlight/Play Internal Testing
- [ ] Needs fixes before release
```

### Quick QA (for specific features)

If `$ARGUMENTS` specifies a feature:
1. Focus QA on that feature only
2. Run relevant tests only
3. Check feature-specific requirements
4. Output abbreviated report

Begin QA: $ARGUMENTS
