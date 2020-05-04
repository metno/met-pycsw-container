# CI suggestion

## HowTo make new release

* Update `.github/workflows/docker.yml` with tags.
    * Add new tag.
    * Set environment `LATEST_TAG`.
* Commit all changes to repository.
* Tag repository with same tag as `LATEST_TAG`.
* `git push`
* `git push --tags`

## About CI

* Runs testing on pull requests.
* Build and publish on merge, push to master and tags.
* Build and publish on schedule.

### Docker Hub

* Require username and password to publish image.
* Can utilize personal access tokens.
    * https://hub.docker.com/settings/security

### Github

* Repository have secrets which is not forked.
    * https://github.com/metno/pycsw-container/settings/secrets
