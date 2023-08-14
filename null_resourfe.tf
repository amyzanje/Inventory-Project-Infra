resource "null_resource" "upload_file" {
provisioner "local-exec" {
    command = <<-EOT
      aws s3 cp ec2_inventory.xlsx s3://${aws_s3_bucket.Inventory_bucket.id}/ec2_inventory.xlsx
    EOT

}
}

