removed {
  from = module.ap_southeast_1.aws_ecs_cluster.svcs

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.eu_central_1.aws_ecs_cluster.svcs

  lifecycle {
    destroy = false
  }
}
