<?php
/**
 * Call to common M1 & M2 library.
 *
 * User: Alex Gusev <alex@flancer64.com>
 */
class Flancer32_Sample_Lib_Call {

    public function doCall() {
        /** @var  $lib Flancer32\Lib\Service\Customer\Call */
        $lib = new Flancer32\Lib\Service\Customer\Call();
        $result = $lib->operation(23);
        return $result;
    }
}