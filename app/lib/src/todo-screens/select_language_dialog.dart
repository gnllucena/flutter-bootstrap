import 'package:flutter/material.dart';
import 'package:zerodezenove/src/configurations/localization.dart';
import 'package:zerodezenove/src/configurations/spacing.dart';
import 'package:zerodezenove/src/notifiers/settings_notifier.dart';
import 'package:zerodezenove/src/widgets/FX/text/text.dart';
import 'package:provider/provider.dart';

class SelectLocalizationDialog extends StatefulWidget {
  const SelectLocalizationDialog({Key? key}) : super(key: key);

  @override
  _SelectLocalizationDialogState createState() =>
      _SelectLocalizationDialogState();
}

class _SelectLocalizationDialogState extends State<SelectLocalizationDialog> {
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

    for (Language idiom in Localization.getLanguages()) {
      list.add(InkWell(
        onTap: () => _handleChange(idiom),
        child: Container(
          padding: Spacing.horizontal(16),
          child: Row(
            children: <Widget>[
              Radio<Language>(
                value: idiom,
                groupValue: Localization.getCurrentLanguage(),
                onChanged: (Language? value) {
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

  Future<void> _handleChange(Language idiom) async {
    setState(() {
      Provider.of<SettingsNotifier>(context, listen: false)
          .updateLocalization(idiom);
    });

    Navigator.pop(context);
  }
}
