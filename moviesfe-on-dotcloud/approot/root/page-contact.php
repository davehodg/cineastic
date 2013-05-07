<?

	$success = false;
	if( isset($_REQUEST['cSubmit']) ) {
	
		$error = false;
		
		$cName = trim(htmlentities($_REQUEST['cName']));
		$cPhone = trim(htmlentities($_REQUEST['cPhone']));
		$cEmail = trim(htmlentities($_REQUEST['cEmail']));
		$cMessage = trim(htmlentities($_REQUEST['cMessage']));
		
		$mailBody = "<b>Name: </b>".$cName."<br>\n".
					"<b>Phone: </b>".$cPhone."<br>\n".
					"<b>Email: </b>".$cEmail."<br>\n".
					"<b>Message: </b>".$cMessage."<br>\n";
					
		if( empty($cName) ) {
			$error = true;
			$errorMsg .= "You Must Supply a First and Last Name. <br />";
		}
		
		if( empty($cEmail) ) {
			$error = true;
			$errorMsg .= "You Must Supply an Email Address <br />";
		}

		require_once( "class.phpmailer.php" );
		$mail = new PHPMailer();
		$mail->IsHTML(true);
		$mail->Subject = "WEBSITE NAME - Contact Form"; //--------------- You need to change the website name here
		$mail->AddAddress("NAME@WEBSITE.com"); //--------------- You need to change the email address here
		$mail->From = $cEmail;
		$mail->FromName = $cName;
		$mail->Body = $mailBody;

		if( !$error ) {
			if( $mail->Send() ) {
				$success = true;
				$successMsg = "Message Sent Successfully.  We will contact you shortly regarding your comments/questions.";
			} else {
				$error = true;
				$errorMsg = "Unable to Send Message. Please Try Again.";
			}
		}

	}


?>
<?php include('includes/header.php'); ?>
<!-- End Header -->

<div id="main_content_alt">
	<div class="container">
		<div class="posts-wrap">
			<div id="page">
				<h2 class="page-title">Contact Us</h2>
				<div class="entry-content" id="page-content">
					<? if( $error ) echo "<div class=\"warning\"><p>".$errorMsg."</p></div><div class=\"clear\"></div>";
					if( $success ) echo "<div class=\"alert\"><p>".$successMsg."</p></div><div class=\"clear\"></div>";				
					if( !$success ) { ?>
					
					<form method="post" action="page-contact.php" id="cForm" class="form"> <?php /* you must change the action page name if you change the filename of this page */ ?>
						<p>
							<label>Name*</label>
							<input name="cName" type="text" id="cName" size="35" value="<? echo $_POST['cName']; ?>" />
						</p>
						<p>
							<label>Phone</label>
							<input name="cPhone" type="text" id="cPhone" size="35" value="<? echo $_POST['cPhone']; ?>" />
						</p>
						<p>
							<label>Email*</label>
							<input name="cEmail" type="text" id="cEmail" size="35" value="<? echo $_POST['cEmail']; ?>" />
						</p>
						<p>
							<label>Message</label>
							<textarea name="cMessage" cols="30" rows="5" id="cMessage"><? echo $_POST['cMessage']; ?></textarea>
						</p>
						<p>
							<input type="submit" name="cSubmit" id="cSubmit" value="Submit" />
						</p>
						<p>*denotes required</p>
					</form>
					
					<? } ?>
					<div class="clear"></div>
				</div><!-- end #page-content -->
			</div>
		</div>

<!-- Begin Sidebar -->
<?php include('includes/sidebar.php'); ?>
<!-- End Sidebar -->

		<div class="clear"></div>
	</div><!-- end div.container -->
</div><!-- end div#main_content -->

<!-- Begin Footer -->
<?php include('includes/footer.php'); ?>
<!-- End Footer -->