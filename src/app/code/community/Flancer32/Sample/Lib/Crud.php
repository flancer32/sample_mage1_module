<?php
use Flancer32\Lib\Entity\Bonus\Type as BonusType;

/**
 * User: Alex Gusev <alex@flancer64.com>
 */
class Flancer32_Sample_Lib_Crud {
    /** @var \Flancer32\Lib\Service\Customer\Call() */
    private $_call;

    /**
     * Crud constructor.
     */
    public function __construct(\Flancer32\Lib\Service\Customer\Call $call) {
        $this->_call = $call;
    }

    /**
     * Perform low-level DB operations using common library.
     *
     * @return string
     */
    public function doDbOperations() {
        $result = false;
        $typeValue = 'personal';
        $typeNote = 'Personal Bonus';
        $typeNoteNew = 'Personal Bonus New';
        /* insert one record */
        $cols = [
            BonusType::ATTR_VALUE => $typeValue,
            BonusType::ATTR_NOTE  => $typeNote
        ];
        $id = $this->_call->dbInsert($cols);
        /* select one record by id */
        $record = $this->_call->dbSelect($id);
        if($record[BonusType::ATTR_VALUE] == $typeValue) {
            /* update one record */
            $updated = $this->_call->dbUpdate($id, [ BonusType::ATTR_NOTE => $typeNoteNew ]);
            if($updated > 0) {
                /* delete one record */
                $deleted = $this->_call->dbDelete($id);
                if($deleted) {
                    $result = true;
                }
            }
        }
        return $result;
    }
}