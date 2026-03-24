<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
</head>

<body>
    <h2>Reset Password</h2>
    <h3>Using PHPMailer (Recommended Method)</h3>
    <p>PHPMailer is a robust, full-featured email transfer class that handles SMTP authentication, SSL/TLS encryption, and other essential email features.
    </p>

    <h2>1. Installation</h2>
    <p>The recommended way to install PHPMailer is via Composer, the PHP dependency manager: </p>
    <code>composer require phpmailer/phpmailer</code>
    <p>This command downloads the library and creates a vendor/autoload.php file for easy inclusion in your scripts.</p>

    <h2>2. PHP Code Configuration</h2>
    <p>Once installed, you can use the following PHP script as a template. Replace the placeholder values with your actual SMTP server details:</p>

    <code>use PHPMailer\PHPMailer\PHPMailer; <br>
        use PHPMailer\PHPMailer\SMTP;<br>
        use PHPMailer\PHPMailer\Exception;<br>

        require 'vendor/autoload.php';<br>

        $mail = new PHPMailer(true);<br>

        try {<br>
        $mail->SMTPDebug = SMTP::DEBUG_SERVER;<br>
        $mail->isSMTP();<br>
        $mail->Host = 'smtp.example.com'; // Your SMTP server<br>
        $mail->SMTPAuth = true;<br>
        $mail->Username = 'user@example.com'; // Your SMTP username<br>
        $mail->Password = 'secret'; // Your SMTP password<br>
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS; // or PHPMailer::ENCRYPTION_SMTPS<br>
        $mail->Port = 587; // or 465 for SMTPS<br><br>

        $mail->setFrom('from@example.com', 'Mailer Name');<br>
        $mail->addAddress('joe@example.net', 'Joe User');<br>
        $mail->addReplyTo('info@example.com', 'Information');<br><br>

        $mail->isHTML(true);<br>
        $mail->Subject = 'Here is the subject';<br>
        $mail->Body = 'This is the HTML message body <b>in bold!</b>';<br>
        $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';<br><br>

        $mail->send();<br>
        echo 'Message has been sent';<br>
        } catch (Exception $e) {<br>
        echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";<br>
        }<br>
    </code>

    <p>Note: Some 'public' mail services like Gmail require creating an app-specific password if you have 2-step verification enabled.</p>

    <h4>Common SMTP Server Settings</h4>

    <p>Common settings for popular email providers are provided in the table below:</p>


    <p>For Windows environments, you can configure the php.ini file to use a local or remote SMTP server for the mail() function. Locate your php.ini and modify the [mail function] section with your SMTP details.</p>
    ini
    <code>
        SMTP = smtp.example.com<br>
        smtp_port = 587<br>
        sendmail_from = your_email@example.com</code>

    <p>After saving and restarting your web server, you can use the basic mail() function. Keep in mind this method lacks authentication, which is why PHPMailer is generally preferred.</p>
</body>

</html>