<?php
header('Content-Type: text/json');
header('Access-Control-Allow-Origin: *');

$path = __DIR__ . '/../lists';
$d = new DirectoryIterator($path);
$overallData = [];
$id = 0;
foreach (new RegexIterator($d, '/\.json$/') as $item) {
    $account = preg_replace('/^(.+)\.json$/', '$1', $item);
    $currentData = json_decode(file_get_contents($path . '/' . $item), true);
    foreach ($currentData as $entry) {
        $entry['id'] = $id++;
        $entry['account'] = $account;
        $overallData[] = $entry;
    }
}

echo json_encode($overallData);
