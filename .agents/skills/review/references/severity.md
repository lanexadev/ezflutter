# Review severity

- **Critical:** likely secret exposure, arbitrary code execution, destructive path escape, or unrecoverable data loss.
- **High:** release-blocking correctness/security defect, broken generated project, or major public contract violation.
- **Medium:** real defect under plausible conditions, architectural boundary leak that creates incorrect behavior, or missing regression coverage for risky logic.
- **Low:** bounded maintainability, diagnostics, documentation, or test-quality problem with concrete impact.

Do not report style preferences already enforced by formatting or analysis. Do not inflate hypothetical risks without a reachable path.
