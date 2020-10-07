import http.requests.*;

String url = "https://nitnc5j.sakura.ne.jp/pacman/mysql/query.php";
// テトリス: "https://nitnc5j.sakura.ne.jp/tetris/mysql/query.php"
// UNAGI   : "https://nitnc5j.sakura.ne.jp/unagi/mysql/query.php"

PostRequest post = new PostRequest(url);

// ここにクエリ文を書く
post.addData("query", "SELECT * FROM ranking");
post.send();

// ここに結果が返ってくる
println(post.getContent());
