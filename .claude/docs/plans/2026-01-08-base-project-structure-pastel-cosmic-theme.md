# Plan: Base Project Structure with Pastel/Cosmic Theme
Date: 2026-01-08
Status: Completed

## Overview
Set up the foundational Flutter project structure with a pastel/cosmic fantasy theme inspired by the provided reference image. The theme features neural network brain imagery with soft gradients (cyan, pink, purple) for light mode and deep space backgrounds with glowing nodes for dark mode.

## Requirements
- [ ] Clean architecture folder structure (feature-first + core layers)
- [ ] Theme system supporting light (pastel) and dark (cosmic) modes
- [ ] Color palette extracted from reference image
- [ ] Base typography with fantasy-inspired fonts
- [ ] Core utility widgets for gradients, glows, and particles
- [ ] State management foundation (Riverpod)
- [ ] Navigation setup (GoRouter)
- [ ] Essential package dependencies

## Out of Scope (MVP)
- Firebase/Supabase integration (separate plan)
- Feature-specific implementations (Neural Map, Mind Garden, etc.)
- Custom icon sets
- Internationalization

## Technical Approach

### Architecture
Clean Architecture with feature-first organization:
```
lib/
├── core/                    # Shared infrastructure
│   ├── theme/               # ThemeData, colors, typography
│   ├── widgets/             # Reusable UI components
│   ├── utils/               # Helpers, extensions
│   ├── router/              # GoRouter configuration
│   └── constants/           # App-wide constants
├── features/                # Feature modules
│   ├── neural_map/
│   ├── test_scoring/
│   ├── mind_garden/
│   ├── mini_diary/
│   ├── care_drops/
│   └── home/                # Main navigation shell
└── main.dart
```

### Color Palette (Extracted from Reference)

**Light Mode (Pastel):**
```dart
// Primary gradient: Soft cyan → pink → lavender
static const pastelCyan = Color(0xFF8FE8E8);      // Neural glow cyan
static const pastelPink = Color(0xFFF5B8C8);      // Soft rose
static const pastelLavender = Color(0xFFE0D4F7);  // Light purple
static const pastelMist = Color(0xFFF8F4FF);      // Background
static const nodeGlow = Color(0xFFFFFFFF);        // White node centers

// Accent colors
static const accentCoral = Color(0xFFFFB5A7);     // Warm accent
static const accentSky = Color(0xFF9ED8E8);       // Cool accent
```

**Dark Mode (Cosmic):**
```dart
// Primary: Deep space with nebula colors
static const cosmicDeep = Color(0xFF0D0B1E);      // Deep space background
static const cosmicPurple = Color(0xFF4A2C7A);    // Nebula purple
static const cosmicBlue = Color(0xFF1E3A5F);      // Deep blue
static const starGlow = Color(0xFFE8E4FF);        // Star/node glow

// Neural network colors
static const neuralCyan = Color(0xFF00D4FF);      // Bright cyan nodes
static const neuralPink = Color(0xFFFF69B4);      // Pink/magenta nodes
static const neuralPurple = Color(0xFFAA80FF);    // Purple connections
static const neuralWhite = Color(0xFFFFFFFF);     // Core glow
```

### Typography
```dart
// Fantasy-inspired with good readability
// Primary: 'Quicksand' or 'Nunito' (soft, rounded)
// Accent: 'Comfortaa' for headers
// Fallback: System sans-serif
```

### Data Model
```dart
// Theme mode enum
enum AppThemeMode { light, dark, system }

// Theme state
class ThemeState {
  final AppThemeMode mode;
  final bool useCosmicAnimations;
}
```

### UI Components
- `CosmicBackground`: Animated starfield/gradient background
- `GlowContainer`: Container with customizable glow effect
- `GradientText`: Text with gradient fill
- `PastelCard`: Soft-edged card with subtle shadow
- `NeuralGlowNode`: Animated glowing node widget

## Implementation Steps

### Step 1: Project Structure & Dependencies
**Goal**: Create folder structure and add required packages
**Files**:
- `pubspec.yaml` - Update dependencies
- `lib/` - Create folder structure
**Tasks**:
- [ ] Create directory structure under `lib/`
- [ ] Add dependencies: `flutter_riverpod`, `go_router`, `google_fonts`
- [ ] Run `flutter pub get`
**Acceptance**: All directories exist, dependencies installed successfully

### Step 2: Color System
**Goal**: Define the complete color palette
**Files**:
- `lib/core/theme/app_colors.dart` - Create color constants
**Tasks**:
- [ ] Define `AppColors` class with light/dark palettes
- [ ] Add gradient presets for common use cases
- [ ] Include semantic color mappings (success, error, etc.)
**Acceptance**: Colors accessible via `AppColors.light.*` and `AppColors.dark.*`

### Step 3: Typography System
**Goal**: Set up font families and text styles
**Files**:
- `lib/core/theme/app_typography.dart` - Create typography constants
- `pubspec.yaml` - Add font assets (if bundling)
**Tasks**:
- [ ] Define `AppTypography` class with text theme
- [ ] Create light and dark text style variants
- [ ] Use Google Fonts for 'Quicksand' and 'Comfortaa'
**Acceptance**: Typography scales properly across screen sizes

### Step 4: Theme Configuration
**Goal**: Create complete ThemeData for light and dark modes
**Files**:
- `lib/core/theme/app_theme.dart` - Main theme configuration
- `lib/core/theme/theme.dart` - Barrel export
**Tasks**:
- [ ] Create `AppTheme.light()` method returning ThemeData
- [ ] Create `AppTheme.dark()` method returning ThemeData
- [ ] Configure component themes (AppBar, Card, Button, etc.)
- [ ] Set up theme extensions for custom properties
**Acceptance**: Both themes render correctly with all components

### Step 5: Theme State Management
**Goal**: Implement theme switching with Riverpod
**Files**:
- `lib/core/theme/theme_provider.dart` - Theme state provider
**Tasks**:
- [ ] Create `themeProvider` StateNotifierProvider
- [ ] Implement theme persistence (shared_preferences later)
- [ ] Support system theme detection
**Acceptance**: Theme can be toggled and persists across app restart (manual verification)

### Step 6: Base Widgets - Backgrounds
**Goal**: Create animated background widgets
**Files**:
- `lib/core/widgets/cosmic_background.dart` - Starfield/gradient background
- `lib/core/widgets/pastel_background.dart` - Soft gradient background
**Tasks**:
- [ ] Implement `CosmicBackground` with subtle star particles
- [ ] Implement `PastelBackground` with soft gradient mesh
- [ ] Ensure 60fps performance with AnimationController
**Acceptance**: Backgrounds animate smoothly without jank

### Step 7: Base Widgets - Glow Effects
**Goal**: Create reusable glow and shimmer widgets
**Files**:
- `lib/core/widgets/glow_container.dart` - Container with glow
- `lib/core/widgets/neural_glow_node.dart` - Pulsing glow node
**Tasks**:
- [ ] Implement `GlowContainer` with customizable color/blur
- [ ] Implement `NeuralGlowNode` with pulse animation
- [ ] Add parameters for intensity, color, animation speed
**Acceptance**: Glow effects match reference image aesthetic

### Step 8: Base Widgets - Cards & Containers
**Goal**: Create themed card widgets
**Files**:
- `lib/core/widgets/pastel_card.dart` - Soft-edged card
- `lib/core/widgets/gradient_text.dart` - Text with gradient
- `lib/core/widgets/widgets.dart` - Barrel export
**Tasks**:
- [ ] Implement `PastelCard` with frosted glass effect option
- [ ] Implement `GradientText` widget
- [ ] Create barrel export for all widgets
**Acceptance**: Cards have consistent styling in both themes

### Step 9: Router Setup
**Goal**: Configure GoRouter with shell navigation
**Files**:
- `lib/core/router/app_router.dart` - Router configuration
- `lib/core/router/routes.dart` - Route constants
**Tasks**:
- [ ] Define route constants for all features
- [ ] Configure GoRouter with ShellRoute for bottom nav
- [ ] Add placeholder routes for main features
**Acceptance**: Navigation between placeholder screens works

### Step 10: Feature Scaffolding
**Goal**: Create placeholder screens for each feature
**Files**:
- `lib/features/home/presentation/home_shell.dart` - Main shell with nav
- `lib/features/neural_map/presentation/neural_map_screen.dart`
- `lib/features/test_scoring/presentation/test_screen.dart`
- `lib/features/mind_garden/presentation/garden_screen.dart`
- `lib/features/mini_diary/presentation/diary_screen.dart`
- `lib/features/care_drops/presentation/care_drops_screen.dart`
**Tasks**:
- [ ] Create `HomeShell` with BottomNavigationBar
- [ ] Create placeholder screens for each feature
- [ ] Apply themed backgrounds to each screen
**Acceptance**: All 5 main sections accessible via bottom navigation

### Step 11: Main App Integration
**Goal**: Wire everything together in main.dart
**Files**:
- `lib/main.dart` - Update with providers and router
**Tasks**:
- [ ] Wrap app with ProviderScope
- [ ] Configure MaterialApp.router with GoRouter
- [ ] Apply theme from provider
- [ ] Remove default counter app code
**Acceptance**: App launches with themed home screen and navigation

### Step 12: Verification & Polish
**Goal**: Ensure quality and consistency
**Files**: Various
**Tasks**:
- [ ] Test light/dark mode switching
- [ ] Verify animations run at 60fps (DevTools)
- [ ] Check theme consistency across all screens
- [ ] Fix any visual inconsistencies
**Acceptance**: Theme matches reference image aesthetic, smooth animations

## Testing Strategy
- Widget tests for: Theme switching, color consistency
- Golden tests for: Key screens in both light/dark modes
- Manual testing checklist:
  - [ ] Light mode matches pastel reference
  - [ ] Dark mode matches cosmic reference
  - [ ] Theme toggle works smoothly
  - [ ] Animations don't cause frame drops
  - [ ] Navigation works correctly

## Dependencies
```yaml
dependencies:
  flutter_riverpod: ^2.4.9      # State management
  go_router: ^13.0.0            # Navigation
  google_fonts: ^6.1.0          # Typography

dev_dependencies:
  riverpod_lint: ^2.3.7         # Linting for Riverpod
  golden_toolkit: ^0.15.0       # Golden tests (optional)
```

## Risks & Mitigations
| Risk | Impact | Mitigation |
|------|--------|------------|
| Performance issues with animated backgrounds | High | Use CustomPainter with RepaintBoundary, limit particle count |
| Google Fonts network dependency | Medium | Bundle fonts locally for production |
| Theme inconsistency across widgets | Medium | Create comprehensive theme extensions |

## Estimated Complexity
- [x] Large (1-2 days)

## Visual Reference Notes

From the screenshot analysis:

**Light Mode (Left side):**
- Very soft, almost white background with subtle pink/lavender tint
- Brain network rendered with soft cyan-to-pink gradient
- Nodes are small white/cyan glowing points
- Connections are thin, pastel-colored lines
- Overall ethereal, dreamy aesthetic

**Dark Mode (Right side):**
- Deep space blue/purple background (#0D0B1E range)
- Subtle star particles in background
- Brain network with vivid cyan and magenta glows
- Nodes have bright center with soft glow halos
- Connections are more visible with purple/blue tints
- Mystical, cosmic atmosphere

The key to nailing this aesthetic is:
1. Subtle gradients (avoid harsh color transitions)
2. Glow effects using BoxShadow with blur
3. Low-opacity overlays for depth
4. Particle effects for cosmic feel in dark mode
