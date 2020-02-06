<?php
 session_start();
 $_SESSION['session_id'] = null;
 session_destroy();
 header("Location: /fswd/login.html");
?>