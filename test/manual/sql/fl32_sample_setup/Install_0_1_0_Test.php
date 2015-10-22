<?php
/**
 * Manual tests to create database schema.
 */
use Flancer32\Lib\Entity\Bonus\Type as BonusType;
use Flancer32_Sample_Config as Cfg;

/** Include phpunit_bootstrap to load Mage.php. */
include_once(__DIR__ . '/../../phpunit_bootstrap.php');

class Install_0_1_0_Test extends PHPUnit_Framework_TestCase {

    public function test_install() {
        /** @var  $resource \Mage_Catalog_Model_Resource_Setup */
        $resource = \Mage::getSingleton('core/resource_setup', Cfg::CFG_MOD_SETUP);
        /** @var  $conn \Varien_Db_Adapter_Pdo_Mysql */
        $conn = \Mage::getSingleton('core/resource_setup', Cfg::CFG_MOD_SETUP)->getConnection();
        $tbl = $resource->getTable(BonusType::NAME);
        $conn->dropTable($tbl);
        include_once('../../../sql/fl32_sample_setup/mysql4-install-0.1.0.php');
    }
}