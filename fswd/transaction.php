<?php

function getKeys(){
    $keys = file_get_contents("mysql.json");
    return json_decode($keys);
}
function validateUser($email,$password){
    $keys = getKeys();
    $db = new mysqli($keys->host, $keys->user, $keys->password, "class");
    if ($db->connect_errno) {
        return json_encode($db->connect_error);
    }
    $query ="call login(\"".$email."\",\"".md5($password)."\")";
    $result = $db->query($query);
        if($result){
            $row = $result->fetch_object();
            return $row? $row->uid:0;
        }
        return 0;
}
function getUsers($from,$to){
    $keys = getKeys();
    $db = new mysqli($keys->host, $keys->user, $keys->password, "class");
    if ($db->connect_errno) {
        return json_encode($db->connect_error);
    }
    $result = $db->query("call getStudents(".$from.",".$to.")");
        
        if($result){
            while ($row = $result->fetch_object()){
                $user_arr[] = $row;
            }
            $result->close();
        }
    return $user_arr;
}
function getUsersCount(){
    $keys = getKeys();
    $db = new mysqli($keys->host, $keys->user, $keys->password, "class");
    if ($db->connect_errno) {
        return json_encode($db->connect_error);
    }
    $result = $db->query("call countStudents()");
        if($result){
            $count = $result->fetch_object();
            $result->close();
        }
    return $count? $count->counting:0;
}
?>