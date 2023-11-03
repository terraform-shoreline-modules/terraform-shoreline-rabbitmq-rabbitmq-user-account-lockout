resource "shoreline_notebook" "rabbitmq_user_account_lockout" {
  name       = "rabbitmq_user_account_lockout"
  data       = file("${path.module}/data/rabbitmq_user_account_lockout.json")
  depends_on = [shoreline_action.invoke_reset_user_password]
}

resource "shoreline_file" "reset_user_password" {
  name             = "reset_user_password"
  input_file       = "${path.module}/data/reset_user_password.sh"
  md5              = filemd5("${path.module}/data/reset_user_password.sh")
  description      = "Once the root cause has been identified, take steps to resolve the issue. For example, if the account was locked due to failed login attempts, reset the password or investigate any potential security breaches."
  destination_path = "/tmp/reset_user_password.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_reset_user_password" {
  name        = "invoke_reset_user_password"
  description = "Once the root cause has been identified, take steps to resolve the issue. For example, if the account was locked due to failed login attempts, reset the password or investigate any potential security breaches."
  command     = "`chmod +x /tmp/reset_user_password.sh && /tmp/reset_user_password.sh`"
  params      = ["NEW_PASSWORD","USERNAME"]
  file_deps   = ["reset_user_password"]
  enabled     = true
  depends_on  = [shoreline_file.reset_user_password]
}

