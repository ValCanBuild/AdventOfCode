<?php

$inputFile = fopen("input.txt", "r") or die("Unable to open file!");
$read = fread($inputFile, filesize("input.txt"));
fclose($inputFile);
$lines = explode("\n", $read);

// part1($lines);
part2($lines);

function part1($lines) {
    $freq = 0;
    foreach ($lines as $line) {
        $value = intval($line);
        $freq += $value;
    }
    
    echo "Final freq is $freq";
}

function part2($lines) {
    $seenFreqs = array();
    $freq = 0;

    while (true) {
        foreach ($lines as $line) {
            $value = intval($line);
            $freq += $value;
            
            if (array_key_exists($freq, $seenFreqs)) {
                echo "First freq seen twice is $freq";
                return;
            } else {
                $seenFreqs[$freq] = 1;
            }
        }
    }
}

?>