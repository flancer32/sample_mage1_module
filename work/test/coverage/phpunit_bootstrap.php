<?php
/* Composer autoloader. */
include_once(__DIR__ . '/../../vendor/autoload.php');
/**
 * Traverse up and lookup for the './mage/' folder to add to 'include_path'.
 */
if(!class_exists('Mage')) {
    include_once(__DIR__ . '/../../htdocs/app/Mage.php');
    if(!defined('IS_M1_TESTS')) {
        define('IS_M1_TESTS', true);
    }
    // Start Magento application
    Mage::app('default');
    // Avoid issues "Headers already send"
    session_start();
}