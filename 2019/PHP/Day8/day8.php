<?php

$input = file_get_contents("input.txt");

part1($input);
echo "\n\n";
part2($input);

function part1($input)
{
    $imgWidth = 25;
    $imgHeight = 6;

    $length = strlen($input);
    $layerSize = $imgWidth * $imgHeight;
    $numLayers = $length / $layerSize;

    $layers = array();
    $targetLayerIndex = -1;
    $fewestZeroes = PHP_INT_MAX;

    for ($i = 0; $i < $numLayers; $i++) {
        $start = $i * $layerSize;
        $layer = substr($input, $start, $layerSize);
        $layers[] = $layer;

        $zeroCount = substr_count($layer, "0");
        if ($zeroCount < $fewestZeroes) {
            $fewestZeroes = $zeroCount;
            $targetLayerIndex = $i;
        }
    }

    $targetLayer = $layers[$targetLayerIndex];
    $oneCount = substr_count($targetLayer, "1");
    $twoCount = substr_count($targetLayer, "2");

    $number = $oneCount * $twoCount;

    echo "Part 1 result is $number";
}

function part2($input)
{
    echo "Part 2\n\n";

    $imgWidth = 25;
    $imgHeight = 6;
    $transparent = 2;
    $white = 1;
    $black = 0;

    $length = strlen($input);
    $layerSize = $imgWidth * $imgHeight;
    $numLayers = $length / $layerSize;

    $layers = array();

    for ($i = 0; $i < $numLayers; $i++) {
        $start = $i * $layerSize;
        $layers[] = substr($input, $start, $layerSize);
    }

    for ($height = 0; $height < $imgHeight; $height++) {
        for ($width = 0; $width < $imgWidth; $width++) {
            $offset = ($height * $imgWidth) + $width;
            $pixel = $transparent;
            for ($i = 0; $i < $numLayers; $i++) {
                $pixelValue = $layers[$i][$offset];
                if ($pixelValue != $transparent) {
                    $pixel = $pixelValue;
                    break;
                }
            }
            if ($pixel == $transparent || $pixel == $black) {
                echo "  ";
            } else {
                echo "##";
            }
        }
        echo "\n";
    }
}
