# Docker Configuration for Node.js Application

This project includes a Dockerfile for a Strapi instance.

## Instructions

1. **Build the Docker Image**:

   ```bash
   docker compose build --no-cache
   ```

2. **Run the Docker Container**:

   ```bash
   docker compose up -d
   ```

3. **.dockerignore** (Important):

   - Exclude unnecessary files like `.git` and `node_modules`:
     ```
     .git
     node_modules
     *.log
     ```

4. **Default Command**:
   - The container starts in `development` mode:
     ```bash
     pnpm run develop
     ```

## Optimization Tips

- Use `.dockerignore` to prevent unnecessary files from being copied.
- Combine steps in the Dockerfile to reduce image size and build time.
