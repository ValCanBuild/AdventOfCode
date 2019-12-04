<?php

// part1(284639, 748759);
// echo "\n";
part2(284639, 748759);

function part1($bottomValue, $topValue) {
    
    $matchingValues = array();

    for ($value = $bottomValue; $value < $topValue; $value++) {
        $stringArr = str_split((string) $value);
        $values = array_map(function($char) {
            return intval($char);
        }, $stringArr);

        $matches = false;
        
        foreach ($values as $index=>$val) {
            if ($index < sizeof($values) - 1) {
                if ($val > $values[$index+1]) {
                    $matches = false;
                    break;
                }

                if ($val == $values[$index+1]) {
                    $matches = true;
                }
            }
        }

        if ($matches) {
            $matchingValues[] = $value;
        }
    }

    $numValues = sizeof($matchingValues);
    echo "Num matching values are $numValues";
}

function part2($bottomValue, $topValue) {
    
    $matchingValues = array();

    for ($value = $bottomValue; $value < $topValue; $value++) {
        $stringArr = str_split((string) $value);
        $values = array_map(function($char) {
            return intval($char);
        }, $stringArr);

        $matches = true;
        $hasTwoMatches = false;
        $hasThreeOrMoreMatches = false;
        
        foreach ($values as $index=>$val) {
            if ($index < sizeof($values) - 1) {
                if ($val > $values[$index+1]) {
                    $matches = false;
                    break;
                }
                
                if ($val == $values[$index+1]) {
                    $twoMatching = true;
                 
                    if ($twoMatching && $index < sizeof($values) - 2) {
                        $twoMatching = $val != $values[$index+2];
                        if (!$twoMatching) {
                            $hasThreeOrMoreMatches = true;
                        }
                    }

                    if ($twoMatching && !$hasTwoMatches) {
                        $hasTwoMatches = $twoMatching;
                    }
                }
            }
        }

        if (!$matches) {
            continue;
        }

        if ($hasTwoMatches) {
            $matchingValues[] = $value;
        }
    }

    $numValues = sizeof($matchingValues);
    echo "Part 2 num matching values are $numValues";
}