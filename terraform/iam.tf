data "aws_iam_policy_document" "atlantis_role_arp" {
  statement {
    sid     = "AtlantisAccounts"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = var.atlantis_role_arn_list
      type        = "AWS"
    }
  }
}

resource "aws_iam_role" "atlantis" {
  assume_role_policy = data.aws_iam_policy_document.atlantis_role_arp.json
  name               = "elp-atlantis"
}

resource "aws_iam_role_policy_attachment" "atlantis_admin" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.atlantis.name
}
