<?php
defined('ABSPATH') or die("No script kiddies please!");

/**
 * Plugin Name: CCeH Page Generator
 * Author: CCeH NG
 * Description: This plugin automatically generates pages out of a XML list and fills them with a XSLT processor processable expression. <br/><strong><a href="http://capitularia.uni-koeln.de/?cms=Manus" target="_blank"> +++ Pages generieren (aus Verzeichnis: cap/publ/mss) +++</a></strong>
 * Version: 0.3a
 */

//
// ACHTUNG: BAUSTELLE!
// ??? Unabhängigkeit von "Manuscript-Schema"?! => "allgemeingültiger" ODER unterschiedliche functions für die möglichen Schemata?!
// ??? Anpassung der Pfade
// ??? variablen Namen für Datei mit Liste?! => Parameter für function/gesamtes Plugin?!
//

// Hook an wp_head
add_action('wp_head', 'startGenerator');

// wird dank Hook immer mit wp_head zusammen ausgeführt
function startGenerator()
{
	//wenn in der URL ?cms=go steht => Skript zur automatischen Generierung von Posts aus Liste ausführen
	if($_GET['cms'] == 'Manus')
	{
		// den eigentlichen Algorithmus aufrufen
		generatePages();	
	}
}

function wp_exist_page_by_title($title_str) {
	$allPages = get_pages();

	//alle Titel auf Übereinstimmung prüfen
	foreach($allPages as $page) {
		if($title_str==$page->post_title) {
			return True; //Page mit gleichem Titel gefunden >>> Rückgabewert = True
		}
	}

	return False; //Schleife ohne Treffer durchlaufen => keine Page mit gleichem Titel
}

function wp_exist_post_by_title($title_str) {
	global $wpdb;
	return $wpdb->get_row("SELECT * FROM wp_posts WHERE post_title = '" . $title_str . "'", 'ARRAY_A');
}

function annoyingJavaPopup($popupMsg) {
	echo "<script type='text/javascript'>alert('" . $popupMsg . "');</script>";
}
function aJP($msg) {
	annoyingJavaPopup($msg);
}

function pruefeValiditaet($xmlDatei, $schema) {
	//siehe: http://php.net/manual/en/domdocument.schemavalidate.php

	/**
	* Vorgehen:
	* 1. $xmlDatei als DOM-XML laden
	* 2. versuchen, $xmlDatei-Objekt mit Schema zu validieren +++ mögliche Fehler ausgeben
	* 3. Rückgabe TRUE/FALSE?!
	*/

	libxml_use_internal_errors(true); //XML-Fehlermeldungen ermöglichen

	//---TESTWEISE---
/*	if(!file_exists($xmlDatei) OR !file_exists($schema)) {
		return False;
	}*/
	if(!file_exists($xmlDatei)) {
		aJP("xmlDatei nicht gefunden!");
		return False;
	}
	if(!file_exists($schema)) {
		aJP("schema nicht gefunden!");
		return False;
	}
	//---TESTWEISE---

	// aJP("Erstelle neues DOM-Objekt...");
	$domDoc = new DOMDocument();

	// aJP("Lade XML-Datei...");
	$domDoc->load($xmlDatei);

	$domDoc->xinclude();

  	$blnErg = $domDoc->schemaValidate($schema);

	//falls Fehler auftreten, Fehlermeldungen nacheinander einzeln ausgeben
	if($blnErg) {
		//aJP('valide');
	} else {
		//aJP('nicht valide');

	    $errors = libxml_get_errors();

	    foreach ($errors as $error) {
	        aJP($xmlDatei . '\\n' . '\\n' . 'Message: ' . trim($error->message) . '\\n' . 'Level: ' . $error->level . '\\n' . 'Code: ' . $error->code . '\\n' .  'File: ' . $error->file . '\\n' . 'Line: ' . $error->line . '\\n' . 'Column: ' . $error->column);
	    }
	    libxml_clear_errors();
	}

	libxml_use_internal_errors(false);

	return $blnErg;
}

// erstellt Pages  anhand der in der Liste angegebenen Dateien
// ACHTUNG: Variablen mit Dateinamen & Pfaden müssen gegebenenfalls angepasst werden!
// BAUSTELLE: Variablen global setzen?! >>> Vorteil: können am Anfang des Skripts definiert werden >>> Nachteil: mögliche Konflikte mit anderen globalen Variablen außerhalb dieses Skripts?!?
function generatePages() {
	//ACHTUNG: Pfad/Namen anpassen!
	$nameListe = 'list_wp-pages_mss_TEST.xml'; //Datei mit Liste

	//ACHTUNG: Pfad/Namen anpassen!
	$pfadXML = 'cap/publ/mss';


	//ACHTUNG: Pfad/Namen anpassen!
	$pfadXSL = 'cap/publ/transform';


	//ACHTUNG: Pfad/Namen anpassen!
	$transformationName = 'transkription.xsl';
	$transformationNameHeader = 'msDesc_cap.xsl';
	$transformationNameFooter = ''; //BAUSTELLE => Namen einfügen, sobald Footer-Skript erstellt wurde!

	//ACHTUNG: Pfad/Namen anpassen!
	$schemaDatei = 'cap/publ/schemata/schema_TEST.xsd';

	//$dir_wp_content = dirname(dirname(__FILE__)); //Pfad zu Verzeichnis wp_content

	$pfadListe = $pfadXML . "/" . $nameListe;

	$arrTitelNeuerPosts = array(); //Liste neuer Posts
	$arrTitelExistiertBereits = array(); //Liste bereits existierender Titel/Posts
	$arrNichtGefunden = array(); //Liste nicht gefundener Manuskripte
	$arrNichtValide = array(); //Liste nicht valider XML-Dateien

	// prüfen, ob Datei mit Liste existiert
	if(file_exists($pfadListe)) {

		//XML aus Liste in Variable laden
		$liste = simplexml_load_file($pfadListe);
		
		//alle mss-Elemente aus Liste durchlaufen
		foreach ($liste->mss as $manuscript)
		{
			// Dateipfad für die Manuskriptdatei
			$manuscriptDatei = $pfadXML . '/' . $manuscript->filename;
			//$manuscriptDatei = realpath($manuscriptDatei);

			//Dateipfad für die Transformationsdatei
			$transformationDatei = $pfadXSL . '/' . 'transkription.xsl';
			//$transformationDatei = realpath($transformationDatei);

			// Post wird nur erstellt, wenn die Datei tatsächlich existiert!
			if(file_exists($manuscriptDatei))
			{
				
				//Validität der Datei prüfen...
				$dateiValide = True;
				if(!pruefeValiditaet($manuscriptDatei, $schemaDatei)) {
					//aJP("ACHTUNG: " . $manuscript->filename . " ist nicht valide!");
					array_push($arrNichtValide, $manuscript->filename);
					$dateiValide = False;
				}
				

				// Array für Post erstellen >>> 

				//post_title: benötigt addslashes(), um für insert-Funktion verarbeitbar zu sein!

				//post_status: pending/private vs publish?!
				//$post_status = 'pending';
				$post_status = 'publish';
				//$post_status = 'private';

				//post_author: derzeit "6" (=ich) => vllt zusätzlichen Author-Account für automatisch generierte Posts erstellen/einrichten/anlegen?
				$post_author = 6;

				//post_content: Sollte nur Anweisung für XSLT Processor enthalten?!
				//Beispiel/"Vorbild": [XmlProcessor xml="wp-content/uploads/register/Bibliographie_Capitularia.xml" xslt="wp-content/uploads/trans/biblioTrans_parameter.xsl"]
				if(!$dateiValide) {
					$post_content = '<i><b>ACHTUNG: DATEI NICHT VALIDE!</b></i>' . '<hr/>' . '[XmlProcessor xml="' . $pfadXML . '/' . $manuscript->filename . '" xslt="' . $pfadXSL . '/' . $transformationName . '"]';
				} else {
					$post_content = 
								'[XmlProcessor xml="' . $pfadXML . '/' . $manuscript->filename . '" xslt="' . $pfadXSL . '/' . $transformationNameHeader . '"]' . '<br/>' .
								'[XmlProcessor xml="' . $pfadXML . '/' . $manuscript->filename . '" xslt="' . $pfadXSL . '/' . $transformationName . '"]' . '<br/>' .
								'[XmlProcessor xml="' . $pfadXML . '/' . $manuscript->filename . '" xslt="' . $pfadXSL . '/' . $transformationNameFooter . '"]';
				}
				//$post_content = '[XmlProcessor xml="' . $pfadXML . '/' . $manuscript->filename . '" xslt="' . $pfadXSL . '/' . $transformationName . '"]';

				//'tags_input'     => [ '<tag>, <tag>, ...' | array ] // Default empty.
				$tags_input = array('xml');

				//'post_date'      => [ Y-m-d H:i:s ] // The time post was made. => wird aber auch schon standardmäßig befüllt, sofern post_status=='publish'
				$current_time = current_time('Y-m-d H:i:s');

				//'post_type'      => [ 'post' | 'page' | 'link' | 'nav_menu_item' | custom post type ] // Default 'post'.
				//$post_type = 'page';
				$post_type = 'page';
				
				$post_name = $manuscript->slug;

				//Daten aus Listeneintrag
				$newPost= array(
					'post_title' => addslashes($manuscript->title),
					'post_name' => $post_name,
					'post_status' => $post_status,
					'post_author' => $post_author,
					'post_content' => $post_content,
					'post_date' => $current_time,
					'post_type' => $post_type,
					'tags_input' => $tags_input,

				);

				// prüfen, ob Page bereits existiert => Duplikate verhindern
				if(!wp_exist_page_by_title($manuscript->title))
					{
						//aJP("Erstelle Post: " . $manuscript->title);

						// Post in Datenbank einfügen
						$result = wp_insert_post($newPost, True);

						//auf Fehler beim Einfügen prüfen
						if(is_wp_error($result)) {
							$fehlermeldung = $result->get_error_message();

							//Fehlermeldung ausgeben
							aJP($fehlermeldung);
						} else {
							//hinzugefügten Titel merken >>> Liste wird später ausgegeben
							array_push($arrTitelNeuerPosts, $manuscript->title);
						}

					} else {
						//bereits existierenden Titel merken >>> Liste wird später ausgegeben
						array_push($arrTitelExistiertBereits, $manuscript->title);
					}
			} else {
				//nicht gefundene Datei/Manuskript merken >>> Liste wird später ausgegeben
				array_push($arrNichtGefunden, $manuscript->filename);
			}
		}

		//Feedback für Nutzer >>> Ausgabe der einzelnen Listen zu generierten Pages, bereits existierenden Titeln/Pages, nicht gefundenen Manuskriptdateien
		if(count($arrTitelNeuerPosts)>0) {
			$feedbackMeldung = "Es wurde(n) " . count($arrTitelNeuerPosts) . " Page(s) generiert:" . "\\n" . implode("\\n",$arrTitelNeuerPosts);			
		} else {
			$feedbackMeldung = "Es konnten keine neuen Pages generiert werden.";
		}
		if(count($arrNichtValide)>0) {
			$feedbackMeldung .= "\\n" . "\\n" . "ACHTUNG! Folgende Dateien sind nicht valide:" . "\\n" . implode("\\n",$arrNichtValide);
		}
		if(count($arrTitelExistiertBereits)>0) {
			$feedbackMeldung .= "\\n" . "\\n" . "Folgende Titel existieren bereits:" . "\\n" . implode("\\n",$arrTitelExistiertBereits);
		}
		if(count($arrNichtGefunden)>0) {
			$feedbackMeldung .= "\\n" . "\\n" . "Folgende Manuskripte konnten nicht gefunden werden:" . "\\n" . implode("\\n",$arrNichtGefunden);
		}
		aJP($feedbackMeldung); //Feedback-Meldung ausgeben

	} else {
		aJP("Liste (" . $pfadListe . ") nicht gefunden!");
	}
}
?>