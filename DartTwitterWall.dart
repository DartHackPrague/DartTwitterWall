#import('dart:io');
#import('dart:uri');
#import('dart:json');

void main() {
  HttpClient client = new HttpClient(); 
  
  Uri streamUrl = new Uri.fromString(
    'http://search.twitter.com/search.json?q=darthack12'
  );
  
  HttpClientConnection conn = client.getUrl(streamUrl); 

  List<int> buffer = new List();
  
  conn.onResponse = (HttpClientResponse response) {
    
    InputStream inputStream = response.inputStream;
    
    StringInputStream lines = new StringInputStream( inputStream );
    
    lines.onLine = () {
      String stream = lines.readLine();
      Map<String,Dynamic> output = JSON.parse( stream );
      
      List<Map<String,Dynamic>> results = output["results"];
      
      for ( int i = 0; i < 5; i++) {
        print( results[i]['text'] + '\n from ' +
          results[i]['from_user_name'] + ' at ' + results[i]["created_at"] +
          "\n-------------------");
      }
      
      lines.onLine = null;
      inputStream.close();
    };
    
    lines.onClosed = () {
      
    };
    
  };
}
