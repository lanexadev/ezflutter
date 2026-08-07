# Security rules

- Never commit secrets, tokens, signing material, private keys, production endpoints with credentials, or real personal data.
- Use conspicuous placeholders such as `CHANGE_ME` and document runtime injection through environment/configuration boundaries.
- Validate names and paths before filesystem writes. Reject traversal, symlink escapes, unsafe destinations, and non-empty targets.
- Make generators failure-atomic: stage output, validate it, then move it into place; clean temporary data on failure.
- Treat CLI arguments, config files, network payloads, and deep links as untrusted input.
- Avoid logging credentials, authorization headers, sensitive payloads, or full exception objects that can contain them.
- Pin CI actions to stable major versions or immutable SHAs and minimize workflow permissions.
- Report a suspected vulnerability privately according to `SECURITY.md`; do not open a public exploit issue.
