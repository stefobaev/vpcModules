resource "aws_ecr_repository" "awsEcr" {
    name = "ecr"

    tags = {
        Name = "awsEcr"
    }
}

resource "aws_ecs_cluster" "awsCluster" {
    name = "cluster"

    tags = {
      "Name" = "awsCluster"
    }
}

resource "aws_ecs_task_definition" "awsEcsTaskDefinition" {
    family = "service"
    container_definitions = jsonencode([
        {
        name = "first"
        image = "stefobaev/firstdemo:latest"
        cpu = 128
        memory = 512
        essential = true
        portMappings = [
            {
                containerPort = 80
                hostPort = 80
            }
        ]
        }
    ])
}

resource "aws_ecs_service" "awsEcsService" {
    name = "ecsService"
    cluster = aws_ecs_cluster.awsCluster.id
    task_definition = aws_ecs_task_definition.awsEcsTaskDefinition.id
    launch_type = "EXTERNAL"
    scheduling_strategy = "REPLICA"
    desired_count = 1
    force_new_deployment = true
}
