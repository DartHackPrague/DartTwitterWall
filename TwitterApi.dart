#library("twitterApi");

#import('dart:io');
#import('dart:uri');
#import('dart:json');

class Tweet {
  String userName;
  String text;
  String createdAt;

}

class TwitterApi {

  final String searchUrlPrefix = "http://search.twitter.com/search.json?q=";
  String searchQuery = "darthack12";

  HttpClient _client;
  Uri _uri;
  HttpClientConnection _conn;
  InputStream _inputStream;
  StringInputStream _stringInputStream;

  // Ctor
  TwitterApi() {
    _client = new HttpClient();


  }

  void close() {
    _client.shutdown();
  }

  Future<List<Tweet>> getTweets([int max=5]) {
    Tweet tw = new Tweet();
    tw.userName = "filiphracek";
    tw.text = "This is a mock tweet";
    tw.createdAt = "Sunday....";

    return new Future.immediate([tw]);
  }

  Future<List<Tweet>> getTweetsTEMP([int max=5]) {
    Completer completer = new Completer();
    fetchJsonString('$searchUrlPrefix$searchQuery');


    return completer.future;
    // return new Future.immediate([new Tweet()]);
  }

  Future<String> fetchJsonString(String url) {
    Completer completer = new Completer();

    _uri = new Uri.fromString( url );
    _conn = client.getUrl(streamUrl);

    _conn.onResponse = (HttpClientResponse response) {
      _stringInputStream = new StringInputStream( response.inputStream );

      _stringInputStream.onLine = () {
        String stream = lines.readLine();
        Map<String,Dynamic> output = JSON.parse( stream );

        List<Map<String,Dynamic>> results = output["results"];

        for ( int i = 0; i < 5; i++) {
          print( results[i]['text'] + '\n from ' +
            results[i]['from_user_name'] + ' at ' + results[i]["created_at"] +
            "\n-------------------");
        }
      };
    };

    return completer.future;
  }

}
