<?php
/**
 * Perform low-level CRUD operations using common library in development mode (with DB connection).
 *
 * User: Alex Gusev <alex@flancer64.com>
 */

/** Include phpunit_bootstrap to load Mage.php. */
include_once('../../phpunit_bootstrap.php');

class Crud_UnitTest extends PHPUnit_Framework_TestCase {

    public function test_doDbOperations() {
        $m1 = new Flancer32_Sample_Lib_Crud();
        $resp = $m1->doDbOperations();
        $this->assertTrue($resp);
    }

}