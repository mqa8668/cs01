# Research Command

Research and document the codebase to answer questions or explore architecture.

## Usage
```
/research "your question or topic"
```

## Arguments
- `$ARGUMENTS` - The question to answer or topic to research

## Instructions

You are researching a **Flutter mobile app** with **Firebase/Supabase backend** for a wellness/mental health application featuring:
- Neural Map (35 nodes with animations)
- Test + Scoring system
- Mind Garden (dark mode, 31 flowers, animations)
- Mini Diary
- Care Drops (1:1 messaging)
- Admin Dashboard

### Research Process

1. **Understand the Question**
   - Parse `$ARGUMENTS` to understand what needs to be researched
   - Identify if this is about: architecture, specific feature, Flutter/Dart code, Firebase setup, or general codebase

2. **Explore the Codebase**
   - Use Glob to find relevant files
   - Use Grep to search for patterns, class names, or keywords
   - Read key files to understand implementation

3. **Flutter-Specific Areas to Check**
   ```
   lib/
   ├── main.dart                 # App entry point
   ├── core/                     # Shared utilities, constants, themes
   ├── features/                 # Feature modules
   │   ├── neural_map/          # Neural Map feature
   │   ├── tests/               # Test + Scoring
   │   ├── mind_garden/         # Mind Garden
   │   ├── diary/               # Mini Diary
   │   └── care_drops/          # Care Drops messaging
   ├── models/                   # Data models
   ├── services/                 # Firebase/API services
   └── widgets/                  # Reusable widgets
   ```

4. **Document Findings**
   - Create/update documentation in `.claude/docs/research/`
   - Use naming convention: `YYYY-MM-DD-topic-name.md`
   - Include code references with file paths and line numbers

### Output Format

Save research findings to `.claude/docs/research/` with this structure:

```markdown
# Research: [Topic Name]
Date: YYYY-MM-DD

## Question
[Original question from $ARGUMENTS]

## Summary
[2-3 sentence summary of findings]

## Detailed Findings

### [Section 1]
[Details with code references like `lib/features/neural_map/neural_map_screen.dart:45`]

### [Section 2]
[More details...]

## Key Files
- `path/to/file.dart` - Description
- `path/to/another.dart` - Description

## Recommendations
[If applicable, any suggestions for improvements or next steps]
```

### Example Queries

- `/research "How does the Neural Map animation work?"`
- `/research "What's the Firebase schema for test results?"`
- `/research "How is authentication implemented?"`
- `/research "Mind Garden flower animation system"`

Begin researching: $ARGUMENTS
