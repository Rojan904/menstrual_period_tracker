# menstraul_period_tracker

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


1.setup hive 
2.setup model classes: modify, generate, register
2.1 define model class and annotate with hiveType (typeId:0) using unique type id for each class. this is for database
2.2 also annotate each properties with hiveField(1) with uniq field id
2.3 extend hive object that has predefined function related to crud
3.boxes are the place where our data is stored in key value pairs. you can create other boxes.