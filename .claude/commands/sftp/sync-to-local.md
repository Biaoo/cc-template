## Usage

`@sftp sync-to-local <@file-path>`

## Context

- The remote host information is stored in `.vscode/sftp.json`.
- Target file: $ARGUMENTS

## Process

Use `scp` to sync the file from remote server to the local machine.