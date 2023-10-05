astrologerLanguage(String ids) {
  String languages = '';
  List languageList = [];

  if (ids != '') {
    ids.split(',').forEach((element) {
      if (element == '1') {
        languageList.add('English');
      }
      if (element == '2') {
        languageList.add('Hindi');
      }
      if (element == '3') {
        languageList.add('Tamil');
      }
      if (element == '5') {
        languageList.add('Punjabi');
      }
      if (element == '6') {
        languageList.add('Bengali');
      }
      if (element == '7') {
        languageList.add('Malyalam');
      }
      if (element == '8') {
        languageList.add('Marathi');
      }
      if (element == '9') {
        languageList.add('Orriya');
      }
      if (element == '10') {
        languageList.add('Gujrati');
      }
    });
    languages = languageList.join(', ');
  } else {}

  return languages;
}
