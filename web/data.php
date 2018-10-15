<?php

$path = __DIR__ . '/../lists';
$d = new DirectoryIterator($path);
$overallData = [];
foreach (new RegexIterator($d, '/\.json$/') as $item) {
    $account = preg_replace('/^(.+)\.json$/', '$1', $item);
    $currentData = json_decode(file_get_contents($path . '/' . $item), true);
    foreach ($currentData as $entry) {
        $entry['account'] = $account;
        $overallData[] = $entry;
    }
}

print_r($overallData);