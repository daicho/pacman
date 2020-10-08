<?php
// クエリ文を取得
if (!array_key_exists("query", $_POST))
    exit();

$query = urldecode($_POST["query"]);

// データベースに接続
$dbh = new PDO(
    "mysql:host=mysql2014.db.sakura.ne.jp; dbname=nitnc5j_pacman; charset=utf8",
    "nitnc5j",
    "5jclassarai"
);

// クエリ文の実行
$stmt = $dbh->query($query);

// 結果の返却
$rtn = false;

while ($row = $stmt->fetch(PDO::FETCH_NUM)) {
    if ($rtn)
        print("\n");
    else
        $rtn = true;

    $spc = false;

    for ($i = 0; $i < count($row); $i++) {
        if ($spc)
            print(",");
        else
            $spc = true;

        print($row[$i]);
    }
}
