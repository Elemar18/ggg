import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../providers/auth_providers.dart';
import 'package:motosync_app/core/theme/app_text_styles.dart';
import '../atoms/app_button.dart';
import '../atoms/app_check_box.dart';
import '../atoms/app_link_text.dart';
import '../molecules/form_footer_link.dart';
import '../organisms/register_form.dart';
import '../templates/auth_template.dart';
/// Account creation page that writes the profile to Firestore.
class RegisterPage extends ConsumerStatefulWidget { const RegisterPage({super.key}); @override ConsumerState<RegisterPage> createState()=>_RegisterPageState(); }
class _RegisterPageState extends ConsumerState<RegisterPage>{
 final _name=TextEditingController(),_email=TextEditingController(),_phone=TextEditingController(),_password=TextEditingController(),_confirm=TextEditingController(); final Map<String,String?> _errors={}; bool _agreed=false,_loading=false; String? _message;
 @override void dispose(){for(final c in [_name,_email,_phone,_password,_confirm]){c.dispose();}super.dispose();}
 String? _error(String key){final v=switch(key){'name'=>_name.text.trim(),'email'=>_email.text.trim(),'phone'=>_phone.text.trim(),'password'=>_password.text,'confirm'=>_confirm.text,_=>''}; switch(key){case 'name':return v.isEmpty?'Full name is required.':null;case 'email':return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v)?null:'Enter a valid email address.';case 'phone':return v.isEmpty?'Mobile number is required.':null;case 'password':return v.length>=8?null:'Password must be at least 8 characters.';case 'confirm':return v==_password.text?null:'Passwords do not match.';}return null;}
 void Function(String) _change(String key)=> (value){setState(()=>_errors.remove(key));}; VoidCallback _blur(String key)=>()=>setState(()=>_errors[key]=_error(key));
 bool get _valid=>['name','email','phone','password','confirm'].every((k)=>_error(k)==null)&&_agreed;
 Future<void> _submit()async{setState((){for(final k in ['name','email','phone','password','confirm']){_errors[k]=_error(k);}});if(!_valid)return;setState(()=>_loading=true);try{final credential=await ref.read(authRepositoryProvider).register(_email.text,_password.text);final uid=credential.user!.uid;await ref.read(userRepositoryProvider).createUser(uid:uid,name:_name.text,email:_email.text,phone:_phone.text);if(mounted)context.go(AppRoutes.loading);}catch(e){if(mounted)setState(()=>_message=ref.read(authRepositoryProvider).friendlyError(e));}finally{if(mounted)setState(()=>_loading=false);}}
 @override Widget build(BuildContext context)=>AuthTemplate(title:'Create account',subtitle:'It takes less than a minute',children:[RegisterForm(name:_name,email:_email,phone:_phone,password:_password,confirm:_confirm,errors:_errors,onChanged:_change,onBlur:_blur),Row(children:[AppCheckBox(value:_agreed,onChanged:(v)=>setState(()=>_agreed=v)),Expanded(child:Wrap(crossAxisAlignment:WrapCrossAlignment.center,children:[ Text('I agree to the ',style:AppTextStyles.bodySmall),AppLinkText(label:'Terms',onTap:()=>_showPolicy('Terms')), Text(' and ',style:AppTextStyles.bodySmall),AppLinkText(label:'Privacy Policy',onTap:()=>_showPolicy('Privacy Policy'))]))]),if(_message!=null)Text(_message!,style:AppTextStyles.error),AppButton(label:'Create account',enabled:_valid&&!_loading,loading:_loading,onPressed:_submit),FormFooterLink(prefix:'Already have an account? ',link:'Log in',onTap:()=>context.go(AppRoutes.login))]);
 void _showPolicy(String title)=>showDialog<void>(context:context,builder:(context)=>AlertDialog(title:Text(title),content:const Text('Please add your organization’s official terms and privacy policy before publishing.'),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Close'))]));
}
