<?php

$input = file_get_contents("input.txt");
$lines = explode(",", $input);
$numbers = array_map(function($line) {
    return intval($line);
}, $lines);

part1($numbers);
echo "\n";
part2($numbers);

function part1($numbers) {
    $numbers[1] = 12;
    $numbers[2] = 2;
    $pos = 0;

    while (true) {
        $opCode = $numbers[$pos];
        
        if ($opCode == 99) {
            break;
        }

        $posInputA = $numbers[$pos+1];
        $posInputB = $numbers[$pos+2];
        $posResult = $numbers[$pos+3];

        if ($opCode == 1) {
            $numbers[$posResult] = $numbers[$posInputA] + $numbers[$posInputB];
        } else if ($opCode == 2) {
            $numbers[$posResult] = $numbers[$posInputA] * $numbers[$posInputB];
        } else {
            die("Unknown opcode $opCode");
        }

        $pos += 4;
    }
    
    echo "Final value of position 0 is $numbers[0]";
}

function part2($originalNumbers) {
    for ($i = 0; $i <= 99; $i++) {
        for ($j = 0; $j <= 99; $j++) {
            $output = outputForInputs($originalNumbers, $i, $j);
            if ($output == 19690720) {
                echo "Result reached with noun $i and verb $j \n";
                $answer = (100 * $i) + $j;
                echo "Answer is $answer";
            }
        }
    }
}

function outputForInputs($numbers, $noun, $verb) {
    $numbers[1] = $noun;
    $numbers[2] = $verb;
    $pos = 0;

    while (true) {
        $opCode = $numbers[$pos];
        
        if ($opCode == 99) {
            break;
        }

        $posInputA = $numbers[$pos+1];
        $posInputB = $numbers[$pos+2];
        $posResult = $numbers[$pos+3];

        $inputA = $numbers[$posInputA];
        $inputB = $numbers[$posInputB];

        $output;

        if ($opCode == 1) {
            $output = $inputA + $inputB;
        } else if ($opCode == 2) {
            $output = $inputA * $inputB;
        } else {
            die("Unknown opcode $opCode");
        }

        $numbers[$posResult] = $output;

        $pos += 4;
    }
    
    return $numbers[0];
}