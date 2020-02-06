<?php
include_once 'transaction.php';
$data = json_decode( file_get_contents('php://input') );
$resp = new class{};
$resp->uid = validateUser($data->user,$data->password);
if($resp->uid!==0){
session_start(); 
$resp->isValid= true;  
$_SESSION['session_id']   =  $resp->uid;
}
echo json_encode($resp);

?>