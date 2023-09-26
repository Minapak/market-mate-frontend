import 'package:sip_app/helpers/theme/app_theme.dart';
import 'package:sip_app/helpers/widgets/my_button.dart';
import 'package:sip_app/helpers/widgets/my_spacing.dart';
import 'package:sip_app/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class signinpleaseScreen extends StatefulWidget {
  @override
  _signinpleaseScreenState createState() => _signinpleaseScreenState();
}

class _signinpleaseScreenState extends State<signinpleaseScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              LucideIcons.chevronLeft,
              size: 20,
            ),
          ),
     //     title: MyText.titleMedium("Cart", fontWeight: 600),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                  image: AssetImage(
                    './assets/logos/logo_sip.png',
                  ),
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: MediaQuery.of(context).size.width * 0.5),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: MyText.titleMedium("로그인을 해주세요!",
                    color: theme.colorScheme.onBackground,
                    fontWeight: 600,
                    letterSpacing: 0),
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: MyButton(
                    elevation: 0,
                    borderRadiusAll: 4,
                    padding: MySpacing.xy(12, 16),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: MyText.bodyMedium("로그인",
                        fontWeight: 600,
                        color: theme.colorScheme.onPrimary,
                        letterSpacing: 0.5)),
              )
            ],
          ),
        ));
  }
}
