<?php

$input = file_get_contents("input.txt");
$lines = explode(",", $input);
$numbers = array_map(function ($line) {
    return intval($line);
}, $lines);

part1($numbers);
// echo "\n\n";
// part2($numbers);

function part1($numbers)
{
    echo "Part 1:\n";
    outputForInput($numbers, 1);
}

function part2($numbers)
{
    echo "Part 2:\n";
    outputForInput($numbers, 5);
}

function outputForInput($numbers, $input)
{
    $pos = 0;

    while (true) {
        $opCode = $numbers[$pos];

        $opCodeStr = (string) $opCode;
        $length = strlen($opCodeStr);

        $instruction = $length >= 2 ? (intval($opCodeStr[$length - 1] + $opCodeStr[$length - 2])) : $opCode;

        if ($instruction == 99) {
            break;
        }

        $paramModeA = $length >= 3 ? intval($opCodeStr[$length - 3]) : 0;
        $paramModeB = $length >= 4 ? intval($opCodeStr[$length - 4]) : 0;

        $posInputA = $numbers[$pos + 1];

        $exit = false;

        switch ($instruction) {
            case 1:
                $posInputB = $numbers[$pos + 2];
                $posResult = $numbers[$pos + 3];

                $inputA = $paramModeA == 0 ? $numbers[$posInputA] : $posInputA;
                $inputB = $paramModeB == 0 ? $numbers[$posInputB] : $posInputB;
                $numbers[$posResult] = $inputA + $inputB;
                $pos += 4;
                break;
            case 2:
                $posInputB = $numbers[$pos + 2];
                $posResult = $numbers[$pos + 3];

                $inputA = $paramModeA == 0 ? $numbers[$posInputA] : $posInputA;
                $inputB = $paramModeB == 0 ? $numbers[$posInputB] : $posInputB;
                $numbers[$posResult] = $inputA * $inputB;
                $pos += 4;
                break;
            case 3:
                $numbers[$posInputA] = $input;
                $pos += 2;
                break;
            case 4:
                echo "Output $numbers[$posInputA]";
                echo "\n";
                $pos += 2;
                break;
            case 5:
                $posInputB = $numbers[$pos + 2];
                $inputA = $paramModeA == 0 ? $numbers[$posInputA] : $posInputA;
                $inputB = $paramModeB == 0 ? $numbers[$posInputB] : $posInputB;
                if ($inputA != 0) {
                    $pos = $inputB;
                } else {
                    $pos += 3;
                }
                break;
            case 6:
                $posInputB = $numbers[$pos + 2];
                $inputA = $paramModeA == 0 ? $numbers[$posInputA] : $posInputA;
                $inputB = $paramModeB == 0 ? $numbers[$posInputB] : $posInputB;
                if ($inputA == 0) {
                    $pos = $inputB;
                } else {
                    $pos += 3;
                }
                break;
            case 7:
                $posInputB = $numbers[$pos + 2];
                $posResult = $numbers[$pos + 3];
                $inputA = $paramModeA == 0 ? $numbers[$posInputA] : $posInputA;
                $inputB = $paramModeB == 0 ? $numbers[$posInputB] : $posInputB;
                $numbers[$posResult] = $inputA < $inputB ? 1 : 0;

                $pos += 4;
                break;
            case 8:
                $posInputB = $numbers[$pos + 2];
                $posResult = $numbers[$pos + 3];
                $inputA = $paramModeA == 0 ? $numbers[$posInputA] : $posInputA;
                $inputB = $paramModeB == 0 ? $numbers[$posInputB] : $posInputB;
                $numbers[$posResult] = $inputA == $inputB ? 1 : 0;

                $pos += 4;
                break;
            default:
                echo "Unknown instruction, exiting";
                $exit = true;
                break;
        }

        if ($exit) {
            break;
        }
    }
}
