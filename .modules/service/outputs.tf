output "task_definition" {
  description = "The ARN for the taks definition"
  value       = aws_ecs_task_definition.task.arn
}