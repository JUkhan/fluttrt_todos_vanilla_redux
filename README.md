# todo_vanilla_redux

A new Flutter project.

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

## localization command

flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/localization/localizations.dart

flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/intl_en.arb lib/l10n/intl_messages.arb  lib/localization/localizations.dart