# Marketplace Demo

Ephemeral demo deployment with no persistent storage. The deployed image automatically injects the specified users on startup via the `DEFAULT_USERS` environment variable.

## Behavior

- **No EFS volume**: Container data is stored in the ephemeral container filesystem
- **Data loss on restart**: Any configuration or data written to `/config` is lost when the container restarts or redeploys
- **Bi-weekly reset**: A GitHub Actions workflow in the application repository builds and deploys a new image every other Friday at 7am CET (even ISO week numbers), resetting all data
- **Automatic user injection**: The container injects users from `DEFAULT_USERS` on each startup

## Use Case

This deployment is intended for marketplace app validation, providing a temporary demo environment where persistent state is not needed and a clean state is preferred on a regular basis.

