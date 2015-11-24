<?php
/**
 * Test M1 object that calls common lib.
 *
 * User: Alex Gusev <alex@flancer64.com>
 */
namespace Flancer32\Sample\Test\Functional\Lib;

use Flancer32\Lib\Context;

include_once(__DIR__ . '/../phpunit_bootstrap.php');

class Crud_Test extends \PHPUnit_Framework_TestCase {
    /**
     * Perform low-level CRUD operations using common library in functional mode (with DB connection).
     */
    public function test_doDbOperations() {
        $m1 = Context::instance()->getObjectManager()->create('\Flancer32_Sample_Lib_Crud');
        $resp = $m1->doDbOperations();
        $this->assertTrue($resp);
    }
}