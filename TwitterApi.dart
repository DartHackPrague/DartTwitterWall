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
  String searchQuery = const "darthack12";

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
    fetchJsonString('$searchUrlPrefix$searchQuery');


    return [new Tweet()];
  }

  Future<String> fetchJsonString(String url) {
    _uri = new Uri.fromString( url );
    _conn = client.getUrl(streamUrl);
  }

  void printRecentTweets(HttpClient client) {

    conn.onResponse = (HttpClientResponse response) {
      inputStream = response.inputStream;
      lines = new StringInputStream( inputStream );

      lines.onLine = () {
        String stream = lines.readLine();
        Map<String,Dynamic> output = JSON.parse( stream );

        List<Map<String,Dynamic>> results = output["results"];

        for ( int i = 0; i < 5; i++) {
          print( results[i]['text'] + '\n from ' +
            results[i]['from_user_name'] + ' at ' + results[i]["created_at"] +
            "\n-------------------");
        }

        inputStream.close();
      };
    };


  }

  void init() {

  }


}
