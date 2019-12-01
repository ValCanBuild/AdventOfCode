<?php

$input = file_get_contents("input.txt");
$lines = explode("\n", $input);

// part1($lines);
part2($lines);

function part1($lines) {
    $sum = 0;
    foreach ($lines as $line) {
        $value = intval($line);
        $fuel = floor($value / 3) - 2;
        $sum += $fuel;
    }
    
    echo "Final sum is $sum";
}

function part2($lines) {
    $sum = 0;
    foreach ($lines as $line) {
        $value = intval($line);
        $fuel = fuelReq($value);
        $sum += $fuel;
    }
    
    echo "Final sum is $sum";
}

function fuelReq(int $mass) {
    $fuel = floor($mass / 3) - 2;
    if ($fuel <= 0) {
        return 0;
    }
    return $fuel += fuelReq($fuel);
}