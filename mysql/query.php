<?php
// データベースに接続
require_once(dirname(__FILE__). "/connect.php");

$query = $_POST["query"];

// クエリ文の実行
$stmt = $dbh->query($query);

$rtn = true;

while ($row = $stmt->fetch()) {
    $spc = true;
    
    for ($i = 0; $i < count($row); $i++) {
        print($row[$i]);
        
        if ($spc) {
            print(" ");
            $spc = false;
        }
    }

    if ($rtn) {
        print("\n");
        $rtn = false;
    }
}
