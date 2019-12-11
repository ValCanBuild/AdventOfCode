<?php

include '../Intcode/intcode.php';

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
    $pointerPos = 0;
    $nextInput = $input;

    while (true) {
        $intCode = new IntCode($numbers[$pointerPos], $pointerPos, function() use ($nextInput) {
            return $nextInput;
        }, function($output) use (&$nextInput) {
            echo "Output $output\n";
            $nextInput = $output;
        });

        $pointerPos = $intCode->performOp($numbers);
        if ($pointerPos == -1) {
            break;
        }
    }
}