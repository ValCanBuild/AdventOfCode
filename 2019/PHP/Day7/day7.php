<?php

$input = file_get_contents("input.txt");
$lines = explode(",", $input);
$numbers = array_map(function ($line) {
    return intval($line);
}, $lines);

// part1($numbers);
// echo "\n\n";
part2($numbers);

function part1($numbers)
{
    echo "Part 1:\n";

    $maxSignal = 0;

    $phaseSettings = array(0, 1, 2, 3, 4);


    for ($i = 0; $i < 1000; $i++) {
        $shuffled = $phaseSettings;
        shuffle($shuffled);

        $output = runWithSettings($shuffled, $numbers);

        $maxSignal = max($output, $maxSignal); 
    }

    echo "Max thruster signal is $maxSignal";
}

function part2($numbers)
{
    echo "Part 2:\n";
    
    $maxSignal = 0;

    $phaseSettings = array(9,8,7,6,5);
    $output = runWithSettingsAndFeedback($phaseSettings, $numbers);
    echo "Max thruster signal is $output";


    // for ($i = 0; $i < 1000; $i++) {
    //     $shuffled = $phaseSettings;
    //     shuffle($shuffled);

    //     $output = runWithSettingsAndFeedback($shuffled, $numbers);

    //     $maxSignal = max($output, $maxSignal); 
    // }

    // echo "Max thruster signal is $maxSignal";
}

function runWithSettings($phaseSettings, $numbers)
{
    $lastOutput = 0;
    foreach ($phaseSettings as $setting) {
        $lastOutput = outputForInput($numbers, $setting, $lastOutput);
    }

    return $lastOutput;
}

function runWithSettingsAndFeedback($phaseSettings, $numbers)
{
    $lastOutput = 0;
    while (true) {
        foreach ($phaseSettings as $setting) {
            $output = outputForInput($numbers, $setting, $lastOutput);
            if ($output >= 139629729) {
                echo "reached the output";
            }

            if ($output != PHP_INT_MIN) {
                $lastOutput = $output;
            } else {
                return $lastOutput;
            }
        }
    }
}

function outputForInput($numbers, $phaseSetting, $amplifierInput)
{
    $pos = 0;
    $waitingForFirstInput = true;

    while (true) {
        $opCode = $numbers[$pos];

        $opCodeStr = (string) $opCode;
        $length = strlen($opCodeStr);

        $instruction = $length >= 2 ? (intval($opCodeStr[$length - 1] + $opCodeStr[$length - 2])) : $opCode;

        if ($instruction == 99) {
            return PHP_INT_MIN;
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
                $numbers[$posInputA] = $waitingForFirstInput ? $phaseSetting : $amplifierInput;
                if ($waitingForFirstInput) {
                    $waitingForFirstInput = false;
                }
                $pos += 2;
                break;
            case 4:
                return $numbers[$posInputA];
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
                return PHP_INT_MIN;
        }
    }
}
