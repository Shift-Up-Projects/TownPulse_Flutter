// import 'package:flutter/material.dart';

// class OnboardingScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // لإزالة شريط التطبيق العلوي إذا لم يكن مرغوباً
//       body: Container(
//         // تطبيق التدرج اللوني كخلفية
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF4C3D82), // بنفسجي غامق
//               Color(0xFF8A5DAB), // بنفسجي فاتح/زهري
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 40.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             // الجزء العلوي (أيقونة والوصف)
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   // الأيقونة (التقويم)
//                   CircleAvatar(
//                     radius: 45,
//                     backgroundColor: Colors.white.withOpacity(
//                       0.2,
//                     ), // خلفية دائرية شفافة
//                     child: const Icon(
//                       Icons.calendar_today,
//                       size: 40,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   // العنوان الرئيسي
//                   const Text(
//                     'اكتشف الأنشطة المحلية',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textDirection: TextDirection.rtl, // لضمان اتجاه النص العربي
//                   ),
//                   const SizedBox(height: 15),
//                   // النص الوصفي
//                   const Text(
//                     'استكشف مجموعة متنوعة من الأنشطة والفعاليات في مدينتك',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white70, fontSize: 16),
//                     textDirection: TextDirection.rtl,
//                   ),
//                 ],
//               ),
//             ),

//             // مؤشرات الصفحات (النقاط البيضاء)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 50.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   _buildPageIndicator(true), // النقطة المضيئة
//                   _buildPageIndicator(false),
//                   _buildPageIndicator(false),
//                 ],
//               ),
//             ),

//             // الأزرار
//             Padding(
//               padding: const EdgeInsets.only(bottom: 30.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   // زر تخطي
//                   _buildGradientButton(
//                     text: 'تخطي',
//                     onPressed: () {},
//                     isFilled: false,
//                   ),
//                   // زر التالي
//                   _buildGradientButton(
//                     text: 'التالي',
//                     onPressed: () {},
//                     isFilled: true,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // دالة مساعدة لإنشاء مؤشر الصفحة (النقاط)
//   Widget _buildPageIndicator(bool isActive) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 150),
//       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//       height: 10.0,
//       width: isActive ? 24.0 : 10.0,
//       decoration: BoxDecoration(
//         color: isActive ? Colors.white : Colors.white54,
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//   }

//   // دالة مساعدة لإنشاء الأزرار ذات التدرج اللوني الجزئي
//   Widget _buildGradientButton({
//     required String text,
//     required VoidCallback onPressed,
//     required bool isFilled,
//   }) {
//     return Container(
//       decoration: isFilled
//           ? BoxDecoration(
//               borderRadius: BorderRadius.circular(30.0),
//               // تدرج لوني خفيف للأزرار الممتلئة (كما في "التالي")
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.white.withOpacity(0.2),
//                   Colors.white.withOpacity(0.1),
//                 ],
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//               ),
//             )
//           : BoxDecoration(
//               borderRadius: BorderRadius.circular(30.0),
//               border: Border.all(
//                 color: Colors.white.withOpacity(0.3),
//               ), // حدود خفيفة لزر "تخطي"
//             ),
//       child: MaterialButton(
//         minWidth: 100,
//         height: 50,
//         onPressed: onPressed,
//         // الخلفية تكون شفافة إذا كان الزر غير ممتلئ
//         color: isFilled ? Colors.transparent : Colors.transparent,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: isFilled ? FontWeight.bold : FontWeight.normal,
//           ),
//           textDirection: TextDirection.rtl,
//         ),
//       ),
//     );
//   }
// }

// // لضمان عمل الكود في بيئة تجريبية
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: OnboardingScreen(),
//     );
//   }
// }


// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // لإزالة شريط التطبيق العلوي إذا لم يكن مرغوباً
//       body: Container(
//         // تطبيق التدرج اللوني كخلفية
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF4C3D82), // بنفسجي غامق
//               Color(0xFF8A5DAB), // بنفسجي فاتح/زهري
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 40.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             // الجزء العلوي (أيقونة والوصف)
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   // الأيقونة (التقويم)
//                   CircleAvatar(
//                     radius: 45,
//                     backgroundColor: Colors.white.withOpacity(0.2), // خلفية دائرية شفافة
//                     child: const Icon(
//                       Icons.calendar_today,
//                       size: 40,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   // العنوان الرئيسي
//                   const Text(
//                     'اكتشف الأنشطة المحلية',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textDirection: TextDirection.rtl, // لضمان اتجاه النص العربي
//                   ),
//                   const SizedBox(height: 15),
//                   // النص الوصفي
//                   const Text(
//                     'استكشف مجموعة متنوعة من الأنشطة والفعاليات في مدينتك',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 16,
//                     ),
//                     textDirection: TextDirection.rtl,
//                   ),
//                 ],
//               ),
//             ),

//             // مؤشرات الصفحات (النقاط البيضاء)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 50.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   _buildPageIndicator(true), // النقطة المضيئة
//                   _buildPageIndicator(false),
//                   _buildPageIndicator(false),
//                 ],
//               ),
//             ),

//             // الأزرار
//             Padding(
//               padding: const EdgeInsets.only(bottom: 30.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   // زر تخطي
//                   _buildGradientButton(
//                     text: 'تخطي',
//                     onPressed: () {},
//                     isFilled: false,
//                   ),
//                   // زر التالي
//                   _buildGradientButton(
//                     text: 'التالي',
//                     onPressed: () {},
//                     isFilled: true,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // دالة مساعدة لإنشاء مؤشر الصفحة (النقاط)
//   Widget _buildPageIndicator(bool isActive) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 150),
//       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//       height: 10.0,
//       width: isActive ? 24.0 : 10.0,
//       decoration: BoxDecoration(
//         color: isActive ? Colors.white : Colors.white54,
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//   }

//   // دالة مساعدة لإنشاء الأزرار ذات التدرج اللوني الجزئي
//   Widget _buildGradientButton({required String text, required VoidCallback onPressed, required bool isFilled}) {
//     return Container(
//       decoration: isFilled
//           ? BoxDecoration(
//               borderRadius: BorderRadius.circular(30.0),
//               // تدرج لوني خفيف للأزرار الممتلئة (كما في "التالي")
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.white.withOpacity(0.2), 
//                   Colors.white.withOpacity(0.1),
//                 ],
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//               ),
//             )
//           : BoxDecoration(
//               borderRadius: BorderRadius.circular(30.0),
//               border: Border.all(color: Colors.white.withOpacity(0.3)), // حدود خفيفة لزر "تخطي"
//             ),
//       child: MaterialButton(
//         minWidth: 100,
//         height: 50,
//         onPressed: onPressed,
//         // الخلفية تكون شفافة إذا كان الزر غير ممتلئ
//         color: isFilled ? Colors.transparent : Colors.transparent, 
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: isFilled ? FontWeight.bold : FontWeight.normal,
//           ),
//           textDirection: TextDirection.rtl,
//         ),
//       ),
//     );
//   }
// }

// // // لضمان عمل الكود في بيئة تجريبية
// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: OnboardingScreen(),
// //     );
// //   }
// // }

// Container(
//   decoration: BoxDecoration(
//     gradient: LinearGradient(
//       // تحديد الألوان المستخدمة في التدرج
//       colors: [
//         Color(0xFF4C3D82), // لون بنفسجي غامق تقريبي
//         Color(0xFF8A5DAB), // لون بنفسجي فاتح/زهري تقريبي
//       ],
//       // تحديد اتجاه التدرج
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//     ),
//   ),