<?php
/**
 * Stub test linked to lib script.
 *
 * User: Alex Gusev <alex@flancer64.com>
 */
use Praxigento\Core\Lib\Context as Context;

include_once(__DIR__ . '/phpunit_bootstrap.php');

class Context_FunctionalTest extends \PHPUnit_Framework_TestCase {

    protected function setUp() {
        Context::reset();
    }

    public function test_connection() {
        /* get singleton instance */
        $ctx = Context::get();
        $this->assertTrue($ctx instanceof \Praxigento\Core\Lib\Context);
        $conn = $ctx->getConnection();
        $this->assertTrue($conn instanceof \Zend_Db_Adapter_Pdo_Mysql);
        $this->assertTrue($conn->isConnected());
    }
}