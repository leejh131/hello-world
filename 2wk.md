#과제


#구구단 출력  
void main() {
  for (int i = 1; i <= 9; i++) {
    for (int j = 1; j <= 9; j++) {
      print('$i x $j = ${i * j}');
    }
    print(''); // 줄바꿈
  }
}




#정사각형의 길이를 입력하고 사각형을 출력
import 'dart:io';

void main() {
  stdout.write("정사각형 크기 입력: ");
  int n = int.parse(stdin.readLineSync()!);

  print("\n곽 찬 사각형");
  for (int i = 0; i < n; i++) {
    print("." * n);
  }

  print("\n테두리 사각형");
  for (int i = 0; i < n; i++) {
    if (i == 0 || i == n - 1) {
      print("." * n);
    } else {
      print("." + " " * (n - 2) + ".");
    }
  }

  print("\n/ 표시 사각형");
  for (int i = 0; i < n; i++) {
    print(" " * i + "/" + " " * (n - i - 1));
  }

  print("\n\\ 표시 사각형");
  for (int i = 0; i < n; i++) {
    print(" " * (n - i - 1) + "\\" + " " * i);
  }

  print("\nX 표시 사각형");
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if (i == j) {
        stdout.write("/");
      } else if (i + j == n - 1) {
        stdout.write("\\");
      } else {
        stdout.write(" ");
      }
    }
    print("");
  }
}


#년/월/일을 입력하면 요일을 출력
import 'dart:io';
import 'package:intl/intl.dart';

void main() {
  stdout.write("년-월-일을 입력 (예: 2025-03-11): ");
  String input = stdin.readLineSync()!;

  try {
    DateTime date = DateTime.parse(input);
    List<String> weekdays = ["월", "화", "수", "목", "금", "토", "일"];
    print("출력: \${weekdays[date.weekday - 1]}요일");
  } catch (e) {
    print("잘못된 날짜 형식입니다. 예: 2025-03-20");
  }
}

