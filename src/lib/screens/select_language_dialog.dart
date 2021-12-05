import 'package:flutter/material.dart';
import 'package:zerodezenove/configurations/language.dart';
import 'package:zerodezenove/configurations/spacing.dart';
import 'package:zerodezenove/notifiers/settings_notifier.dart';
import 'package:zerodezenove/widgets/text/text.dart';
import 'package:provider/provider.dart';

class SelectLanguageDialog extends StatefulWidget {
  const SelectLanguageDialog({Key? key}) : super(key: key);

  @override
  _SelectLanguageDialogState createState() => _SelectLanguageDialogState();
}

class _SelectLanguageDialogState extends State<SelectLanguageDialog> {
  late ThemeData theme;

  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Consumer<SettingsNotifier>(
      builder: (BuildContext context, SettingsNotifier value, Widget? child) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
                mainAxisSize: MainAxisSize.min, children: _buildOptions()),
          ),
        );
      },
    );
  }

  _buildOptions() {
    List<Widget> list = [];

    for (Idiom idiom in Language.getIdioms()) {
      list.add(InkWell(
        onTap: () => _handleChange(idiom),
        child: Container(
          padding: Spacing.horizontal(16),
          child: Row(
            children: <Widget>[
              Radio<Idiom>(
                value: idiom,
                groupValue: Language.getCurrentIdiom(),
                onChanged: (Idiom? value) {
                  if (value != null) {
                    _handleChange(value);
                  }
                },
                activeColor: theme.colorScheme.primary,
              ),
              FxText.sh2(
                idiom.name,
                fontWeight: 600,
              ),
            ],
          ),
        ),
      ));
    }

    return list;
  }

  Future<void> _handleChange(Idiom idiom) async {
    setState(() {
      Provider.of<SettingsNotifier>(context, listen: false)
          .updateLanguage(idiom);
    });

    Navigator.pop(context);
  }
}
