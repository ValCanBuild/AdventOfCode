<?php

$input = file_get_contents("input.txt");
$lines = explode("\n", $input);

class OrbitalObject
{
    public $name;
    public $orbitObj;

    public function __construct($name)
    {
        $this->name = $name;
    }

    public function totalOrbits()
    {
        if ($this->orbitObj != null) {
            return 1 + $this->orbitObj->totalOrbits();
        } else {
            return 0;
        }
    }

    public function orbitChain() {
        $orbits = array();
        $obj = $this->orbitObj;

        while ($obj != null) {
            $orbits[] = $obj;
            $obj = $obj->orbitObj;
        }

        return $orbits;
    }
}

$orbitalObjects = array();

foreach ($lines as $line) {
    $parts = explode(")", $line);
    $objAName = $parts[0];
    $objBName = $parts[1];

    if (!array_key_exists($objAName, $orbitalObjects)) {
        $orbitalObjects[$objAName] = new OrbitalObject($objAName);
    }
    if (!array_key_exists($objBName, $orbitalObjects)) {
        $orbitalObjects[$objBName] = new OrbitalObject($objBName);
    }

    $orbitalObjects[$objBName]->orbitObj = $orbitalObjects[$objAName];
}

part1($orbitalObjects);
echo "\n\n";
part2($orbitalObjects);

function part1($orbitalObjects)
{
    $totalOrbits = 0;
    foreach ($orbitalObjects as $orbitObj) {
        $totalOrbits += $orbitObj->totalOrbits();
    }

    echo "Total orbits is $totalOrbits";
}


function part2($orbitalObjects)
{
    $you = $orbitalObjects["YOU"];
    $san = $orbitalObjects["SAN"];

    $youChain = $you->orbitChain();
    $sanChain = $san->orbitChain();

    $rootOrbitObj = null;
    $numTransfers = 0;
    foreach ($youChain as $youOrbitObj) {
        if (in_array($youOrbitObj, $sanChain)) {
            $rootOrbitObj = $youOrbitObj;
            break;
        }
        $numTransfers++;
    }

    foreach ($sanChain as $sanOrbitObj) {
        if ($sanOrbitObj == $rootOrbitObj) {
            break;
        }
        $numTransfers++;
    }

    echo "Total orbit transfers is $numTransfers";
}
