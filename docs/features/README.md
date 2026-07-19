# Features

Feature specifications live in `docs/features/<feature-name>/`.

## Create a feature pack

Copy templates:

```bash
name="my-feature"
mkdir -p "docs/features/$name"
cp docs/features/_templates/spec.md "docs/features/$name/spec.md"
cp docs/features/_templates/test-plan.md "docs/features/$name/test-plan.md"
cp docs/features/_templates/open-questions.md "docs/features/$name/open-questions.md"
# after review-feature:
# cp docs/features/_templates/review.md "docs/features/$name/review.md"
```

Optional later: `technical-design.md`, `ux.md`.

There is no sample product feature in this kit. Use templates only.
