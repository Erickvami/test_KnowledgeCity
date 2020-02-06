<?php
include_once 'transaction.php';
$data = json_decode( file_get_contents('php://input') );
session_start();
$resp = new class{};

if($_SESSION['session_id']){
    $resp->rows = getUsers($data->from,$data->to);
    $resp->total =  getUsersCount();
}
else{
    $_SESSION['session_id'] = null;
    $resp->rows = [];
    $resp->total =  0;
    $resp->noSession = true;
}
echo json_encode($resp);

?>