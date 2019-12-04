<?php

part1(284639, 748759);
echo "\n";
part2(284639, 748759);

function part1($bottomValue, $topValue) {
    
    $matchingValues = array();

    for ($value = $bottomValue; $value < $topValue; $value++) {
        $stringArr = str_split((string) $value);
        $sortedArr = $stringArr; 
        sort($sortedArr);

        if ($stringArr != $sortedArr) {
            continue;
        }

        $counted = array_count_values($stringArr);
        foreach ($counted as $val=>$occurrences) {
            if ($occurrences > 1) {
                $matchingValues[] = $value;
                break;
            }
        }
    }

    $numValues = sizeof($matchingValues);
    echo "Part 1 num matching values are $numValues";
}

function part2($bottomValue, $topValue) {
    
    $matchingValues = array();

    for ($value = $bottomValue; $value < $topValue; $value++) {
        $stringArr = str_split((string) $value);
        $sortedArr = $stringArr; 
        sort($sortedArr);

        if ($stringArr != $sortedArr) {
            continue;
        }

        $counted = array_count_values($stringArr);
        foreach ($counted as $val=>$occurrences) {
            if ($occurrences == 2) {
                $matchingValues[] = $value;
                break;
            }
        }
    }

    $numValues = sizeof($matchingValues);
    echo "Part 2 num matching values are $numValues";
}