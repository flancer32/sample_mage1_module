<?php

/**
 * Call to common M1 & M2 library.
 *
 * User: Alex Gusev <alex@flancer64.com>
 */
class Flancer32_Sample_Lib_Call {
    /** @var \Flancer32\Lib\Service\Customer\Call() */
    private $_call;

    /**
     * Crud constructor.
     */
    public function __construct(\Flancer32\Lib\Service\Customer\Call $call) {
        $this->_call = $call;
    }

    public function doCall() {
        $result = $this->_call->operation(23);
        return $result;
    }
}