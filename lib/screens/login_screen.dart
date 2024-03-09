import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      } // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Login'),
          leading: const BackButton(
            color: Colors.black,
          ),
        ));
    //   body: Container(
    //     width: MediaQuery.of(context).size.width,
    //     height: MediaQuery.of(context).size.height,
    //     padding: EdgeInsets.only(
    //         left: ScreenUtil().setWidth(24), right: ScreenUtil().setHeight(24)),
    //     color: const Color.fromRGBO(239, 238, 252, 1),
    //     child: SingleChildScrollView(
    //         physics: const BouncingScrollPhysics(),
    //         child: Column(children: [
    //           // Container(
    //           //   height: ScreenUtil().setHeight(46),
    //           //   width: ScreenUtil().setWidth(327),
    //           //   margin: EdgeInsets.only(top: ScreenUtil().setHeight(120)),
    //           //   child: ElevatedButton(
    //           //     style: ElevatedButton.styleFrom(
    //           //         shadowColor: Colors.transparent,
    //           //         shape: RoundedRectangleBorder(
    //           //             borderRadius: BorderRadius.circular(20.0),
    //           //             side: const BorderSide(
    //           //                 color: Color.fromRGBO(230, 230, 230, 1))),
    //           //         backgroundColor: Colors.white),
    //           //     onPressed: () {},
    //           //     child: Container(
    //           //       padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
    //           //       child: Row(
    //           //         children: <Widget>[
    //           //           // Expanded(
    //           //           //   flex: 1,
    //           //           //   // child: SvgPicture.asset(
    //           //           //   //   Images.googleIcon,
    //           //           //   // ),
    //           //           // ),
    //           //           Expanded(flex: 3, child: Text("Login with Google")),
    //           //         ],
    //           //       ),
    //           //     ),
    //           //   ),
    //           // ),
    //           // Container(
    //           //   height: ScreenUtil().setHeight(46),
    //           //   width: ScreenUtil().setWidth(327),
    //           //   margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
    //           //   child: ElevatedButton(
    //           //     style: ElevatedButton.styleFrom(
    //           //         shadowColor: Colors.transparent,
    //           //         shape: RoundedRectangleBorder(
    //           //             borderRadius: BorderRadius.circular(20.0),
    //           //             side: const BorderSide(
    //           //                 color: Color.fromRGBO(230, 230, 230, 1))),
    //           //         backgroundColor: const Color.fromRGBO(0, 86, 178, 1)),
    //           //     onPressed: () {},
    //           //     child: Container(
    //           //       padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
    //           //       child: Row(
    //           //         children: <Widget>[
    //           //           // Expanded(
    //           //           //   flex: 1,
    //           //           //   child: SvgPicture.asset(
    //           //           //     Images.fbIcon,
    //           //           //   ),
    //           //           // ),
    //           //           Expanded(flex: 3, child: Text("Login with Facebook"))
    //           //         ],
    //           //       ),
    //           //     ),
    //           //   ),
    //           // ),
    //           // Container(
    //           //   margin: EdgeInsets.only(top: ScreenUtil().setHeight(36)),
    //           //   child: Row(
    //           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           //     children: [
    //           //       Container(
    //           //         width: 135,
    //           //         height: 1,
    //           //         color: const Color.fromRGBO(230, 230, 230, 1),
    //           //       ),
    //           //       Container(child: Text('OR')),
    //           //       Container(
    //           //         width: 135,
    //           //         height: 1,
    //           //         color: const Color.fromRGBO(230, 230, 230, 1),
    //           //       ),
    //           //     ],
    //           //   ),
    //           // ),
    //           Container(
    //             margin: EdgeInsets.only(
    //               top: ScreenUtil().setHeight(32),
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text('Email Address'),
    //                 Container(
    //                   width: MediaQuery.of(context).size.width,
    //                   margin: EdgeInsets.only(
    //                     top: ScreenUtil().setHeight(8),
    //                   ),
    //                   child: TextFormField(
    //                     onTap: () {},
    //                     decoration: InputDecoration(
    //                       prefixIcon:
    //                           Icon(Icons.mail_outline, color: Colors.blue),
    //                       border: OutlineInputBorder(
    //                           borderSide: BorderSide.none,
    //                           borderRadius: BorderRadius.circular(20.0)),
    //                       fillColor: Colors.white,
    //                       filled: true,
    //                       contentPadding: EdgeInsets.only(
    //                         left: ScreenUtil().setWidth(19),
    //                       ),
    //                       hintText: 'Your Email Address',
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Container(
    //             margin: EdgeInsets.only(
    //               top: ScreenUtil().setHeight(16),
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text('Password'),
    //                 Container(
    //                   width: MediaQuery.of(context).size.width,
    //                   margin: EdgeInsets.only(
    //                     top: ScreenUtil().setHeight(8),
    //                   ),
    //                   child: TextFormField(
    //                     onTap: () {},
    //                     obscureText: _obscured,
    //                     focusNode: textFieldFocusNode,
    //                     decoration: InputDecoration(
    //                       prefixIcon:
    //                           Icon(Icons.lock_outline, color: Colors.blue),
    //                       suffixIcon: GestureDetector(
    //                         onTap: _toggleObscured,
    //                         child: Icon(
    //                           _obscured
    //                               ? Icons.visibility_off_outlined
    //                               : Icons.visibility_outlined,
    //                           size: 24,
    //                         ),
    //                       ),
    //                       border: OutlineInputBorder(
    //                           borderSide: BorderSide.none,
    //                           borderRadius: BorderRadius.circular(20.0)),
    //                       fillColor: Colors.white,
    //                       filled: true,
    //                       contentPadding: EdgeInsets.only(
    //                         left: ScreenUtil().setWidth(19),
    //                       ),
    //                       hintText: 'Your Password',
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Container(
    //             margin: EdgeInsets.only(
    //                 top: ScreenUtil().setHeight(24),
    //                 bottom: ScreenUtil().setHeight(24)),
    //             child: ElevatedButton(
    //               child: Text('Login'),
    //               onPressed: () {
    //                 Navigator.pushNamed(context, '/home');
    //               },
    //             ),
    //           ),
    //           Container(
    //             margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
    //             child: GestureDetector(
    //               child: Text('Forgot password?'),
    //               onTap: () {
    //                 //TODO
    //               },
    //             ),
    //           ),
    //           //   RichText(
    //           //     textAlign: TextAlign.center,
    //           //     text: const TextSpan(
    //           //       children: [
    //           //         TextSpan(
    //           //             text: "By continuing, you agree to the ",
    //           //             style:
    //           //                 TextStyle(color: Color.fromRGBO(133, 132, 148, 1))),
    //           //         TextSpan(
    //           //           text: 'Terms of Services ',
    //           //           style: TextStyle(color: Color.fromRGBO(73, 70, 95, 1)),
    //           //         ),
    //           //         TextSpan(
    //           //             text: '& ',
    //           //             style:
    //           //                 TextStyle(color: Color.fromRGBO(133, 132, 148, 1))),
    //           //         TextSpan(
    //           //           text: 'Privacy Policy',
    //           //           style: TextStyle(color: Color.fromRGBO(73, 70, 95, 1)),
    //           //         ),
    //           //       ],
    //           //     ),
    //           //   ),
    //           // ],
    //         ])),
    //   ),
    // );
  }
}
