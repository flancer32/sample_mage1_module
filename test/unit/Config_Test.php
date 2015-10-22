<?php
/**
 * Pseudo test just to do a show.
 *
 * User: Alex Gusev <alex@flancer64.com>
 */
namespace Flancer32\Sample\Test\Unit;

use Flancer32_Sample_Config as Cfg;

include_once(__DIR__ . '/phpunit_bootstrap.php');


class Config_Test extends \PHPUnit_Framework_TestCase {

    public function test_demo() {
        $this->assertTrue(is_string(Cfg::CFG_MOD));
    }

}