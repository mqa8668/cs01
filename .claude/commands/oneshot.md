# Oneshot Command

Complete workflow: Research, Plan, Implement, and QA in one command.

## Usage
```
/oneshot "feature or task description"
```

## Arguments
- `$ARGUMENTS` - Complete description of the feature or task

## Instructions

You are executing a complete workflow for a **Flutter mobile app** with **Firebase/Supabase backend**.

This command combines all workflow steps into a single execution. Use this for well-defined features where you have enough context to proceed autonomously.

### Workflow Steps

#### Phase 1: Research (Quick)
1. Understand the request from `$ARGUMENTS`
2. Search codebase for related code
3. Identify dependencies and patterns to follow
4. Note any blockers or questions

**Skip if**: Simple feature or clear requirements

#### Phase 2: Plan
1. Create implementation plan
2. Break into small, testable steps
3. Define acceptance criteria
4. Save plan to `.claude/docs/plans/`

**Plan naming**: `YYYY-MM-DD-feature-name.md`

#### Phase 3: Implement
1. Follow the plan step-by-step
2. Use TodoWrite to track progress
3. Write Flutter code following best practices:
   - Clean architecture (data/domain/presentation)
   - BLoC or Riverpod for state
   - CustomPainter for animations
   - Proper error handling
4. Run `flutter analyze` after major changes
5. Commit after logical units

#### Phase 4: QA
1. Run `flutter analyze`
2. Run `flutter test`
3. Verify feature works as expected
4. Check animations are 60fps
5. Test on both platforms
6. Document any issues

### Decision Points

At each phase, evaluate:
- **Blocker found?** Stop and ask user
- **Ambiguous requirement?** Ask for clarification
- **Major architectural decision?** Get user approval
- **Tests failing?** Fix before proceeding

### Output Format

```markdown
# Oneshot: [Feature Name]
Date: YYYY-MM-DD

## Summary
[What was accomplished]

## Research Findings
[Key discoveries, if any]

## Plan
[Link to plan file]

## Implementation
### Files Created
- `path/to/file.dart` - Description

### Files Modified
- `path/to/file.dart` - What changed

## QA Results
- flutter analyze: PASS/FAIL
- flutter test: PASS/FAIL
- Manual testing: PASS/FAIL

## Issues
[Any issues found and their status]

## Next Steps
[Follow-up tasks, if any]
```

### Example Usage

```bash
# Full feature
/oneshot "Add Google Sign-In authentication with Firebase"

# Small feature
/oneshot "Add loading indicator to Neural Map screen"

# Bug fix
/oneshot "Fix Mind Garden flower animation stuttering on older devices"
```

### Guardrails

**DO:**
- Ask questions when uncertain
- Test thoroughly
- Follow existing patterns
- Keep commits atomic

**DON'T:**
- Make major architectural changes without approval
- Skip testing
- Ignore analyzer warnings
- Over-engineer simple features

Begin oneshot workflow: $ARGUMENTS
