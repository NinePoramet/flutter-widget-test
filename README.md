# 🌀 Fibonacci List - Mobile Assignment (Flutter)

This Flutter application is a simple demonstration of state management, scrollable UI, and interactive widgets. It was built as part of a coding assignment and showcases a dynamic list of the first 40 Fibonacci numbers.

---

## 📋 Assignment Requirements

### ✅ 1. Scrollable Widget

- A vertically scrollable list of **at least the first 40 Fibonacci numbers**.
- Implemented using `ListView.builder` with custom height handling.
- Smooth scroll to highlighted items with animation.

### ✅ 2. Display Widget

- Each item in the list shows:
  - The **Fibonacci number**.
  - The **index** of the number.
  - An **icon representing its type** (based on `number % 3`):
    - `0 → Circle`
    - `1 → Square`
    - `2 → Cross`

### ✅ 3. Tap Functionality

- Tapping an item:
  - **Removes it from the main list**.
  - **Displays a BottomSheet** with other items of the same "type".
- Tapping an item in the BottomSheet:
  - Moves it **back to the main list** in its original index.
  - **Closes the BottomSheet**.
  - **Highlights** and scrolls to the re-added item.

---

## 💡 Tech Stack

- **Flutter**
- **Dart**
- State management using `setState`
- Animations and gesture handling with `InkWell`, `AnimatedContainer`, and `ScrollController`.

---

## 📁 Project Structure

```
lib/
├── main.dart # Main UI and interaction logic
├── fibo.dart # Fibonacci logic and data model
```

---

## 🚀 How to Run

```bash
flutter pub get
flutter run
```

👤 Author
• Poramet Poolsup
• GitHub: https://github.com/NinePoramet

📌 Notes

This project was built for demonstration and interview purposes, focusing on Flutter UI, custom logic, and stateful interactions without using third-party state management packages.
