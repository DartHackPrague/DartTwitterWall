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
      }
      Map<String,Dynamic> output = JSON.parse( json );
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
        completer.complete(stream);
      };
    };

    return completer.future;
  }
}

String timeAgoFromCreatedAt(String createdAt) {
  /*
  RegExp dateMatch = new RegExp();
  Date date = new Date.fromString(createdAt);
  return date.hours.toString();
  */
  return "not yet implemented";
}