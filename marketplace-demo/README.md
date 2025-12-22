# Private Demo Ephemeral

Ephemeral version of the Private Demo deployment. Unlike the standard `private_demo`, this deployment has no persistent storage.

## Behavior

- **No EFS volume**: Container data is stored in the ephemeral container filesystem
- **Data loss on restart**: Any configuration or data written to `/config` is lost when the container restarts or redeploys
- **Weekly reset**: An EventBridge Scheduler forces a new deployment every Sunday at 6am CET, resetting all data

## Use Case

This deployment is intended for temporary demo environments where persistent state is not needed and a clean slate is preferred on a regular basis.

## Files

| File | Description |
|------|-------------|
| `main.tf` | ECS service definition using the webservice module |
| `variables.tf` | Input variables (image tag) |
| `scheduler.tf` | Weekly reset schedule via EventBridge Scheduler |
