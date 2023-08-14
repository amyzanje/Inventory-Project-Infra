# SES Sender Identity

resource "aws_ses_email_identity" "sender_email" {
  email = var.sender_email
}


# SES Receiver Identity

resource "aws_ses_email_identity" "recipient_emails" {
  for_each = toset(var.recipient_emails)

  email = each.key
}


