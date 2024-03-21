import 'dart:collection';
import 'package:collection/collection.dart';

void main() {
  var system = SchoolManagementSystem();

  system.registerStudent("rewan", 18, "rewan@example.com");
  system.registerStudent("mohamed", 17, "mohamed@example.com");

  system.createCourse(
      "CS101",
      "Introduction to Computer Science",
      "Basic concepts of programming",
      "Dr. rewa",
      "Monday/Wednesday/Friday 9:00 AM",
      30);
  system.createCourse(
      "MATH101",
      "Calculus I",
      "Fundamental concepts of calculus",
      "Prof. moha",
      "Tuesday/Thursday 10:00 AM",
      25);

  system.enrollStudentInCourse("S1646107864705", "CS101");
  system.enrollStudentInCourse("S1646107873280", "CS101");

  system.recordAttendance("S1646107864705", "CS101");
  system.recordAttendance("S1646107873280", "CS101");

  system.displayEnrolledCourses("S1646107864705");
}

class Student {
  late String id;
  String name;
  int age;
  String contactDetails;
  List<Course> enrolledCourses = [];

  Student(this.name, this.age, this.contactDetails) {
    id = generateStudentID();
  }

  String generateStudentID() {
    return 'S${DateTime.now().millisecondsSinceEpoch}';
  }

  void enrollInCourse(Course course) {
    enrolledCourses.add(course);
  }

  @override
  String toString() {
    return '$name (ID: $id)';
  }
}

class Course {
  String code;
  String title;
  String description;
  String instructor;
  String schedule;
  int maxCapacity;
  List<Student> enrolledStudents = [];

  Course(this.code, this.title, this.description, this.instructor,
      this.schedule, this.maxCapacity);

  bool enrollStudent(Student student) {
    if (enrolledStudents.length < maxCapacity) {
      enrolledStudents.add(student);
      student.enrollInCourse(this);
      return true;
    } else {
      return false;
    }
  }

  void recordAttendance(Student student) {
    print('Attendance recorded for ${student.name} in $title');
  }

  @override
  String toString() {
    return '$title (Code: $code)';
  }
}

class SchoolManagementSystem {
  List<Student> students = [];
  List<Course> courses = [];

  void registerStudent(String name, int age, String contactDetails) {
    var newStudent = Student(name, age, contactDetails);
    students.add(newStudent);
  }

  void createCourse(String code, String title, String description,
      String instructor, String schedule, int maxCapacity) {
    var newCourse =
        Course(code, title, description, instructor, schedule, maxCapacity);
    courses.add(newCourse);
  }

  void enrollStudentInCourse(String studentID, String courseCode) {
    var student =
        students.firstWhereOrNull((student) => student.id == studentID);
    var course =
        courses.firstWhereOrNull((course) => course.code == courseCode);
    if (student != null && course != null) {
      if (course.enrollStudent(student)) {
        print('${student.name} has been enrolled in ${course.title}');
      } else {
        print(
            'Failed to enroll ${student.name} in ${course.title}. Course is full.');
      }
    } else {
      print('Student or course not found.');
    }
  }

  void recordAttendance(String studentID, String courseCode) {
    var student =
        students.firstWhereOrNull((student) => student.id == studentID);
    var course =
        courses.firstWhereOrNull((course) => course.code == courseCode);
    if (student != null && course != null) {
      course.recordAttendance(student);
    } else {
      print('Student or course not found.');
    }
  }

  void displayEnrolledCourses(String studentID) {
    var student =
        students.firstWhereOrNull((student) => student.id == studentID);
    if (student != null) {
      print('Enrolled courses for ${student.name}:');
      student.enrolledCourses.forEach((course) {
        print('${course.title}');
      });
    } else {
      print('Student not found.');
    }
  }
}
