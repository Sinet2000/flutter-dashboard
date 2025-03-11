# my_first_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Let him Cook
> Dart is the language behind Flutter and offers a mix of features familiar to C# developers—like classes and async programming—while having its own twist on things like constructors and privacy. Flutter builds on Dart to let you create beautiful, reactive mobile apps.

### Variables & Types

- **Dynamic Typing:** You can declare variables without a type, but it’s best to be explicit:
```dart
  int count = 10;
  var name = "Alice"; // Dart infers String
```
- **Null Safety:** Dart enforces null safety by default. Append a `?` to a type if it can be null:
```dart
String? nickname;
```

- **Final vs Const**:
    - final: Set once at a runtime
    - const: Compile-time const
```dart
final DateTime now = DateTime.now();
const pi = 3.14159
```   

### Object-Oriented Programming in Dart
#### Classes, Constructors, and Fields
Dart classes are similar to C#. Constructors are flexible and can be shortened using “syntactic sugar.”
```dart
class Person {
  // Private field (only accessible within this file) with underscore.
  String _firstName;
  
  // Read-only field: final
  final int age;

  // Constructor: shorthand for assigning parameters.
  Person(this._firstName, this.age);

  // Instance method
  void sayHello() {
    print('Hello, my name is $_firstName and I am $age years old.');
  }
}
```

#### Getters & Setters (Properties)
No magic “properties” keyword—just getters and setters:
```dart
class Person {
  String _firstName;
  final int age;
  
  Person(this._firstName, this.age);
  
  // Getter
  String get firstName => _firstName;
  
  // Setter with custom logic (if needed)
  set firstName(String value) {
    // You could add validation here
    _firstName = value;
  }
}
```

#### Access Modifiers
- **Public**: Anything without an underscore.
- **Private**: Any identifier starting with an underscore (_) is private to the library.
- **Tip**: Unlike C#, Dart doesn’t use keywords like public or private.

#### Constructor Syntax Explained
Dart’s constructor syntax can look a bit “magical” compared to C#. Consider this example from a Flutter widget:
```dart
class HomeScreen1 extends StatelessWidget {
  // A required parameter 'contacts' is declared.
  final List<String> contacts;
  
  // Constructor with:
  // - const: Enables compile-time constant widget if all fields are immutable.
  // - Named parameters: Wrapped in {} so they can be passed by name.
  // - super.key: Passes the key to the parent (StatelessWidget) constructor.
  // - required: Marks the parameter as mandatory.
  const HomeScreen1({super.key, required this.contacts});
  
  @override
  Widget build(BuildContext context) {
    // Build your UI here...
    return Scaffold(
      appBar: AppBar(title: Text('HomeScreen1')),
      body: Center(child: Text('Contacts count: ${contacts.length}')),
    );
  }
}
```
Breakdown of const HomeScreen1({super.key, required this.contacts});:

- const: Allows the widget to be a compile-time constant, which can help with performance if the widget tree doesn’t change.
- { ... }: Indicates named parameters. This means when you create a HomeScreen1, you must specify parameters by name.
- super.key: A shorthand that passes the key parameter to the superclass (StatelessWidget). In C#, you might see this as calling a base constructor.
- required: Marks the parameter as mandatory. Without it, the parameter would be optional.
- this.contacts: Automatically assigns the passed parameter to the class field contacts.


### Collections
#### Lists
Similar to C#'s List<T>, but declared with literal syntax:
```dart
void listExample() {
  List<String> fruits = ['Apple', 'Banana', 'Orange'];
  fruits.add('Grapes');
  for (var fruit in fruits) {
    print('Fruit: $fruit');
  }
}
```

#### Maps (Dictionaries)
```dart
void mapExample() {
  Map<String, int> fruitQuantities = {
    'Apple': 10,
    'Banana': 5,
    'Orange': 7,
  };
  fruitQuantities['Grapes'] = 3;
  fruitQuantities.forEach((key, value) => print('$key: $value'));
}
```

### Asynchronous Programming
Dart uses Future, async, and await much like C#’s Task-based async model.

#### HTTP Call Example
Add the http package to your pubspec.yaml before using:
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Fetched Data: $data');
    } else {
      print('Error: Status code ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
```

### Interfaces & Abstract Classes
Dart does not have a separate interface keyword—any class can act as an interface. Use abstract to define methods without implementations.
```dart
abstract class Animal {
  void makeSound();
}

class Dog implements Animal {
  @override
  void makeSound() {
    print('Woof!');
  }
}
```

---
## Flutter Fundamentals
### Stateless vs. Stateful Widgets
- **StatelessWidget**: Immutable; used when your UI doesn’t change dynamically.
- **StatefulWidget**: Has mutable state; used for interactive, dynamic UIs.
```dart
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _data = 'No data yet';

  Future<void> _updateData() async {
    // (Reuse HTTP call example here if needed)
    // For demo purposes:
    setState(() {
      _data = 'Data updated!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Basics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Data: $_data'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateData,
              child: Text('Update Data'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Flutter
### Lifecycle and initState
The State object of a StatefulWidget follows a precise lifecycle:
- **Instantiation**: createState() → State object created → initState().
- **Mounting**: didChangeDependencies() (if inherited widgets change) → build().
- **Updates**: didUpdateWidget() (parent config changes) → build().
- **Unmounting**: deactivate() (temporary removal) → dispose() (permanent).


#### initState Under the Hood
- Timing: Executes post-construction, pre-rendering, with a valid BuildContext.
- Purpose: A safe entry point for one-time setup, leveraging widget and context.
- Technical Constraints:
    - No direct access to render tree metrics (e.g., widget sizes) until after build.
    - Scheduler binding ensures it runs before the first frame.
- Advanced Use Cases:
    - Scheduler Post-Frame: Use WidgetsBinding.instance.addPostFrameCallback for post-build logic:
```dart
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    print('Widget fully built');
  });
}
```
```dart
late double screenWidth;
@override
void initState() {
  super.initState();
  screenWidth = MediaQuery.of(context).size.width;
}
```

## late Keyword
- Null Safety Context: late is a null safety feature, marking a variable as non-nullable but deferring its initialization.
- Runtime Behavior: Dart inserts a lazy check—accessing an uninitialized late variable triggers a LateInitializationError.
- Memory Implications: Minimal overhead; it’s a compile-time promise enforced at runtime.

Advanced Usage
With Final: late final ensures one-time initialization:
```dart
late final String uniqueId;
@override
void initState() {
  super.initState();
  uniqueId = DateTime.now().toIso8601String(); // Set once
}
```

---

## API Data Loading with Debounced Search
### Deep Design Considerations
- **Async Patterns**: Future for one-time fetches, Stream for real-time updates.
- **Debouncing**: Prevents API spam by delaying execution until input stabilizes.
- **Error Resilience**: Network failures, timeouts, and JSON parsing errors must be handled gracefully.

### Optimal Approach
- **HTTP Client**: http for lightweight requests (consider dio for complex APIs).
- **State Handling**: FutureBuilder for simplicity, StreamBuilder for live data.
- **Debouncing**: Manual Timer or flutter_debouncer for cleaner code.
- **Caching**: Store results locally to reduce redundant calls (e.g., Hive or SharedPreferences).

```dart
dependencies:
  http: ^1.2.0
```

## Advanced Concepts
### 1. `didChangeDependencies`
- When: Runs after initState and when inherited widgets (e.g., Theme, MediaQuery) change.
- Use: Update state based on external dependencies:
```dart
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (Theme.of(context).brightness == Brightness.dark) {
    setState(() => _isDarkMode = true);
  }
}
```

### 2. Memory Management
- Dispose: Cancel timers, close streams, dispose controllers
```dart
Timer? _timer;
@override
void dispose() {
  _timer?.cancel();
  super.dispose();
}
```

## Short Unique Examples
```dart
class FadeInWidget extends StatefulWidget {
  @override
  _FadeInWidgetState createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1))..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Text('Fading In'),
    );
  }
}
```

#### 2. late with Custom Getter
```dart
class ConfigWidget extends StatefulWidget {
  @override
  _ConfigWidgetState createState() => _ConfigWidgetState();
}

class _ConfigWidgetState extends State<ConfigWidget> {
  late String _config = _loadConfig();

  String _loadConfig() {
    return 'Config from ${DateTime.now().second}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(_config);
  }
}
```

#### 3. Debounced API Search
```dart
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<String>> _searchResults;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchResults = _fetchResults('');
  }

  Future<List<String>> _fetchResults(String query) async {
    await Future.delayed(Duration(milliseconds: 500)); // Mock delay
    return ['Result 1 for $query', 'Result 2 for $query'];
  }

  void _onSearch(String query) {
    _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      setState(() => _searchResults = _fetchResults(query));
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(onChanged: _onSearch),
        FutureBuilder<List<String>>(
          future: _searchResults,
          builder: (context, snapshot) => snapshot.hasData
              ? Column(children: snapshot.data!.map((r) => Text(r)).toList())
              : CircularProgressIndicator(),
        ),
      ],
    );
  }
}
```