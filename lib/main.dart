import 'package:flutter/material.dart';

void main() {
  runApp(const PointsCounterApp());
}

class PointsCounterApp extends StatelessWidget {
  const PointsCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // لإخفاء الشريط الأحمر التجريبي
      home:
          const StartGameScreen(), // جعل الشاشة السوداء هي نقطة البداية الأولى للتطبيق
    );
  }
}

// ==========================================
// 1️⃣ الشاشة الأولى: واجهة البداية السوداء (Start Game)
// ==========================================
class StartGameScreen extends StatelessWidget {
  const StartGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF1E4D3), // جعل الخلفية سوداء بالكامل مثل الصورة
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // backgroundColor: Colors.white, // لون الزر أخضر مطابق تماماً للصورة
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
                horizontal: 45, vertical: 15), // حجم الزر ومساحة النص بالداخل
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  30), // حواف دائرية انسيابية ومطابقة للشكل المطلوب
            ),
          ),
          onPressed: () {
            // الانتقال السلس إلى الشاشة الثانية (شاشة عداد النقاط) عند الضغط
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GameGridScreen()),
            );
          },
          child: const Text(
            'Start Game',
            style: TextStyle(
              color: Color(0xFFF1E4D3), // لون النص أبيض
              fontSize: 26, // حجم الخط واضح ومتناسق مع حجم الزر
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class PointsCounterScreen extends StatefulWidget {
  const PointsCounterScreen({super.key});

  @override
  State<PointsCounterScreen> createState() => _PointsCounterScreenState();
}

class _PointsCounterScreenState extends State<PointsCounterScreen> {
  // 1. هنا نضع المتغيرات (عداد النقاط لكل فريق)
  int teamAPoints = 0;
  int teamBPoints = 0;

  @override
  Widget build(BuildContext context) {
    // 2. هنا سنبدأ بتصميم الواجهة وشاشتنا البرتقالية والأزرار
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'XO Game',
          style:
              TextStyle(color: Color(0xFFF1E4D3), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white, // تلوين الشريط العلوي بالبرتقالي
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment
            .spaceEvenly, // لتوزيع العناصر عمودياً بمسافات متساوية
        children: [
          // الصف الرئيسي الذي يحتوي على الفريقين بجانب بعضهما
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceEvenly, // لتوزيع الفريقين أفقياً بالتساوي
            children: [
              // --- عمود الفريق A ---
              Column(
                children: [
                  const Text('Team X',
                      style: TextStyle(
                          color: Color(0xFFF1E4D3),
                          fontSize: 32)), // اسم الفريق
                  Text('$teamAPoints',
                      style: const TextStyle(
                          color: Color(0xFFF1E4D3),
                          fontSize: 150,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Pacifico.ttf")), // عداد النقاط
                  _buildPointButton(
                      'Add 1 Point', () => setState(() => teamAPoints += 1)),
                  const SizedBox(height: 10), // مسافة فارغة صغيرة بين الأزرار
                  _buildPointButton(
                      'Add 2 Point', () => setState(() => teamAPoints += 2)),
                  const SizedBox(height: 10),
                  _buildPointButton(
                      'Add 3 Point', () => setState(() => teamAPoints += 3)),
                ],
              ),

              // --- الخط الفاصل الرمادي في المنتصف ---
              Container(
                height: 400,
                width: 1,
                color: Colors.grey,
              ),

              // --- عمود الفريق B ---
              Column(
                children: [
                  const Text('Team O',
                      style: TextStyle(
                          color: Color(0xFFF1E4D3),
                          fontSize: 32,
                          fontFamily: "Pacifico.ttf")), // اسم الفريق
                  Text('$teamBPoints',
                      style: const TextStyle(
                          color: Color(0xFFF1E4D3),
                          fontSize: 150,
                          fontWeight: FontWeight.w300)), // عداد النقاط

                  _buildPointButton(
                      'Add 1 Point', () => setState(() => teamBPoints += 1)),
                  const SizedBox(height: 10),
                  _buildPointButton(
                      'Add 2 Point', () => setState(() => teamBPoints += 2)),
                  const SizedBox(height: 10),
                  _buildPointButton(
                      'Add 3 Point', () => setState(() => teamBPoints += 3)),
                ],
              ),
            ],
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: const Size(150, 45),
            ),
            onPressed: () {
              setState(() {
                teamAPoints = 0;
                teamBPoints = 0;
              });
            },
            child: const Text('Reset',
                style: TextStyle(color: Color(0xFFF1E4D3), fontSize: 20)),
          ),
        ],
      ),
    );
  }

  Widget _buildPointButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          minimumSize: const Size(130, 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        onPressed: onPressed,
        child: Text(text,
            style: TextStyle(
              color: Color(0xFFF1E4D3),
              fontWeight: FontWeight.w900,
            )));
  }
}

class GameGridScreen extends StatefulWidget {
  const GameGridScreen({super.key});

  @override
  State<GameGridScreen> createState() => _GameGridScreenState();
}

class _GameGridScreenState extends State<GameGridScreen> {
  // 👇 حجز 9 خانات فارغة في الذاكرة للمربعات
  List<String> board = List.filled(9, '');

  // 👇 متغير لتحديد دور اللاعب الحالي (يبدأ بـ X)
  String currentTurn = 'X';
  String? playerSymbol;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1E4D3),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 1️⃣ هنا تكتب كود شبكة المربعات الـ 9 في أعلى العمود:
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // 🟢 التحقق إذا كانت هذه أول نقرة في اللعبة واللاعب لم يختار رمزاً بعد
                      // سنعرف ذلك إذا كانت كل المربعات لا تزال فارغة تماماً
                      bool isFirstClick =
                          board.every((element) => element == '');

                      if (isFirstClick) {
                        // 🛑 إذا كانت أول نقرة، نفتح النافذة الصغيرة ونمرر لها رقم المربع (index) الذي ضغط عليه
                        _showChoiceDialog(context, index, (String choice) {
                          setState(() {
                            board[index] = choice;
                            currentTurn = choice == 'X' ? 'O' : 'X';
                          });
                        });
                      } else {
                        // 🟢 إذا لم تكن أول نقرة (اللعبه بدأت بالفعل)، يلعب بشكل طبيعي ويتبدل الدور
                        if (board[index] == '') {
                          setState(() {
                            board[index] = currentTurn;
                            currentTurn =
                                (currentTurn == 'X') ? 'O' : 'X'; // تبديل الدور
                          });
                        }
                      }
                    },

                    child:
                        _buildSquare(board[index]), // تحديث محتوى المربع نصياً
                  );
                },
              ),
            ),

            // 2️⃣ وتحتها مباشرة تكتب كود زر الـ Result الأبيض:
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(220, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PointsCounterScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Result',
                  style: TextStyle(color: Color(0xFFF1E4D3), fontSize: 28),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } // 🛑 هذا قوس إغلاق دالة الـ build الخاصة بالشاشة البيج

  // 3️⃣ هنا بالأسفل (خارج دالة build وقبل قوس إغلاق الكلاس) نضع دالة المربع الجاهزة:
  Widget _buildSquare(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: text == 'X' ? Colors.red : Colors.blue,
        ),
      ),
    );
  }
}
// 🛑 هذا القوس الأخير والنهائي للشاشة البيج بالكامل

// 🟢 دالة إظهار النافذة المنبثقة (Dialog) المطابقة للصورة تماماً
void _showChoiceDialog(
    BuildContext context, int index, Function(String) onSelected) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Select X Or O',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircleButton(
                  'X',
                  Colors.red,
                  const Color(0xFFFFEBEE),
                  context,
                  onSelected,
                ),
                _buildCircleButton(
                  'O',
                  Colors.blue,
                  const Color(0xFFE3F2FD),
                  context,
                  onSelected,
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}

// 🟢 دالة بناء الأزرار الدائرية X و O التفاعلية بالداخل
Widget _buildCircleButton(String text, Color textColor, Color bgColor,
    BuildContext context, Function(String) onSelected) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
      onSelected(text);
    },
    child: Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 26,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
