# ljh - Flutter


## 7주차 과제
1. 값(데이터)과 값을 화면에 표현하는 로직을 구분하여 구현하는 것이 왜 중요한지를 LLM을 이용해서 조사하기
2. 7장의 코드에 값과 화면 구성을 구분해서 화면 구성을 좀 더 효과적으로 전개하기


# 1. 값(데이터)과 화면 표현 로직의 구분이 중요한 이유  

---

##  개요

값(데이터)과 화면 표현(출력) 로직을 분리하는 것은 좋은 소프트웨어 설계의 기본입니다.  
다음은 그 이유를 정리한 것입니다.

---

## 1. 유지보수가 쉬워진다
- 데이터 처리와 화면 출력이 독립적이면, 하나를 수정해도 다른 쪽에 영향을 주지 않습니다.
- 화면 표현 방식만 바꿀 때 데이터 로직은 수정할 필요가 없습니다.

## 2. 재사용성과 확장성이 높아진다
- 같은 데이터를 다양한 출력 방식으로 활용할 수 있습니다.
- 예를 들어 텍스트 출력이던 것을 쉽게 그래픽 UI로 변경할 수 있습니다.

## 3. 테스트가 쉬워진다
- 데이터 로직만 따로 테스트할 수 있어, 기능 검증이 쉬워집니다.
- 문제 발생 시, 데이터 오류인지 출력 오류인지 빠르게 구분할 수 있습니다.

## 4. 책임이 명확해진다
- 데이터 관리와 화면 표현의 책임이 분리되어, 코드 구조가 더 명확하고 이해하기 쉬워집니다.
- 여러 개발자가 협업할 때 작업 분담이 수월해집니다.

## 5. 버그 발생 가능성이 줄어든다
- 데이터와 표현이 섞여 있으면 의도치 않은 데이터 변경이나 출력 오류가 발생하기 쉽습니다.
- 분리하면 코드 안정성이 향상됩니다.

---

##  요약

> **"데이터는 데이터답게, 표현은 표현답게 관리하라."**

값과 화면을 분리하면 유지보수성, 확장성, 안정성 모두를 잡을 수 있습니다.

---

# 2. 7장의 코드에 값과 화면 구성을 구분해서</br>  화면 구성을 좀 더 효과적으로 전개하기
ex)</br>
- 기존 코드(7장)에서 상태가 없던 것을 개선</br>
- 메뉴, 사진, 게시판 데이터를 상태(State)로 관리</br>
- 버튼을 통해 3개, 5개, 7개, 10개 모드로 동적으로 변경 가능</br>
- 값과 화면 구성을 분리하여 유지보수성과 확장성 향상
---

## 코드
main.dart
```
import 'package:flutter/material.dart';
import 'package:a_7_1/page1.dart';
import 'package:a_7_1/page2.dart';
import 'package:a_7_1/page3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '복잡한 ui작성',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  final List<Widget> _pages = [Page1(), Page2(), Page3()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('복잡한 ui', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: '이용서비스', icon: Icon(Icons.assignment)),
          BottomNavigationBarItem(label: '내 정보', icon: Icon(Icons.account_circle)),
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}

```
page1.dart
```
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Page1 extends StatefulWidget {
  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  List<Map<String, dynamic>> menuItems = [];
  List<String> imageUrls = [];
  List<String> boardItems = [];

  @override
  void initState() {
    super.initState();
    _updateData(3);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          _buildTopMenu(),
          const SizedBox(height: 16),
          _buildMiddleImageSlider(),
          const SizedBox(height: 16),
          _buildBottomBoard(),
          const SizedBox(height: 16),
          _buildControlButtons(), 
        ],
      ),
    );
  }

  Widget _buildTopMenu() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      runSpacing: 20,
      children: menuItems.map((menu) => _buildMenuItem(menu)).toList(),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> menu) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(menu['icon'], size: 40),
        Text(menu['title']),
      ],
    );
  }

  Widget _buildMiddleImageSlider() {
    return CarouselSlider(
      items: imageUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Image.network(url, fit: BoxFit.cover),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(height: 150.0, autoPlay: true),
    );
  }

  Widget _buildBottomBoard() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: boardItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.notifications_none),
          title: Text(boardItems[index]),
        );
      },
    );
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(onPressed: () => _updateData(3), child: const Text('3개')),
        ElevatedButton(onPressed: () => _updateData(5), child: const Text('5개')),
        ElevatedButton(onPressed: () => _updateData(7), child: const Text('7개')),
        ElevatedButton(onPressed: () => _updateData(10), child: const Text('10개')),
      ],
    );
  }

  void _updateData(int count) {
    setState(() {

      menuItems = List.generate(count, (index) => {
        'icon': Icons.local_taxi,
        'title': '택시 $index',
      });


      imageUrls = List.generate(count, (index) => 'https://picsum.photos/500/300?random=$index');


      boardItems = List.generate(count, (index) => '[이벤트] 이것은 공지사항 $index 입니다.');
    });
  }
}

```
나머지 page2.dart, page3.dart, pubspec.yaml은 동일

## 화면출력
![aa](https://github.com/user-attachments/assets/b031a499-5265-47c6-a5ea-c5e7361e351b)
![s](https://github.com/user-attachments/assets/5170c116-c574-4cdc-9a17-4fd691350427)
![d](https://github.com/user-attachments/assets/90b6e9f2-8164-4021-8b4e-471c5bd468bf)
![f](https://github.com/user-attachments/assets/e0a59335-e3c6-417a-b908-9af9c5575423)
![g](https://github.com/user-attachments/assets/4c5df592-ba55-4d86-b52a-382fd6a6f081)
![h](https://github.com/user-attachments/assets/723e140e-ab63-4f01-af98-531f5053adbe)
