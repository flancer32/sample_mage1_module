<?php
/**
 * User: Alex Gusev <alex@flancer64.com>
 */

include_once('phpunit_bootstrap.php');

class LibCall_UnitTest extends PHPUnit_Framework_TestCase {
    public function test_doCall() {
        $m1 = new Flancer32_Sample_LibCall();
        $resp = $m1->doCall();
        $this->assertEquals(25, $resp);
    }
}