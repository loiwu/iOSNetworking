<?php
	$postContent = @file_get_contents('php://input');
	$parseMethod = $_REQUEST['parseMethod'];
	
	// no data received, fail gracefully
	if (empty($postContent)) {
		$response = array(
			"articleCount" => 0
		);
		
		echo json_encode($response);
		return;
	}
	
	// JSON
	if ($parseMethod == 0) {
		$payload = json_decode($postContent);
		
		$articleCount = 0;
		foreach ($payload->articles as $article) {
			$articleCount ++;
		}
		
		$response = array(
			"articleCount" => $articleCount
		);
		
		echo json_encode($response);
		
	// XML
	} else {
		$payload = new DOMDocument();
		$payload->loadXML($postContent);
		$articles = $payload->getElementsByTagName("article");
		
		$articleCount = 0;
		
		foreach ($articles as $article) {
			$articleCount ++;			
		}
		
		$response = array(
			"articleCount" => $articleCount
		);
		
		echo json_encode($response);		
		
	}

?>