mixin Config {

  //development
  static const String baseUrl = 'https://dgmz4vcdmz09w.cloudfront.net/api/';

  // // staging
  // static const String baseUrl = '';
  // static const String imageUrl = '';

  //production
  // static const String baseUrl = '';
  // static const String imageUrl = '';

}

enum LoadingStatus {
  loading,
  completed,
  error,
}

// Enum to represent social identifiers
enum SocialIdentifier { facebook, apple, google }

// Function to get the social identifier code
int getSocialIdentifier(SocialIdentifier socialIdentifier) {
  int code;
  switch (socialIdentifier) {
    case SocialIdentifier.facebook:
      code = 1; // Facebook identifier code
      break;
    case SocialIdentifier.apple:
      code = 2; // Apple identifier code
      break;
    case SocialIdentifier.google:
      code = 3; // Google identifier code
      break;
  }
  return code;
}

String timeZone = DateTime.now().timeZoneName;
