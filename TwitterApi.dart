#library("twitterApi");

#import('dart:io');
#import('dart:uri');
#import('dart:json');

class Tweet {
  String userName;
  String text;
  String createdAt;
  String timeAgo;

  Tweet.fromMap(Map<String,Dynamic> map) {
    userName = map["from_user"];
    text = map["text"];
    createdAt = map["created_at"];
    timeAgo = timeAgoFromCreatedAt(createdAt);
  }
}

class TwitterApi {
  final String searchUrlPrefix = "http://search.twitter.com/search.json?q=";
  String searchQuery;

  HttpClient _client;
  Uri _uri;
  HttpClientConnection _conn;
  InputStream _inputStream;
  StringInputStream _stringInputStream;

  // Ctor
  TwitterApi([String this.searchQuery="darthack12"]) {
    _client = new HttpClient();
  }

  void close() {
    _client.shutdown();
  }

  Future<List<Tweet>> getTweets([int max=5]) {
    Completer completer = new Completer();

    fetchJsonString('$searchUrlPrefix$searchQuery')
    .then((String json) {
      if (json == null) {
        completer.complete([]);
        return;
      }
      Map<String,Dynamic> output = JSON.parse( json );
      if (output == null) {
        completer.complete([]);
        return;
      }
      List<Map<String,Dynamic>> results = output["results"];

      List<Tweet> tweets = new List<Tweet>();
      for (int i = 0; i < Math.min(max, results.length); i++) {
        tweets.add(new Tweet.fromMap(results[i]));
      }
      completer.complete(tweets);
    });

    return completer.future;
  }

  Future<String> fetchJsonString(String url) {
    Completer completer = new Completer();

    _uri = new Uri.fromString( url );
    _conn = _client.getUrl(_uri);

    _conn.onResponse = (HttpClientResponse response) {
      _stringInputStream = new StringInputStream( response.inputStream );

      _stringInputStream.onLine = () {
        String stream = _stringInputStream.readLine();
        if (!completer.future.isComplete) {
          completer.complete(stream);
        }
        response.inputStream.close();
      };
    };

    return completer.future;
  }
}

String timeAgoFromCreatedAt(String createdAt) {
  // Sun, 29 Apr 2012 09:42:51 +0000
  List<String> monthLookup = const ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  RegExp dateMatch = new RegExp(@"(\w+), (\d+) (\w+) (\d+) (\d\d):(\d\d):(\d\d) ((\+|\-)\d\d\d\d)");

  Match m = dateMatch.firstMatch(createdAt);
  int day = Math.parseInt(m.group(2));
  String monthStr = m.group(3);
  int month = monthLookup.indexOf(monthStr) + 1;
  int year = Math.parseInt(m.group(4));
  int hour = Math.parseInt(m.group(5));
  int minute = Math.parseInt(m.group(6));
  int second = Math.parseInt(m.group(7));

  Date now = new Date.now();
  Date date = new Date.withTimeZone(year, month, day, hour, minute, second, 0, new TimeZone.utc());
  Duration diff = now.difference(date);

  if (diff.inDays > 0) {
    return "${diff.inDays} days ago";
  } else if (diff.inHours > 1) {
    return "${diff.inHours} hours ago";
  } else if (diff.inHours > 0) {
    return "1 hour and ${diff.inMinutes} minutes ago";
  } else if (diff.inMinutes > 0) {
    return "${diff.inMinutes} minutes ago";
  } else if (diff.inSeconds > 20) {
    return "${diff.inSeconds} seconds ago";
  } else {
    return "just now";
  }

  return "$date";
}