<?php
/**
 * User: Alex Gusev <alex@flancer64.com>
 */
use Flancer32\Lib\Entity\Bonus\Type as BonusType;

include_once('phpunit_bootstrap.php');

class LibCall_UnitTest extends PHPUnit_Framework_TestCase {
    public function test_doCall() {
        $m1 = new Flancer32_Sample_LibCall();
        $resp = $m1->doCall();
        $this->assertEquals(25, $resp);
    }

    public function test_entity() {
        $name = BonusType::NAME;
        $attrId = BonusType::ATTR_ID;
        $attrValue = BonusType::ATTR_VALUE;
        $attrNote = BonusType::ATTR_NOTE;
        $this->assertEquals('fl32_sample_bonus_type', $name);
        $this->assertEquals('id', $attrId);
        $this->assertEquals('value', $attrValue);
        $this->assertEquals('note', $attrNote);
    }
}