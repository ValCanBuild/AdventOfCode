<?php

class Point {
    public $x;
    public $y;

    public function __construct($x, $y) {
        $this->x = $x;
        $this->y = $y;
    }
    
    public function __toString()
    {
        return "x:$this->x y:$this->y";
    }

    public function distance($fromPoint) {
        return abs($this->x - $fromPoint->x) + abs($this->y - $fromPoint->y);
    }
}

$input = file_get_contents("input.txt");
$lines = explode("\n", $input);

part1($lines);
echo "\n";
part2($lines);

function part1($lines) {
    $crossPointsClosestDistance = PHP_INT_MAX;

    $centerPoint = new Point(0, 0);

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

            $grid[(string) $wireAPos] = 1;
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

            if (key_exists((string) $wireBPos, $grid)) {
                $crossPointsClosestDistance = min($crossPointsClosestDistance, $wireBPos->distance($centerPoint));
            }
        }
    }

    echo "Closest cross distance is $crossPointsClosestDistance";
}

function part2($lines) {
    $fewestIntersectionSteps = PHP_INT_MAX;
    $wireAStepCountGrid = array();

    $wireADirs = explode(",", $lines[0]);
    $wireAPos = new Point(0, 0);
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

            if (!key_exists((string) $wireAPos, $wireAStepCountGrid)) {
                $wireAStepCountGrid[(string) $wireAPos] = $wireAStepCount;
            }
        }
    }

    $wireBDirs = explode(",", $lines[1]);
    $wireBPos = new Point(0, 0);
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

            if (key_exists((string) $wireBPos, $wireAStepCountGrid)) {
                $stepCount = $wireAStepCountGrid[(string) $wireBPos] + $wireBStepCount;
                $fewestIntersectionSteps = min($fewestIntersectionSteps, $stepCount);
            }
        }
    }

    echo "Fewest combined steps is $fewestIntersectionSteps";
}