output "flask_backend_repo_url" {
  value = aws_ecr_repository.tutedude-backend.repository_url
}

output "express_frontend_repo_url" {
  value = aws_ecr_repository.tutedude-frontend.repository_url
}
