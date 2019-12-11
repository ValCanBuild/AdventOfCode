<?php

class IntCode
{
    public const OP_HALT = 99;
    public const OP_ADD = 1;
    public const OP_MULT = 2;
    public const OP_INPUT = 3;
    public const OP_OUTPUT = 4;
    public const OP_JUMP_TRUE = 5;
    public const OP_JUMP_FALSE = 6;
    public const OP_LESS_THAN = 7;
    public const OP_EQUALS = 8;

    public const PARAM_MODE_POS = 0;
    public const PARAM_MODE_IMMEDIATE = 1;

    private $instruction;
    private $pointerPos;
    private $paramModeA;
    private $paramModeB;
    private $paramModeC;
    private $inputFun;
    private $outputFun;

    public function __construct($opCode, $pointerPos, $inputFun, $outputFun)
    {
        $opCodeStr = (string) $opCode;
        $this->pointerPos = $pointerPos;
        $length = strlen($opCodeStr);

        $this->instruction = $length >= 3 ? (intval($opCodeStr[$length - 1] + $opCodeStr[$length - 2])) : $opCode;
        $this->paramModeA = $length >= 3 ? intval($opCodeStr[$length - 3]) : 0;
        $this->paramModeB = $length >= 4 ? intval($opCodeStr[$length - 4]) : 0;
        $this->paramModeC = $length >= 5 ? intval($opCodeStr[$length - 5]) : 0;

        $this->inputFun = $inputFun;
        $this->outputFun = $outputFun;
    }

    public function getInstruction()
    {
        return $this->instruction;
    }

    public function getParamModeA()
    {
        return $this->paramModeA;
    }

    public function getParamModeB()
    {
        return $this->paramModeB;
    }

    private function getInputA($numbers)
    {
        $posInput = $numbers[$this->pointerPos + 1];
        switch ($this->paramModeA) {
            case IntCode::PARAM_MODE_POS:
                return $numbers[$posInput];
            case IntCode::PARAM_MODE_IMMEDIATE:
                return $posInput;
        }
    }

    private function getInputB($numbers)
    {
        $posInput = $numbers[$this->pointerPos + 2];
        switch ($this->paramModeB) {
            case IntCode::PARAM_MODE_POS:
                return $numbers[$posInput];
            case IntCode::PARAM_MODE_IMMEDIATE:
                return $posInput;
        }
    }

    private function getInputC($numbers)
    {
        $posInput = $numbers[$this->pointerPos + 3];
        switch ($this->paramModeC) {
            case IntCode::PARAM_MODE_POS:
                return $numbers[$posInput];
            case IntCode::PARAM_MODE_IMMEDIATE:
                return $posInput;
        }
    }

    public function performOp(&$numbers)
    {
        switch ($this->instruction) {
            case IntCode::OP_HALT:
                return -1;
            case IntCode::OP_ADD:
                $resultPos = $numbers[$this->pointerPos + 3];
                $numbers[$resultPos] = $this->getInputA($numbers) + $this->getInputB($numbers);
                return $this->pointerPos + 4;
            case IntCode::OP_MULT:
                $resultPos = $numbers[$this->pointerPos + 3];
                $numbers[$resultPos] = $this->getInputA($numbers) * $this->getInputB($numbers);
                return $this->pointerPos + 4;
            case IntCode::OP_INPUT:
                $input = call_user_func($this->inputFun);
                $addressLoc = $numbers[$this->getInputA($numbers)];
                $numbers[$addressLoc] = $input;
                return $this->pointerPos + 2;
            case IntCode::OP_OUTPUT:
                $addressLoc = $this->pointerPos + 1;
                call_user_func($this->outputFun, $numbers[$addressLoc]);
                return $this->pointerPos + 2;
            case IntCode::OP_JUMP_TRUE:
                if ($this->getInputA($numbers) != 0) {
                    return $this->getInputB($numbers);
                } else {
                    return $this->pointerPos + 3;
                }
            case IntCode::OP_JUMP_FALSE:
                if ($this->getInputA($numbers) == 0) {
                    return $this->getInputB($numbers);
                } else {
                    return $this->pointerPos + 3;
                }
            case IntCode::OP_LESS_THAN:
                $numbers[$this->getInputC($numbers)] = $this->getInputA($numbers) < $this->getInputB($numbers) ? 1 : 0;
                return $this->pointerPos + 4;
            case IntCode::OP_EQUALS:
                $numbers[$this->getInputC($numbers)] = $this->getInputA($numbers) == $this->getInputB($numbers) ? 1 : 0;
                return $this->pointerPos + 4;
            default:
                echo "Unknown instruction, exiting";
                return -1;
        }
    }
}
