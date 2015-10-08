<?php

/**
 * User: Alex Gusev <alex@flancer64.com>
 */
class Flancer32_Sample_LibCall {

    public function doCall() {
        /** @var  $lib Flancer32\Lib\Service\Customer\Call */
        $lib = new Flancer32\Lib\Service\Customer\Call();
        $result = $lib->operation(23);
        return $result;
    }

}