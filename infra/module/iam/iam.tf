resource "aws_iam_role" "iam_role" {
  name               = "${local.prefix_name}-${var.role_object.name}"
  assume_role_policy = jsonencode(var.role_object.assume_role_policy)
  tags               = var.tags
}

resource "aws_iam_policy" "iam_policy" {
  for_each    = var.map_policy_objects
  name        = "${local.prefix_name}-${each.value.name}"
  description = each.value.description
  policy      = jsonencode(each.value.policy)
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  for_each   = var.map_policy_objects
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy[each.key].arn
  depends_on = [aws_iam_role.iam_role, aws_iam_policy.iam_policy]
}

