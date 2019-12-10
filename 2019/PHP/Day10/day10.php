<?php

$input = file_get_contents("input.txt");
$lines = explode("\n", $input);

$asteroidLocations = array();

$mapWidth = strlen($lines[0]);
$mapHeight = sizeof($lines);

for ($y = 0; $y < $mapHeight; $y++) {

    for ($x = 0; $x < $mapWidth; $x++) {
        $hasAsteroid = $lines[$y][$x] == "#";
        if ($hasAsteroid) {
            $asteroidLocations[] = new Point($x, $y);
        }
    }
}

$stationLoc = part1($asteroidLocations);
echo "\n\n";
part2($asteroidLocations, $stationLoc);

class Point
{
    public $x;
    public $y;

    function __construct($x, $y)
    {
        $this->x = $x;
        $this->y = $y;
    }
}

function part1($asteroidLocations)
{
    $maxSeenAsteroids = 0;
    $preferredAsteroidLoc = null;

    // for each asteroid
    // detect which asteroids it CANNOT see
    // subtract that from the number of total asteroids and that equals the amount it can see
    foreach ($asteroidLocations as $location) {
        $seenAsteroids = 0;
        $seenTangents = array();
        foreach ($asteroidLocations as $otherLocation) {
            if ($location == $otherLocation) {
                continue;
            }

            $distanceX = ($otherLocation->x - $location->x);
            $distanceY = ($otherLocation->y - $location->y);

            $arcTan = atan2($distanceY, $distanceX);
            if ($arcTan < 0) {
                $arcTan += M_PI * 2;
            }
            if (!in_array($arcTan, $seenTangents)) {
                $seenTangents[] = $arcTan;
                $seenAsteroids++;
            }
        }

        if ($seenAsteroids > $maxSeenAsteroids) {
            $maxSeenAsteroids = $seenAsteroids;
            $preferredAsteroidLoc = $location;
        }
    }

    echo "Max seen asteroids is $maxSeenAsteroids at location $preferredAsteroidLoc->x,$preferredAsteroidLoc->y";

    return $preferredAsteroidLoc;
}

function part2($asteroidLocations, $stationLoc)
{
    $asteroidsInTangents = array();
    foreach ($asteroidLocations as $location) {
        if ($location == $stationLoc) {
            continue;
        }

        $distanceX = ($location->x - $stationLoc->x);
        $distanceY = ($location->y - $stationLoc->y);

        $arcTan = atan2($distanceY, $distanceX);
        if ($arcTan < 0) {
            $arcTan += M_PI * 2;
        }
        $key = (string)$arcTan;
        if (!array_key_exists($key, $asteroidsInTangents)) {
            $asteroidsInTangents[$key] = array();
        }

        $asteroidsInTangents[$key][] = $location;

        usort($asteroidsInTangents[$key], function($pointA, $pointB) use ($stationLoc) {
            $distA = abs($pointA->x - $stationLoc->x) + abs($pointA->y - $stationLoc->y);
            $distB = abs($pointB->x - $stationLoc->x) + abs($pointB->y - $stationLoc->y);

            return $distA - $distB;
        });
    }

    $allTangents = array_keys($asteroidsInTangents);
    usort($allTangents, function($a, $b) {
        if ((float)$a - (float)$b < 0) {
            return -1;
        } else if ((float)$a - (float)$b > 0) {
            return 1;
        }
        return ;
    });

    $numVaporised = 0;

    while (true) {
        $nothingPopped = true;
        foreach ($allTangents as $tangent) {
            $key = (string)$tangent;
            if (sizeof($asteroidsInTangents[$key]) > 0) {
                $nothingPopped = false;

                $asteroidLoc = array_pop($asteroidsInTangents[$key]);
                $numVaporised++;

                echo "Asteroid $numVaporised is at location $asteroidLoc->x, $asteroidLoc->y\n";

                if ($numVaporised == 200) {
                    echo "Asteroid 200 is at location $asteroidLoc->x, $asteroidLoc->y\n";
                    // $answer = $asteroidLoc->x*100 + $asteroidLoc->y;
                    // echo "Answer is $answer";
                    // return;
                }
            }
        }

        if ($nothingPopped) {
            break;
        }
    }
}
