# pycsw

This is MET Norway's base container for pycsw, an OGC CSW server implementation written in Python. For more information about pycsw got to [pycsw.org](https://pycsw.org). For the source code of pycsw got to [gepython/pycsw](https://github.com/geopython/pycsw) on GitHub.

**Highlights**

* Supports both sqlite and postgresql database.
* Using the gunicorn server.

## Tags

* `2.4.2`, `2.4`, `2`, `latest`

## Exposes

* Port `8000` exposes the pycsw service.

## Environment

* `PYCSW_CONFIG` --- path to `pycsw.cfg` config file, default `/etc/pycsw/pycsw.cfg`

## Usage

To run the container as is

    docker run -d -p 8000:8000 -v my_pycsw.cfg:/etc/pycsw/pycsw.cfg:ro metno/pycsw

<!---
# vim: set spell spelllang=en:
-->
