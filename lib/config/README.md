# Theme Configuration

This directory contains the centralized theme configuration for the M.S.IN Bourse en Ligne app.

## Files

### `theme.dart`
Contains all color definitions and theme configurations for both light and dark modes.

## Usage

### 1. Using Theme Colors

Instead of hardcoding colors, use the `AppColors` class:

```dart
// ❌ Don't do this
Container(
  color: Color(0xFF1565C0),
)

// ✅ Do this
Container(
  color: AppColors.primary,
)
```

### 2. Accessing Theme-Aware Colors

Use `Theme.of(context)` to get colors that automatically adapt to light/dark mode:

```dart
Widget build(BuildContext context) {
  return Text(
    'Hello',
    style: TextStyle(
      color: Theme.of(context).colorScheme.onSurface, // Auto adapts
    ),
  );
}
```

### 3. Checking Current Theme Mode

```dart
final isDarkMode = Theme.of(context).brightness == Brightness.dark;

// Use for conditional styling
final textColor = isDarkMode 
    ? AppColors.textPrimaryDark 
    : AppColors.textPrimaryLight;
```

### 4. Using Predefined Text Styles

```dart
Text(
  'Title',
  style: Theme.of(context).textTheme.headlineLarge,
)

Text(
  'Body text',
  style: Theme.of(context).textTheme.bodyMedium,
)
```

## Available Colors

### Primary Colors
- `AppColors.primary` - Main blue (#1565C0)
- `AppColors.primaryLight` - Lighter blue (#1976D2)
- `AppColors.primaryDark` - Darker blue (#0D47A1)

### Background Colors
**Light Mode:**
- `AppColors.backgroundLight` - White
- `AppColors.surfaceLight` - Light gray (#F8FAFC)
- `AppColors.cardLight` - White

**Dark Mode:**
- `AppColors.backgroundDark` - Dark blue (#0A0E21)
- `AppColors.surfaceDark` - Dark surface (#1A1F3A)
- `AppColors.cardDark` - Dark card (#1A1F3A)

### Text Colors
**Light Mode:**
- `AppColors.textPrimaryLight` - Dark text (#0A0E21)
- `AppColors.textSecondaryLight` - Gray text (#64748B)
- `AppColors.textTertiaryLight` - Light gray (#94A3B8)

**Dark Mode:**
- `AppColors.textPrimaryDark` - White
- `AppColors.textSecondaryDark` - Light gray (#B0B8C8)
- `AppColors.textTertiaryDark` - Gray (#64748B)

### Status Colors
- `AppColors.success` - Green (#10B981)
- `AppColors.error` - Red (#EF4444)
- `AppColors.warning` - Orange (#F59E0B)
- `AppColors.info` - Blue (#3B82F6)

### Gradients
- `AppColors.primaryGradient` - Blue gradient [#1565C0, #1976D2]

## Switching Theme Mode

### In main.dart

```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system, // or ThemeMode.light or ThemeMode.dark
)
```

### Programmatically

To allow users to switch themes, you'll need to use state management:

```dart
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  
  ThemeMode get themeMode => _themeMode;
  
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
```

## Examples

### Creating a Themed Container

```dart
Container(
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.surface,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: Theme.of(context).dividerColor,
    ),
  ),
  child: Text(
    'Content',
    style: Theme.of(context).textTheme.bodyLarge,
  ),
)
```

### Creating a Gradient Container

```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: AppColors.primaryGradient,
    ),
    borderRadius: BorderRadius.circular(20),
  ),
)
```

### Using Status Colors

```dart
// Success message
Container(
  color: AppColors.success.withOpacity(0.1),
  child: Text(
    'Success!',
    style: TextStyle(color: AppColors.success),
  ),
)

// Error message
Container(
  color: AppColors.error.withOpacity(0.1),
  child: Text(
    'Error!',
    style: TextStyle(color: AppColors.error),
  ),
)
```

## Best Practices

1. **Always use theme colors** instead of hardcoded values
2. **Use `Theme.of(context)`** for automatic theme adaptation
3. **Use predefined text styles** from `Theme.of(context).textTheme`
4. **Test both light and dark modes** during development
5. **Use semantic color names** (e.g., `onSurface` instead of specific colors)

## Theme Components Included

- ✅ AppBar styling
- ✅ Card styling
- ✅ Input field styling
- ✅ Button styling (Elevated, Text)
- ✅ Icon styling
- ✅ Divider styling
- ✅ Text styles (Display, Headline, Body, Label)
- ✅ Color scheme
- ✅ Shadow colors
