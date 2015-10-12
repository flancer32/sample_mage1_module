<?php
use Flancer32_Sample_Config as Cfg;


/** Include phpunit_bootstrap to load Mage.php. */
include_once('../../../phpunit_bootstrap.php');

class Install_0_1_0_DvlpTest extends PHPUnit_Framework_TestCase {

    public function test_install() {
        /** @var  $conn Varien_Db_Adapter_Pdo_Mysql */
        $conn = Mage::getSingleton('core/resource_setup', Cfg::CFG_MOD_SETUP)->getConnection();
        $conn->beginTransaction();
        include_once('../../../sql/fl32_sample_setup/mysql4-install-0.1.0.php');
        $conn->rollback();
    }
}