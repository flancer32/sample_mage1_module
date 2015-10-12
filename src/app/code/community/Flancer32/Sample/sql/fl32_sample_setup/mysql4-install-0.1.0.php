<?php
/**
 * User: Alex Gusev <alex@flancer64.com>
 */
use Flancer32\Lib\Entity\Bonus\Type as BonusType;
use Flancer32_Sample_Config as Cfg;
use Varien_Db_Adapter_Interface as Db;
use Varien_Db_Ddl_Table as Ddl;

/** @var $installer Mage_Core_Model_Resource_Setup */
$installer = null;
if(get_class($this) == 'Mage_Core_Model_Resource_Setup') {
    /** Pre setup Mage routines in application mode. */
    $installer = $this;
} else {
    /** Pre setup Mage routines in PHPUnit mode. */
    $installer = Mage::getSingleton('core/resource_setup', Cfg::CFG_MOD_SETUP);
}

/**
 * Start module installation.
 */
/** @var $conn Varien_Db_Adapter_Pdo_Mysql */
$conn = $installer->getConnection();

/**
 * Prepare working variables.
 */

/** Pre setup Mage routines. */
$installer->startSetup();
$optId = array( 'identity' => true, 'primary' => true, 'nullable' => false, 'unsigned' => true );

/**
 * Table names.
 */
$tblBonusType = $installer->getTable(BonusType::NAME);


/** ********************************
 * Table for BonusType entity
 ******************************** */
$tbl = $conn->newTable($tblBonusType);
$tbl->addColumn(BonusType::ATTR_ID, Ddl::TYPE_INTEGER, null, $optId,
    'Instance ID.');
$tbl->addColumn(BonusType::ATTR_VALUE, Ddl::TYPE_TEXT, 255, array( 'nullable' => false ),
    'Value for the bonus type.');
$tbl->addColumn(BonusType::ATTR_NOTE, Ddl::TYPE_TEXT, 255, array( 'nullable' => false ),
    'Description of the type');
$tbl->setComment('Types of the available bonuses.');
$conn->createTable($tbl);

/** Post setup Mage routines. */
$installer->endSetup();
