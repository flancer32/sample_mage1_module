<?php
/* BP is defined in Magento v1 "./app/Mage.php" or Magento v2 "./app/autoload.php" */
if(!defined('BP')) {
    /* Start M1 app */
    include_once(__DIR__ . '/../../../../../htdocs/app/Mage.php');
    // Start Magento application
    Mage::app('default');
    // Avoid issues "Headers already send"
    session_start();
}
