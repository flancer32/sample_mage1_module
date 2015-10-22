<?php
/**
 * Test M1 object that calls common lib.
 *
 * User: Alex Gusev <alex@flancer64.com>
 */
namespace Flancer32\Sample\Test\Unit\Lib;

include_once(__DIR__ . '/../phpunit_bootstrap.php');

class Call_Test extends \PHPUnit_Framework_TestCase {
    /**
     * Call to M1 class that calls to common library method.
     */
    public function test_doCall() {
        $m1 = new \Flancer32_Sample_Lib_Call();
        $resp = $m1->doCall();
        $this->assertEquals(25, $resp);
    }
}