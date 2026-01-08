# Plan Command

Create a detailed implementation plan for a feature or task.

## Usage
```
/plan "feature or task description"
```

## Arguments
- `$ARGUMENTS` - Description of the feature or task to plan

## Instructions

You are planning for a **Flutter mobile app** with **Firebase/Supabase backend**. This is a wellness app with:
- Neural Map (35 nodes, glow animations)
- Test + Scoring (multiple-choice, history)
- Mind Garden (31 flowers, dark mode, particle effects)
- Mini Diary (daily notes)
- Care Drops (1:1 QR-based messaging)
- Admin Dashboard

### Planning Process

1. **Understand Requirements**
   - Parse `$ARGUMENTS` to understand the feature/task
   - Ask clarifying questions if requirements are ambiguous
   - Reference the proposal scope for MVP boundaries

2. **Research Current State**
   - Check existing code structure
   - Identify dependencies and related features
   - Note any existing patterns to follow

3. **Create Implementation Plan**
   - Break down into small, testable steps
   - Consider Flutter best practices (BLoC/Riverpod, clean architecture)
   - Include Firebase/Supabase integration points
   - Account for iOS and Android specifics

4. **Define Acceptance Criteria**
   - What defines "done" for each step
   - Testing requirements (widget tests, integration tests)
   - Performance considerations (animations at 60fps)

### Plan Structure

Save plans to `.claude/docs/plans/` with naming: `YYYY-MM-DD-feature-name.md`

```markdown
# Plan: [Feature Name]
Date: YYYY-MM-DD
Status: Draft | Approved | In Progress | Completed

## Overview
[2-3 sentences describing what this plan accomplishes]

## Requirements
- [ ] Requirement 1
- [ ] Requirement 2

## Out of Scope (MVP)
- Item deferred to phase 2
- Another deferred item

## Technical Approach

### Architecture
[How this fits into the app architecture]

### Data Model
```dart
// Firestore/Supabase schema
class ModelName {
  // fields
}
```

### UI Components
- Widget 1: Description
- Widget 2: Description

## Implementation Steps

### Step 1: [Name]
**Goal**: What this step accomplishes
**Files**:
- `lib/path/to/file.dart` - Create/modify
**Tasks**:
- [ ] Task 1.1
- [ ] Task 1.2
**Acceptance**: How to verify completion

### Step 2: [Name]
...

## Testing Strategy
- Widget tests for: X, Y, Z
- Integration tests for: A, B
- Manual testing checklist

## Dependencies
- Packages needed: `package_name: ^version`
- Firebase services: Auth, Firestore, etc.

## Risks & Mitigations
| Risk | Impact | Mitigation |
|------|--------|------------|
| Risk 1 | High/Med/Low | How to handle |

## Estimated Complexity
- [ ] Small (1-2 hours)
- [ ] Medium (half day)
- [ ] Large (1-2 days)
- [ ] XL (multiple days)
```

### Flutter-Specific Considerations

1. **State Management**: Use BLoC or Riverpod consistently
2. **Navigation**: GoRouter for declarative routing
3. **Animations**: AnimationController + CustomPainter for complex effects
4. **Theming**: Respect the pastel/cosmic fantasy aesthetic
5. **Performance**: Keep animations at 60fps, lazy load where possible

### Example Plans

- `/plan "Implement Neural Map with 35 nodes and glow animation"`
- `/plan "Add Google/Apple SSO authentication"`
- `/plan "Create Mind Garden flower animation system"`
- `/plan "Build Care Drops QR code sharing flow"`

Begin planning: $ARGUMENTS
