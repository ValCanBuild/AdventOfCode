<?php

$input = file_get_contents("input.txt");
$lines = explode(",", $input);
$numbers = array_map(function($line) {
    return intval($line);
}, $lines);

part1($numbers);
// part2($lines);

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

function part2($lines) {
    
}
