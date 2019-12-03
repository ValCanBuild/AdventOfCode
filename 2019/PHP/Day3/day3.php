<?php

ini_set('memory_limit', '-1');

class Point {
    public $x;
    public $y;

    public function __construct($x, $y) {
        $this->x = $x;
        $this->y = $y;
    }

    public function distance($fromPoint) {
        return abs($this->x - $fromPoint->x) + abs($this->y - $fromPoint->y);
    }
}

$input = file_get_contents("input.txt");
$lines = explode("\n", $input);

// part1($lines);
part2($lines);

function part1($lines) {
    $gridSize = 50000;
    $grid = array_fill(0, $gridSize, array_fill(0, $gridSize, 0));
    $crossPointsClosestDistance = PHP_INT_MAX;

    $centerPoint = new Point($gridSize/2, $gridSize/2);

    $wireADirs = explode(",", $lines[0]);
    $wireAPos = new Point($centerPoint->x, $centerPoint->y);

    foreach ($wireADirs as $wireDir) {
        $dir = $wireDir[0];
        $moves = substr($wireDir, 1, strlen($wireDir));
        $numMoves = intval($moves);

        for ($move = 0; $move < $numMoves; $move++) {

            switch ($dir) {
                case 'L':
                    $wireAPos->x -= 1;
                break;
                case 'R':
                    $wireAPos->x += 1;
                break;
                case 'U':
                    $wireAPos->y -= 1;
                break;
                case 'D':
                    $wireAPos->y += 1;
                break;
            }

            $grid[$wireAPos->x][$wireAPos->y] = 1;
        }
    }

    $wireBDirs = explode(",", $lines[1]);
    $wireBPos = new Point($centerPoint->x, $centerPoint->y);

    foreach ($wireBDirs as $wireDir) {
        $dir = $wireDir[0];
        $moves = substr($wireDir, 1, strlen($wireDir));
        $numMoves = intval($moves);

        for ($move = 0; $move < $numMoves; $move++) {

            switch ($dir) {
                case 'L':
                    $wireBPos->x -= 1;
                break;
                case 'R':
                    $wireBPos->x += 1;
                break;
                case 'U':
                    $wireBPos->y -= 1;
                break;
                case 'D':
                    $wireBPos->y += 1;
                break;
            }

            if ($grid[$wireBPos->x][$wireBPos->y] == 1) {
                $crossPointsClosestDistance = min($crossPointsClosestDistance, $wireBPos->distance($centerPoint));
            }
        }
    }

    echo "Closest cross distance is $crossPointsClosestDistance";
}

function part2($lines) {
    $gridSize = 20000;
    $grid = array_fill(0, $gridSize, array_fill(0, $gridSize, 0));
    $wireAStepCountGrid = array_fill(0, $gridSize, array_fill(0, $gridSize, 0));
    $wireBStepCountGrid = array_fill(0, $gridSize, array_fill(0, $gridSize, 0));
    $fewestIntersectionSteps = PHP_INT_MAX;

    $centerPoint = new Point($gridSize/2, $gridSize/2);

    $wireADirs = explode(",", $lines[0]);
    $wireAPos = new Point($centerPoint->x, $centerPoint->y);
    $wireAStepCount = 0;

    foreach ($wireADirs as $wireDir) {
        $dir = $wireDir[0];
        $moves = substr($wireDir, 1, strlen($wireDir));
        $numMoves = intval($moves);

        for ($move = 0; $move < $numMoves; $move++) {

            switch ($dir) {
                case 'L':
                    $wireAPos->x -= 1;
                break;
                case 'R':
                    $wireAPos->x += 1;
                break;
                case 'U':
                    $wireAPos->y -= 1;
                break;
                case 'D':
                    $wireAPos->y += 1;
                break;
            }

            $wireAStepCount++;

            $grid[$wireAPos->x][$wireAPos->y] = 1;

            if ($wireAStepCountGrid[$wireAPos->x][$wireAPos->y] == 0) {
                $wireAStepCountGrid[$wireAPos->x][$wireAPos->y] = $wireAStepCount;
            }
        }
    }

    $wireBDirs = explode(",", $lines[1]);
    $wireBPos = new Point($centerPoint->x, $centerPoint->y);
    $wireBStepCount = 0;

    foreach ($wireBDirs as $wireDir) {
        $dir = $wireDir[0];
        $moves = substr($wireDir, 1, strlen($wireDir));
        $numMoves = intval($moves);

        for ($move = 0; $move < $numMoves; $move++) {

            switch ($dir) {
                case 'L':
                    $wireBPos->x -= 1;
                break;
                case 'R':
                    $wireBPos->x += 1;
                break;
                case 'U':
                    $wireBPos->y -= 1;
                break;
                case 'D':
                    $wireBPos->y += 1;
                break;
            }

            $wireBStepCount++;

            if ($wireBStepCountGrid[$wireBPos->x][$wireBPos->y] == 0) {
                $wireBStepCountGrid[$wireBPos->x][$wireBPos->y] = $wireBStepCount;
            }

            if ($grid[$wireBPos->x][$wireBPos->y] == 1) {
                $stepCount = $wireAStepCountGrid[$wireBPos->x][$wireBPos->y] + $wireBStepCountGrid[$wireBPos->x][$wireBPos->y];
                $fewestIntersectionSteps = min($fewestIntersectionSteps, $stepCount);
            }
        }
    }

    echo "Fewest combined steps is $fewestIntersectionSteps";
}