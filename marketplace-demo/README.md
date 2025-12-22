# Marketplace Demo

Ephemeral demo deployment with no persistent storage. The deployed image automatically injects the specified users on startup via the `DEFAULT_USERS` environment variable.

## Behavior

- **No EFS volume**: Container data is stored in the ephemeral container filesystem
- **Data loss on restart**: Any configuration or data written to `/config` is lost when the container restarts or redeploys
- **Weekly reset**: An EventBridge Scheduler forces a new deployment every Sunday at 6am CET, resetting all data
- **Automatic user injection**: The container injects users from `DEFAULT_USERS` on each startup

## Use Case

This deployment is intended for marketplace app validation, providing a temporary demo environment where persistent state is not needed and a clean state is preferred on a regular basis.

## Files

| File | Description |
|------|-------------|
| `main.tf` | ECS service definition using the webservice module |
| `variables.tf` | Input variables (image tag, default users) |
| `scheduler.tf` | Weekly reset schedule via EventBridge Scheduler |
