#!/bin/bash
set -e

# إعداد المتغيرات الأساسية
ARTIFACT="zayed-shield-v1.0.zip"
REPO="github.com/asrar-mrad/zayed-shield"
COMMIT_SHA=$(git rev-parse HEAD)
SHA256=$(sha256sum $ARTIFACT | awk '{print $1}')
RUN_ID=${GITHUB_RUN_ID:-"manual-run"}
RUN_ATTEMPT=${GITHUB_RUN_ATTEMPT:-"1"}
START_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
END_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# إنشاء مجلد .sigstore لو مش موجود
mkdir -p .sigstore

# توليد ملف Provenance
cat > .sigstore/zayed-shield-v1.0.sigstore.json <<EOF
{
  "_type": "https://in-toto.io/Statement/v1",
  "subject": [
    {
      "name": "$ARTIFACT",
      "digest": {
        "sha256": "$SHA256"
      }
    }
  ],
  "predicateType": "https://slsa.dev/provenance/v1",
  "predicate": {
    "buildDefinition": {
      "buildType": "https://github.com/asrar-mrad/zayed-shield/.github/workflows/build.yml",
      "externalParameters": {
        "workflow": "build.yml",
        "repository": "$REPO",
        "ref": "refs/heads/main",
        "trigger": "workflow_dispatch",
        "builder": "github-actions"
      },
      "internalParameters": {
        "os": "ubuntu-latest",
        "run_id": "$RUN_ID",
        "run_attempt": "$RUN_ATTEMPT"
      },
      "resolvedDependencies": [
        {
          "uri": "git+$REPO@refs/heads/main",
          "digest": {
            "gitCommit": "$COMMIT_SHA"
          },
          "name": "guardian-core.js",
          "downloadLocation": "https://$REPO/blob/main/guardian-core.js",
          "mediaType": "application/javascript",
          "annotations": {
            "source": "manual"
          }
        }
      ]
    },
    "runDetails": {
      "builder": {
        "id": "https://github.com/slsa-framework/slsa-github-generator",
        "builderDependencies": [],
        "version": {
          "github-actions": "v3"
        }
      },
      "metadata": {
        "invocationId": "build-$RUN_ID",
        "startedOn": "$START_TIME",
        "finishedOn": "$END_TIME"
      },
      "byproducts": []
    }
  }
}
EOF

echo "✅ Provenance file generated at .sigstore/zayed-shield-v1.0.sigstore.json"
