import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import 'package:motosync_app/core/theme/app_text_styles.dart';
import '../../providers/auth_providers.dart';
import '../atoms/app_button.dart';
import '../molecules/form_footer_link.dart';
import '../organisms/login_form.dart';
import '../templates/auth_template.dart';
/// Login page connected to Firebase Authentication.
class LoginPage extends ConsumerStatefulWidget { const LoginPage({super.key}); @override ConsumerState<LoginPage> createState()=>_LoginPageState(); }
class _LoginPageState extends ConsumerState<LoginPage> {
  final _email=TextEditingController(), _password=TextEditingController(); String? _emailError, _passwordError, _message; bool _loading=false;
  @override void dispose(){_email.dispose();_password.dispose();super.dispose();}
  String? _validateEmail(String v)=>RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim())?null:'Enter a valid email address.';
  void _validate(){setState((){_emailError=_validateEmail(_email.text);_passwordError=_password.text.length>=8?null:'Password must be at least 8 characters.';});}
  Future<void> _login() async { _validate(); if(_emailError!=null||_passwordError!=null)return; setState(()=>_loading=true); try { await ref.read(authRepositoryProvider).signIn(_email.text,_password.text); if(mounted) context.go(AppRoutes.loading); } catch(e){setState(()=>_message=ref.read(authRepositoryProvider).friendlyError(e));} finally{if(mounted)setState(()=>_loading=false);} }
  Future<void> _forgot() async { final error=_validateEmail(_email.text); if(error!=null){setState(()=>_emailError=error);return;} try{await ref.read(authRepositoryProvider).sendPasswordReset(_email.text);if(mounted)setState(()=>_message='Password reset email sent. Check your inbox.');}catch(e){if(mounted)setState(()=>_message=ref.read(authRepositoryProvider).friendlyError(e));} }
  @override Widget build(BuildContext context)=>AuthTemplate(title:'Welcome back',subtitle:'Log in to continue',children:[LoginForm(email:_email,password:_password,emailError:_emailError,passwordError:_passwordError,onEmailChanged:(_){setState(()=>_message=null);},onEmailBlur:()=>setState(()=>_emailError=_validateEmail(_email.text)),onPasswordChanged:(_){},onPasswordBlur:()=>setState(()=>_passwordError=_password.text.length>=8?null:'Password must be at least 8 characters.'),onForgotPassword:_forgot),if(_message!=null) Text(_message!,style: AppTextStyles.error),AppButton(label:'Log in',loading:_loading,onPressed:_login),FormFooterLink(prefix:'New here? ',link:'Create account',onTap:()=>context.go(AppRoutes.register))]);
}
