data "aws_iam_policy_document" "ecs-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "ecs-execution" {

  name               = "stun-server-ExecutionRole-role"
  assume_role_policy = data.aws_iam_policy_document.ecs-role-policy.json
}

resource "aws_iam_role_policy_attachment" "ecs-execution-managed" {

  role       = aws_iam_role.ecs-execution.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "task-policy" {
  statement {
    actions   = ["cloudwatch:putMetricData"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "task-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "task-execution" {

  name               = "stun-server-TaskRole-role"
  assume_role_policy = data.aws_iam_policy_document.task-assume-role.json
}

resource "aws_iam_role_policy" "task-role" {

  policy = data.aws_iam_policy_document.task-policy.json
  role   = aws_iam_role.task-execution.id
}
