<?php

$file = $_SERVER['argv'][1];
$d = new DOMDocument();
$d->loadHTMLFile($file);
$x = new DOMXpath($d);
$nodeList = $x->evaluate('.//*[@id="tab-content"]/table/tbody/tr');

$data = [];
foreach ($nodeList as $key => $node) {
    if ($key === 0) {
        continue;
    }

    $tds = $x->evaluate('.//td', $node);
    $titleAndLocationNode = $tds[0];
    $titleAndLocationText = $d->saveXML($titleAndLocationNode);
    $time = $tds[1];
    if (!$time) {
        break;
    }
    $timeText = $d->saveXML($time);

    $title = $x->evaluate('.//strong', $titleAndLocationNode)[0]->textContent;

    $lines = splitOnLineBreaks($titleAndLocationText);
    $author = $lines[1];

    $timeLines = array_map(
        function ($line) {
            return trim($line);
        },
        explode("\n", $time->textContent)
    );
    $timeRange = $timeLines[2];
    $location = $timeLines[3];

    $data[] = [
        'title' => $title,
        'author' => $author,
        'date' => $timeRange,
        'location' => $location,
        'account' => '?'
    ];
}

echo json_encode($data);

function splitOnLineBreaks($htmlString): array
{
    return preg_split('#\n*\s*<\s*br\s*//?>\s*\n?#', $htmlString);
}