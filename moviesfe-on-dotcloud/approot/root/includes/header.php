<?php
// gets the page file name, this later is called to place the featured posts on the home page only
$currentFile = $_SERVER["PHP_SELF"];
$parts = Explode('/', $currentFile);
($page_file_name = ($parts[count($parts) - 1]));
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US" xml:lang="en-US">
	<head>
	
		<title>Reviewer HTML Template</title>
		<meta name="Keywords" content=" " />
		<meta name="Description" content=" " />
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	
		<!-- Google Fonts Call -->
		<link href="http://fonts.googleapis.com/css?family=Brawler" rel="stylesheet" type="text/css" />
    
    	<!-- Get the Stylesheet -->
		<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
    
    	<!-- Get the JS -->
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/reviewer.js"></script>
    
		<!-- The Favicon -->
		<link rel="shortcut icon" href="images/favicon.png" />
		
	</head>
	<body class="sidebar_right">
		<div id="wrapper">
			<div id="header">
				<div id="pagemenu" class="menu">
					<div class="container">
						<div class="menu-pages-container">
							<ul id="menu-pages" class="menu">
								<li><a href="page.php" title="About">About</a></li>
								<li>
									<a href="#" title="Drop Down">Drop Down +</a>
									<ul class="sub-menu">
										<li><a href="#" title="Item 1">Item 1</a></li>
										<li>
											<a href="#" title="Item 2">Item 2 +</a>
											<ul class="sub-menu">
												<li><a href="#" title="Item 2 Child">Item 2 Child</a></li>
											</ul>
										</li>
									</ul>
								</li>
								<li><a href="page.php" title="Kitchen Sink">Kitchen Sink</a></li>
								<li><a href="page-full.php" title="Full Width">Full Width</a></li>
								<li><a href="page-authors.php" title="Authors Page">Authors Page</a></li>
								<li><a href="page-contact.php" title="Contact Us">Contact Us</a></li>
							</ul>
						</div>
						<div id="socnets">
							<a href="#" title="Twitter"><img src="images/socnets/twitter.png" alt="Twitter" /></a>
							<a href="#" title="Facebook"><img src="images/socnets/facebook.png" alt="Facebook" /></a>
							<a href="#" title="Flickr"><img src="images/socnets/flickr.png" alt="Flickr" /></a>
							<a href="#" title="Forrst"><img src="images/socnets/forrst.png" alt="Forrst" /></a>
							<a href="#" title="Dribbble"><img src="images/socnets/dribbble.png" alt="Dribbble" /></a>
							<a href="#" title="Tumblr"><img src="images/socnets/tumblr.png" alt="Tumblr" /></a>
							<a href="#" title="Vimeo"><img src="images/socnets/vimeo.png" alt="Vimeo" /></a>
							<div class="clear"></div>
						</div>
						<div class="clear"></div>
					</div>
				</div>
				<div id="logo_area">
					<div class="container">
						<a href="index.php" title="Reviewer" class="left"><img src="images/logo.png" alt="Reviewer" id="logo" /></a>
						<div id="header_widget">
							<div><img src="images/ad.png" alt="Advertise Here" /></div>
						</div>
						<div class="clear"></div>
					</div>
				</div>
				<div class="menu" id="category_menu">
					<div class="container">
						<div class="menu-categories-container">
							<ul id="menu-categories" class="menu">
								<li><a href="archive.php" title="Archive">Reviews</a></li>
								<li><a href="archive.php" title="Archive">Blog</a></li>
								<li><a href="archive.php" title="Archive">Giveaways</a></li>
								<li>
									<a href="#">Genres Drop Down +</a>
									<ul class="sub-menu">
										<li><a href="archive.php" title="Archive">Adventure</a></li>
										<li><a href="archive.php" title="Archive">Comedy</a></li>
										<li><a href="archive.php" title="Archive">Drama</a></li>
										<li>
											<a href="archive.php" title="Archive">Action +</a>
											<ul class="sub-menu">
												<li><a href="archive.php" title="Archive">Comic Books</a></li>
											</ul>
										</li>
										<li><a href="archive.php" title="Archive">Sci-Fi</a></li>
									</ul>
								</li>
							</ul>
						</div>
						<form method="get" id="searchform" action="">
							<div>
								<input type="text" class="search_input" value="To search, type and hit enter" name="s" id="s" onfocus="if (this.value == 'To search, type and hit enter') {this.value = '';}" onblur="if (this.value == '') {this.value = 'To search, type and hit enter';}" />
								<input type="hidden" id="searchsubmit" value="Search" />
							</div>
						</form>
						<div class="clear"></div>
					</div>
				</div>
				<?php if ($page_file_name == "index.php") { ?>
				<div id="header_banner" class="featured_banner_dark">
					<div class="container">
						<div class="featured_post left">
							<div class="featured_poster_overflow">
								<div class="featured_poster_wrap">
									<a href="single.php" title="Harry Potter Contest">
										<img width="258" height="384" src="images/demo_poster_lg.jpg" class="featured_poster wp-post-image" alt="Harry Potter Contest" />
									</a>
								</div>
							</div>
							<div class="contest"></div>
							<div class="featured_title">
								<a href="single.php" title="Harry Potter Contest">Harry Potter Contest</a>
							</div>
						</div>
						<div class="featured_post left">
							<div class="featured_poster_overflow">
								<div class="featured_poster_wrap">
									<a href="single.php" title="Everything Must Go">
										<img width="258" height="382" src="images/demo_poster_lg.jpg" class="featured_poster wp-post-image" alt="Everything Must Go" />
									</a>
								</div>
							</div>
							<div class="rating">
								<div class="stars_45"></div>
							</div>
							<div class="featured_title">
								<a href="single.php" title="Everything Must Go">Everything Must Go</a>
							</div>
						</div>
						<div class="featured_post left featured_post_last">
							<div class="featured_poster_overflow">
								<div class="featured_poster_wrap">
									<a href="single.php" title="Captain America: The First Avenger">
										<img width="258" height="384" src="images/demo_poster_lg.jpg" class="featured_poster wp-post-image" alt="Captain America: The First Avenger" />
									</a>
								</div>
							</div>
							<div class="rating">
								<div class="stars_5"></div>
							</div>
							<div class="featured_title">
								<a href="single.php" title="Captain America: The First Avenger">Captain America: The First Avenger</a>
							</div>
						</div>
						<div class="clear"></div>
					</div>
				</div>
				<?php } ?>
			</div><!-- end #header -->