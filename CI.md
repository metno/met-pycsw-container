# CI suggestion

## HowTo make new release

* Update `.github/workflows/docker.yml` with tags.
    * Add new tag.
    * Set environment `LATEST_TAG`.
* Commit to repository.
* Tag repository with same tag as `LATEST_TAG`.
* `git push`
* `git push --tags`

## About

### GitHub Actions

* Testing on pull requests.
* Build and publish on push and tags.
* Build and publish on schedule.

### Docker Hub

* Require username and password to publish image.
* Can utilize personal access tokens.
    * https://hub.docker.com/settings/security

### Github

* Repository can have secrets which is not forked.
    * https://github.com/metno/pycsw-container/settings/secrets
