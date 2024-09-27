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
  count = var.create_policy ? 1 : 0

  name               = "${var.service_name}-ExecutionRole-role"
  assume_role_policy = data.aws_iam_policy_document.ecs-role-policy.json
}

resource "aws_iam_role_policy_attachment" "ecs-execution-managed" {
  count = var.create_policy ? 1 : 0

  role       = element(concat(aws_iam_role.ecs-execution.*.id, tolist([""])), var.create_policy ? 0 : 1)
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "task-policy" {
  statement {
    actions   = ["cloudwatch:putMetricData"]
    resources = ["*"]
  }

  dynamic "statement" {
    for_each = var.task_policy_statements
    content {
      actions   = statement.value["actions"]
      resources = statement.value["resources"]
    }
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
  count = var.create_policy ? 1 : 0

  name               = "${var.service_name}-TaskRole-role"
  assume_role_policy = data.aws_iam_policy_document.task-assume-role.json
}

resource "aws_iam_role_policy" "task-role" {
  count = var.create_policy ? 1 : 0

  policy = data.aws_iam_policy_document.task-policy.json
  role   = element(concat(aws_iam_role.task-execution.*.id, tolist([""])), var.create_policy ? 0 : 1)
}
