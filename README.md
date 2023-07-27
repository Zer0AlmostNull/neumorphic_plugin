A simple implementation for neumorphic UI for flutter. Feel free to check it out :> 

## Installation
In pubspec.yaml add:
```dart
dependencies:
  neumorphic_plugin: ^0.0.1
```

Then in *.dart file:
```dart
import 'package:neumorphic_plugin/neumorphic_plugin.dart';
```

## Usage
To create simeple neumorphic button simpli write this:
```dart
NeumorphicButton(
      onTap: () {},
      padding: const EdgeInsets.all(10.0),
      backgroundColor: Colors.grey[800], // should be same as background
      height: 100,
      borderRadius: 10,
      shadowOffsetMultiplier: 5,
      shadowBlurRadius: 5,
      child: const Text(
        'Click me!',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    )
```