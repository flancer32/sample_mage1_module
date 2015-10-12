<?php
/**
 * Create M2 object that calls common library method.
 *
 * User: Alex Gusev <alex@flancer64.com>
 */

/** Include phpunit_bootstrap to load Mage.php. */
include_once('../../phpunit_bootstrap.php');

class Call_UnitTest extends PHPUnit_Framework_TestCase {

    /**
     * Call to M1 class that calls to common library method.
     */
    public function test_doCall() {
        $m1 = new Flancer32_Sample_Lib_Call();
        $resp = $m1->doCall();
        $this->assertEquals(25, $resp);
    }

}